import 'package:animation_with_flutter/animations/animated_chained_animation.dart';
import 'package:flutter/material.dart';

import 'animations/animated_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChainedAnimationWithClipper(),
    );
  }
}
