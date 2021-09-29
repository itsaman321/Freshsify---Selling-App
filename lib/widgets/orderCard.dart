import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:freshsify/providers/cart.dart';
import 'package:freshsify/providers/orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/customer.dart';
import '../models/supplier.dart';
import '../models/invoice.dart';
import '../api/pdf_invoice_api.dart';
import '../api/pdf_api.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatefulWidget {
  final String id;
  final String time;
  final double amount;
  final String userid;
  final String payid;
  final String status;

  OrderCard(
      {required this.id,
      required this.time,
      required this.amount,
      required this.userid,
      required this.payid,
      required this.status});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  var isDelivered = false;

  void delivery(String stat) {
    if (stat == "Order in Process") {
      isDelivered = false;
    } else {
      isDelivered = true;
    }
  }

  @override
  void didChangeDependencies() {
    delivery(widget.status);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 200,
      padding: EdgeInsets.all(14),
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
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.time,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.amount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('Order : '),
              Text(
                widget.id,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            'Order Status',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          isDelivered
              ? Row(
                  children: [
                    Icon(Icons.circle_rounded, color: Colors.lightGreen),
                    Text(widget.status),
                  ],
                )
              : Row(
                  children: [
                    Icon(Icons.timer_rounded, color: Colors.grey),
                    Text(widget.status),
                  ],
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                child: Text('Generate Invoice'),
                onPressed: () {
                  generateInvoice();
                },
              ),
              ElevatedButton(
                child: Text('Contact Us'),
                onPressed: () {
                  // generateInvoice();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void generateInvoice() async {
    final date = DateTime.now();

    final prefs = await SharedPreferences.getInstance();
    final user = jsonDecode(prefs.getString('user').toString());
    final url =
        Uri.parse('http://freshsify.com/freshsify/getOrderedProducts.php');

    final response = await http.post(url, body: {
      'orderid': widget.id,
    });

    final productData = jsonDecode(response.body);
    List<InvoiceItem> productList = [];

    productData.forEach((e) {
      productList.add(InvoiceItem(
        description: e['title'],
        date: DateTime.now(),
        quantity: int.parse(e['quantity']),
        unitPrice: double.parse(e['price']),
      ));
    });

    print(productData);
    final invoice = Invoice(
      supplier: Supplier(
        name: 'Freshsify',
        address: 'Sarah Street 9, Beijing, China',
        paymentInfo: 'https://paypal.me/freshsify',
      ),
      customer: Customer(
        name: user['fullname'],
        address: user['email'],
      ),
      info: InvoiceInfo(
        date: date,
        description: 'order Id : ${widget.id}',
      ),
      items: productList,
    );

    final pdfFile = await PdfInvoiceApi.generate(invoice);
    PdfApi.openFile(pdfFile);
  }
}
