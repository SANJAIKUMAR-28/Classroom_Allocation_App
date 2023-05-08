import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:newlogin/screens/loginpage.dart';
import 'package:flutter/services.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);
    _animationController.forward();
    Timer(Duration(seconds: 3), () =>
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInscrn())));
  }
  @override
  void dispose() {
    _animationController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 280,
              ),
              ScaleTransition(
                scale: _animation,
                child: Image.asset(
                    'assets/bitlogo.png', width: 150, height: 150),

              ),
              SizedBox(
                height: 20,
              ),
              DefaultTextStyle(style: TextStyle(fontFamily: 'Arimo',
                  color: Color.fromRGBO(8, 47, 72, 1),
                  fontWeight: FontWeight.bold,fontSize: 15),
              child:
              AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TyperAnimatedText('W E L C O M E',
                        speed: Duration(milliseconds: 100))
                  ])
              )
            ],
          ),
        )
    );
  }
}
