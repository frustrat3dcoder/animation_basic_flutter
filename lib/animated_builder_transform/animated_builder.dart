import 'package:flutter/material.dart';
import 'dart:math' show pi;

/// [AnimatedBuilderTransform] is a class that represents the classic
/// example of Animated Builder with Transform class with Matrix4 property
class AnimatedBuilderTransform extends StatefulWidget {
  const AnimatedBuilderTransform({super.key});

  @override
  State<AnimatedBuilderTransform> createState() =>
      _AnimatedBuilderTransformState();
}

class _AnimatedBuilderTransformState extends State<AnimatedBuilderTransform>
    with SingleTickerProviderStateMixin {
  ///_animationController is a instance of a controller that allows
  ///you to perform animation. vsync refers to vertical sync that
  ///refers to the refresh rate of the current screen provided by SingleTickerProviderStateMixin.
  late AnimationController _animationController;

  ///_animation currently used is of type double which is required for
  ///calculation for your custom animation behaviour. Other option is Offset
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation =
        Tween<double>(begin: 0.0, end: 2 * pi).animate(_animationController);

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: AnimatedBuilder(
            animation: _animationController,
            builder: ((context, child) {
              return Transform(
                /// Alignment is to be used when you're sure from where  you want  to align it
                /// alternatively we can use origin which needs offset
                /// problem with using origin is be sure that you know the correct height and width for which
                /// it is beign attached to because for width and height offset(50,50) may represent center
                /// but with heigth and width of 200 or 300 it will be in somewhere near the topleft
                alignment: Alignment.center,

                /// Here Matrix4.identity() is basically Offset.zero and then we cascade it to the
                /// rotation that we want. rotateY allows you to spin the card in rotation horizontally from front to back
                /// with  rotationX it allows you to flip it vertically and rotationZ allows you to spin the child like
                /// circular roullete
                transform: Matrix4.identity()..rotateZ(_animation.value),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 5,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );
            })),
      ),
    );
  }
}
