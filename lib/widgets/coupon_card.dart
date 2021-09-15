import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshsify/providers/cart.dart';
import 'package:provider/provider.dart';

class CouponsCard extends StatelessWidget {
  final String id;
  final String displayValue;
  final String title;
  final double value;
  final String validity;

  CouponsCard(
      {required this.id,
      required this.displayValue,
      required this.title,
      required this.value,
      required this.validity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
        height: 100,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    displayValue,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Fluttertoast.showToast(msg: 'Coupon Applied !');
                          Navigator.of(context)
                              .popAndPushNamed('/cart', arguments: value);
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              "Redeem",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            border: Border.all(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(
                    validity,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
