import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final String time;
  final double amount;
  final String userid;
  final String payid;
  final String status;

  OrderItem(
      {required this.time,
      required this.id,
      required this.amount,
      required this.userid,
      required this.payid,
      required this.status});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  String status(int status) {
    if (status == 1) {
      return 'Order in Process';
    } else {
      return 'Delivered';
    }
  }

  Future getOrders(String email) async {
    _orders = [];
    final url = Uri.parse('http://freshsify.com/freshsify/getOrder.php');
    final response = await http.post(url, body: {
      'email': email,
    });
    final orderData = json.decode(response.body);
    orderData.forEach((e) {
      _orders.add(
        OrderItem(
          id: e['id'],
          time: e['time'],
          amount: double.parse(e['amount']),
          userid: e['userid'],
          payid: e['payid'],
          status: status(
            int.parse(e['status']),
          ),
        ),
      );
    });
  }
}
