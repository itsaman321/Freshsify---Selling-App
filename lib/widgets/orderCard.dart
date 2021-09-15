import 'package:flutter/material.dart';

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
                child: Text('Cancel Order'),
                onPressed: () {},
              ),
              ElevatedButton(
                child: Text('Contact Us'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
