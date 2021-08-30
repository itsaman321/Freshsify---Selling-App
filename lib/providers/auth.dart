import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Map<String, String> registerData = {};

  Future registerUser(String fullname, String email, String password,
      String phoneNumber, String address, String dob) async {
    registerData = {
      'fullname': fullname,
      'email': email,
      'password': password,
      'phonenumber': phoneNumber,
      'address': address,
      'dob': dob,
    };

    final url = Uri.parse('http://freshsify.com/freshsify/register.php');
    final response = await http.post(url, body: registerData);
    if (response.statusCode == 200) {
      if (response.body == 'AlreadyRegistered') {
        return 0;
      } else {
        return 1;
      }
    }
  }

  // ignore: non_constant_identifier_names
  Future SignInPhoneAuthCredentials(
      BuildContext ctx, PhoneAuthCredential phoneAuthCredential) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    final authCredential;
    try {
      final prefs = await SharedPreferences.getInstance();
      final user = json.encode(registerData);

      prefs.setString('user', user);

      print(prefs.get('user'));

      authCredential = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        Navigator.of(ctx).pushReplacementNamed('/homepage');
        print('user loggin in');
      }
    } on FirebaseAuthException catch (e) {
      var snackbar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(ctx).showSnackBar(snackbar);
    }
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    registerData = {};
  }
}
