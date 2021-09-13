import 'package:flutter/material.dart';

class RecentItem extends StatelessWidget {
  final String title;
  RecentItem({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.replay_rounded,
                color: Colors.grey,
              ),
              SizedBox(
                width: 10,
              ),
              Text(title),
            ],
          ),
          Icon(
            Icons.arrow_forward,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
