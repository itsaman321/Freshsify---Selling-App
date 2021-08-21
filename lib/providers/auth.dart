import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future registerUser(String fullname, String email, String password,
      String phoneNumber, String address, String dob) async {
    Map<String, String> registerData = {
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

  Future SignInPhoneAuthCredentials(
      BuildContext ctx, PhoneAuthCredential phoneAuthCredential) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final authCredential;
    try {
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
}
