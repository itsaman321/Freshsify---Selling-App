import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fullName = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();
    final phoneNumber = TextEditingController();
    final cpassword = TextEditingController();
    final address = TextEditingController();
    final dob = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        child: ListView(
          children: <Widget>[
            Container(
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/icon/logo.png',
                      width: 70,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Create New Account ',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        'Enter your detail to get registered',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      WillPopScope(
                        onWillPop: () async => false,
                        child: TextFormField(
                          controller: fullName,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            focusedBorder: InputBorder.none,
                            hintText: 'Full Name',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      WillPopScope(
                        onWillPop: () async => false,
                        child: TextFormField(
                          controller: phoneNumber,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            focusedBorder: InputBorder.none,
                            hintText: 'Phone Number',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      WillPopScope(
                        onWillPop: () async => false,
                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            focusedBorder: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      WillPopScope(
                        onWillPop: () async => false,
                        child: TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            focusedBorder: InputBorder.none,
                            hintText: 'Password',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      WillPopScope(
                        onWillPop: () async => false,
                        child: TextFormField(
                          controller: cpassword,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            focusedBorder: InputBorder.none,
                            hintText: 'Confirm Password',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                          ),
                          onPressed: () async {
                            if (fullName.text != '' &&
                                email.text != '' &&
                                password.text != '' &&
                                phoneNumber.text != '') {
                              if (phoneNumber.text.length < 10) {
                                SnackBar snapBar = SnackBar(
                                    content: Row(
                                  children: [
                                    Icon(Icons.warning),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Enter Valid Phone Number'),
                                  ],
                                ));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snapBar);
                              } else {
                                if (!email.text.contains('@')) {
                                  SnackBar snapBar = SnackBar(
                                      content: Row(
                                    children: [
                                      Icon(Icons.warning),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Enter Valid Email'),
                                    ],
                                  ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snapBar);
                                } else {
                                  final resgisterStatus =
                                      await Provider.of<Auth>(context,
                                              listen: false)
                                          .registerUser(
                                              fullName.text,
                                              email.text,
                                              password.text,
                                              phoneNumber.text,
                                              address.text,
                                              dob.text);
                                  if (resgisterStatus == 0) {
                                    SnackBar snapBar = SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.warning),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('Account Already Exists !'),
                                        ],
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snapBar);
                                  } else {
                                    AlertDialog(
                                      content: Container(
                                        child: Text('Success'),
                                      ),
                                    );

                                    Navigator.of(context).pushNamed(
                                        '/phoneauth',
                                        arguments: phoneNumber.text);
                                  }
                                }
                              }
                            } else {
                              SnackBar snapBar = SnackBar(
                                  content: Row(
                                children: [
                                  Icon(Icons.warning),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Please Fill all details'),
                                ],
                              ));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snapBar);
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
