import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;

  CategoryItem({required this.id, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black26),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Text(name),
        ],
      ),
    );
  }
}
