import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/cart_item.dart';
import '../providers/cart.dart' show Cart;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final user = {};
  double totalAmount = 0.0;
  Map cartItems = {};
  double discount = 0.0;
  double discountAmount = 0.0;
  double grandTotal = 0.0;

  final _razorpay = Razorpay();

  Map<dynamic, dynamic> orders = {};

  Future initOrder(double amount, String name, String contact,
      String description, String email, String wallet, Map cartItems) async {
    var uuid = Uuid();
    final orderId = uuid.v1().toString();

    List<Map> productDetails = [];

    cartItems.forEach((k, v) {
      productDetails.add({
        'productId': k,
        'quantity': v.quantity,
      });
    });

    orders = {
      'email': email,
      'orderId': orderId,
      'totalamount': amount.toString(),
      'items': json.encode(productDetails),
    };
    dispatchPayment(
        amount.round(), name, orderId, contact, description, email, 'Paytm');
  }

  Future addOrder(String payid) async {
    final url = Uri.parse('http://freshsify.com/freshsify/placeOrder.php');
    final response = await http.post(url, body: {
      'email': orders['email'],
      'orderId': orders['orderId'],
      'payid': payid,
      'totalamount': orders['totalamount'],
      'items': orders['items'],
    });
    print(orders['items']);
    if (response.body == "Success") {
      final snackBar = SnackBar(
        content: Text(
          'Order Placed Successfully',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await addOrder(response.paymentId.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_LONG);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_LONG);
  }

  void dispatchPayment(int amount, String name, String orderId, String contact,
      String description, String email, String wallet) {
    var options = {
      'key': 'rzp_test_fIEG8Lptqn6LvI',
      'amount': amount * 100,
      'name': name,
      'description': description,
      'prefill': {
        'contact': contact,
        'email': email,
      },
      'external': {
        'wallet': [wallet],
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();

        final user = json.decode(prefs.getString('user').toString());
        print(user);
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Yes",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();

        final user = json.decode(prefs.getString('user').toString());

        if (user != null) {
          print(user);
          Navigator.pop(context);
          initOrder(totalAmount, user['fullname'], user['phonenumber'],
              'New Order at Freshsify', user['email'], 'Paytm', cartItems);
        } else {
          Navigator.of(context).pushNamed('/register');
          Fluttertoast.showToast(msg: "Please Login First to Continue");
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(Icons.shopping_bag_outlined),
          SizedBox(
            width: 10,
          ),
          Text(
            "Place Order",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        "Are you confirm you want to place an order with current cart items ?",
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void didChangeDependencies() async {
    discount = 0.0;
    grandTotal = totalAmount;
    totalAmount = Provider.of<Cart>(context).totalAmount;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      discount =
          double.parse(ModalRoute.of(context)!.settings.arguments.toString());
      print(discount);
    }
    setState(() {
      discountAmount = (discount / 100) * totalAmount;
      totalAmount -= (discount / 100) * totalAmount;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    cartItems = Provider.of<Cart>(context).items;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.home_outlined),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: cartItems.isEmpty
            ? Center(
                child: Container(
                  height: 300,
                  width: 300,
                  child: Image.asset(
                    'assets/img/no_item.png',
                    fit: BoxFit.contain,
                  ),
                ),
              )
            : Consumer<Cart>(
                builder: (context, child, value) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      discount == 0.0
                          ? Container()
                          : Container(
                              width: double.infinity,
                              color: Colors.orangeAccent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rs ${discountAmount.toString()} Discount Availed !',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextButton.icon(
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        discountAmount = 0.0;
                                        discount = 0.0;
                                      });
                                      Navigator.of(context)
                                          .popAndPushNamed('/cart');
                                    },
                                    label: Text(
                                      'Remove Coupon',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                      Container(
                        height: 100,
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                Text(
                                  '\Rs. ${Provider.of<Cart>(context).totalAmount.toString()}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            discount == 0.0
                                ? Container()
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Discount ',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '\- \Rs.${discountAmount.toString()}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Grand Total',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '\Rs. ${totalAmount.toString()}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showAlertDialog(context);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          padding: EdgeInsets.all(14),
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'Proceed to Checkout',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).popAndPushNamed('/coupons');
                        },
                        icon: Icon(
                          Icons.local_offer_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          "Apply discount code",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CartItem(
                              id: cartItems.values.toList()[index].id,
                              prodId: cartItems.keys.toList()[index],
                              prodImage:
                                  cartItems.values.toList()[index].prodImage,
                              title: cartItems.values.toList()[index].title,
                              quantity:
                                  cartItems.values.toList()[index].quantity,
                              price: cartItems.values.toList()[index].price,
                            );
                          },
                          itemCount: cartItems.values.toList().length,
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
