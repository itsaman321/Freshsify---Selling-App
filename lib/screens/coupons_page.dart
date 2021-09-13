import 'package:flutter/material.dart';
import 'package:freshsify/providers/cart.dart';
import 'package:provider/provider.dart';
import '../widgets/coupon_card.dart';

class CouponsScreen extends StatefulWidget {
  @override
  _CouponsScreenState createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  var isLoading = true;
  List coupons = [];

  
  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<Cart>(context).getCoupons();
    coupons = Provider.of<Cart>(context,listen:false).coupons;
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Discounts',
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return CouponsCard(
                    id: coupons[index].id,
                    displayValue: coupons[index].displayValue,
                    title: coupons[index].title,
                    value: coupons[index].value,
                    validity: coupons[index].validity,
                  );
                },
                itemCount: coupons.length,
              ),
          ),
    );
  }
}
