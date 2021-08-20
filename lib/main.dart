import 'package:flutter/material.dart';
import './providers/auth.dart';
import './screens/registerPage.dart';
import './screens/phone_auth.dart';
import './screens/auth_page.dart';
import './screens/homepage.dart';
import './screens/splash_screen.dart';
import './screens/otp_verify.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(249, 100, 0, 1),
          fontFamily: "Quicksand",
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black),
            headline2: TextStyle(fontSize: 15),
          ),
          iconTheme: IconThemeData(
            color: Color.fromRGBO(249, 100, 0, 1),
          ),
        ),
        home: SplashScreen(),
        routes: {
          '/homepage': (context) => Homepage(),
          '/auth': (context) => AuthPage(),
          '/phoneauth': (context) => PhoneAuth(),
          '/verify': (context) => OtpVerify(),
          '/register': (context) => Register(),
        },
      ),
    );
  }
}
