import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuth extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final route = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      // backgroundColor: Color.fromRGBO(247, 249, 252, 1),
      body: Container(
        color: Color.fromRGBO(247, 249, 252, 1),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
              'assets/icon/logo.png',
              width: 125,
            ),
            Column(children: [
              TextFormField(
                initialValue: route.toString(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: InputBorder.none,
                  hintText: 'Enter Your Phone Number',
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: () async {
                    await _auth.verifyPhoneNumber(
                      phoneNumber: route.toString(),
                      verificationCompleted: (phoneAuthCredential) async {},
                      verificationFailed: (verificationFailed) async {},
                      codeSent: (verificationId, resendingToken) async {},
                      codeAutoRetrievalTimeout: (verificationId) async {},
                    );
                    Navigator.of(context).pushNamed('/verify');
                  },
                  child: Text('Verify'),
                ),
              ),
            ]),
            RichText(
              text: TextSpan(
                text: 'You don’t have an account?',
                style: TextStyle(color: Colors.black87),
                children: const <TextSpan>[
                  TextSpan(
                    text: ' Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(249, 100, 0, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}