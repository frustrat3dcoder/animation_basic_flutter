// In this module we'll be seeing how to trigger chained animation along with curves and clipper
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class ChainedAnimationWithClipper extends StatefulWidget {
  const ChainedAnimationWithClipper({super.key});

  @override
  State<ChainedAnimationWithClipper> createState() =>
      _ChainedAnimationWithClipperState();
}

class _ChainedAnimationWithClipperState
    extends State<ChainedAnimationWithClipper> with TickerProviderStateMixin {
  /// _ccwAnimationController ccw stands for counter clock-wise
  late AnimationController _ccwAnimationController;
  late AnimationController _flipAnimationController;

  late Animation<double> _ccwAnimation;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _ccwAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _flipAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _ccwAnimation =
        Tween<double>(begin: 0, end: -(pi / 2)).animate(CurvedAnimation(
      parent: _ccwAnimationController,
      curve: Curves.bounceOut,
    ));

    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(CurvedAnimation(
      parent: _flipAnimationController,
      curve: Curves.bounceOut,
    ));

    _ccwAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
          begin: _flipAnimationController.value,
          end: _flipAnimation.value + pi,
        ).animate(CurvedAnimation(
          parent: _flipAnimationController,
          curve: Curves.bounceOut,
        ));

        _flipAnimationController
          ..reset()
          ..forward();
      }
    });

    _flipAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _ccwAnimation = Tween<double>(
          begin: _ccwAnimationController.value,
          end: _ccwAnimationController.value + -(pi / 2.0),
        ).animate(CurvedAnimation(
          parent: _ccwAnimationController,
          curve: Curves.bounceOut,
        ));

        _ccwAnimationController
          ..reset()
          ..forward.delayed(const Duration(seconds: 1));
      }
    });
  }

  @override
  void dispose() {
    _ccwAnimationController.dispose();
    _flipAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _ccwAnimationController
      ..reset()
      ..forward.delayed(
        const Duration(
          seconds: 1,
        ),
      );
    return Scaffold(
      body: AnimatedBuilder(
        animation: _ccwAnimationController,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateZ(_ccwAnimation.value),
            child: Row(
              children: [
                AnimatedBuilder(
                  animation: _flipAnimationController,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()
                        ..rotateY(
                          _flipAnimation.value,
                        ),
                      child: ClipPath(
                        clipper: HalfCirclerClipper(side: CircleSide.left),
                        child: Container(
                          color: const Color(0xff0057b7),
                          width: 100,
                          height: 100,
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _flipAnimationController,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()
                        ..rotateY(
                          _flipAnimation.value,
                        ),
                      child: ClipPath(
                        clipper: HalfCirclerClipper(side: CircleSide.right),
                        child: Container(
                          color: const Color(0xffffd700),
                          width: 100,
                          height: 100,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockWise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockWise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockWise = true;
        break;
    }

    path.arcToPoint(
      offset,
      clockwise: clockWise,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
    );

    path.close();

    return path;
  }
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration);
}

class HalfCirclerClipper extends CustomClipper<Path> {
  final CircleSide side;

  HalfCirclerClipper({required this.side});

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
