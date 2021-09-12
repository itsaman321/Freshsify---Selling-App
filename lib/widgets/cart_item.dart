import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;

  final String prodId;
  final String prodImage;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.prodId,
      required this.prodImage,
      required this.title,
      required this.quantity,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(242, 242, 242, 1),
              blurRadius: 7,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: double.infinity,
        height: 95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(prodImage),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16,),
                      ),
                      Text(
                        double.parse(price.toString()).toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<Cart>(context, listen: false)
                              .decreaseQuanity(prodId);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(
                            '-',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          quantity.toString(),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                      ),
                      InkWell(
                        onTap: () {
                          Provider.of<Cart>(context, listen: false)
                              .increaseQuanity(prodId);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(
                            '+',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ],
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
