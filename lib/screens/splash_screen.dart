import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './homepage.dart';
import './auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var userSignedIn = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0),() async{
        final prefs =  await SharedPreferences.getInstance() ;
        if(prefs.getString('user') !=null){
          setState(() {
            userSignedIn = true ;
          });
        }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSplashScreen(
          splashIconSize: 100,
          duration: 1000,
          splash: 'assets/icon/logo.png',
          nextScreen:userSignedIn ? Homepage() : AuthPage(),
          splashTransition: SplashTransition.scaleTransition),
    );
  }
}
