# This folder is used for the animated_builder and transforming object learning
# Animated Builder with transform note :-
<!-- /// [AnimatedBuilderTransform] is a class that represents the classic
/// example of Animated Builder with Transform class with Matrix4 property
///_animationController is a instance of a controller that allows
///you to perform animation. vsync refers to vertical sync that
///refers to the refresh rate of the current screen provided by SingleTickerProviderStateMixin.
///_animation currently used is of type double which is required for
///calculation for your custom animation behaviour. Other option is Offset
/// Alignment is to be used when you're sure from where  you want  to align it
/// alternatively we can use origin which needs offset
/// problem with using origin is be sure that you know the correct height and width for which
/// it is beign attached to because for width and height offset(50,50) may represent center
/// but with heigth and width of 200 or 300 it will be in somewhere near the topleft
/// Here Matrix4.identity() is basically Offset.zero and then we cascade it to the
/// rotation that we want. rotateY allows you to spin the card in rotation horizontally from front to back
/// with  rotationX it allows you to flip it vertically and rotationZ allows you to spin the child like
/// circular roullete -->

# Animated chained animation, curves and clippers note: -
1. Animation are the series of event that take place from one point to another.
2. Break the whole complex animation into series of simpler animation which does one thing at a time.
3. In Flutter Canvas X-Axis is width and Y-Axis is heigth and  in trignometry (X,Y) =>   =>  while Canvas start from    (X,Y)___
                                                                                      |___                                 |
                                                                                      (X,Y)
4. While dealing with "Path" in flutter canvas make sure to close the path when it's completed.                                                                                                        
5. All the curves animation reference:- https://api.flutter.dev/flutter/animation/Curves-class.html
6. After breaking down while performing chained animation make sure that you've triggered the chained only when one event is completed
7. Always make sure to dispose the controllers
