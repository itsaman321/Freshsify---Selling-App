import 'package:flutter/material.dart';

class OtpVerify extends StatelessWidget {
  const OtpVerify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 249, 252, 1.0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(247, 249, 252, 1),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Container(
        color: Color.fromRGBO(247, 249, 252, 1),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verification',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  'Enter the sent OTP from the Phone you registered !',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  otpBox(context),
                  otpBox(context),
                  otpBox(context),
                  otpBox(context),
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text("Didn't got an OTP ?")),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: () {},
                  child: Text('Submit'),
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

Widget otpBox(
  BuildContext ctx,
) {
  return SizedBox(
    width: 70,
    height: 70,
    child: Container(
      child: TextField(
        keyboardType: TextInputType.number,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 0.1),
          borderRadius: BorderRadius.circular(10)),
    ),
  );
}
