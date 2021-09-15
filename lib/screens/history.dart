import 'package:flutter/material.dart';
import 'package:freshsify/providers/orders.dart';
import 'package:freshsify/widgets/orderCard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List orders = [];
  var isLoading = true;
  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    if (user != null) {
      final userId = json.decode(user.toString())['email'];
      await Provider.of<Orders>(context, listen: false).getOrders(userId);
      orders = Provider.of<Orders>(context, listen: false).orders;
    } else {}
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return OrderCard(
                      id: orders[index].id,
                      time: orders[index].time,
                      amount: orders[index].amount,
                      userid: orders[index].userid,
                      payid: orders[index].payid,
                      status: orders[index].status,
                    );
                  },
                  itemCount: orders.length,
                ),
              ),
            ),
          );
  }
}
