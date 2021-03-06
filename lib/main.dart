import 'package:flutter/material.dart';
import 'package:freshsify/providers/orders.dart';
import 'package:freshsify/screens/cart.dart';
import 'package:freshsify/screens/coupons_page.dart';

import 'package:freshsify/screens/product_display.dart';
import 'package:freshsify/screens/searchResults.dart';
import 'package:freshsify/screens/sub_category.dart';
import 'package:freshsify/screens/sub_category_page.dart';
import './screens/product_page.dart';
import '../providers/category.dart';
import './providers/auth.dart';
import './screens/registerPage.dart';
import './screens/phone_auth.dart';
import './screens/auth_page.dart';
import './screens/homepage.dart';
import './screens/splash_screen.dart';
import './screens/otp_verify.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import './providers/products.dart';
import './providers/cart.dart' show Cart;

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
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(249, 100, 0, 1),
          fontFamily: "Google-Sans",
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black),
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
          '/productpage': (context) => ProductPage(),
          '/subcategory': (context) => SubCategoryScreen(),
          '/productdisplay': (context) => ProductDisplay(),
          '/subcategorypage': (context) => SubCategoryPage(),
          '/searchResult': (context) => SearchResult(),
          '/coupons': (context) => CouponsScreen(),
          '/cart': (context) => CartPage(),
        },
      ),
    );
  }
}
