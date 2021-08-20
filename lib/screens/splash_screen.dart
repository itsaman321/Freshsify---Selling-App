import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import './homepage.dart';
import './auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 2), () {
    //   Navigator.of(context).pushReplacementNamed('/homepage');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSplashScreen(
          splashIconSize: 100,
          duration: 1000,
          splash: 'assets/icon/logo.png',
          nextScreen: AuthPage(),
          splashTransition: SplashTransition.scaleTransition),
    );
  }
}
