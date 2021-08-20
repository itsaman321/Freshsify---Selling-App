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
      print('added');
    }
  }
}
