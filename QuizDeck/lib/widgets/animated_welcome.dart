import 'package:flutter/material.dart';

class AnimatedWelcome extends StatefulWidget {
  const AnimatedWelcome({Key? key}) : super(key: key);

  @override
  _AnimatedWelcomeState createState() => _AnimatedWelcomeState();
}

class _AnimatedWelcomeState extends State<AnimatedWelcome>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 0.01), end: Offset.zero)
              .animate(_animationController),
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/welcome-background.png",
              height: 200,
            ),
          ),
        ),
        SlideTransition(
          position: Tween<Offset>(begin: Offset.zero, end: Offset(0, 0.01))
              .animate(_animationController),
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/welcome.png",
              height: 180,
            ),
          ),
        ),
      ],
    );
  }
}
