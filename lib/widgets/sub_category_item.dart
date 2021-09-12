import 'package:flutter/material.dart';

class SubcategoryItem extends StatelessWidget {
  final String id;
  final String name;
  final String categoryId;
  final String imageUrl;

  SubcategoryItem(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/subcategorypage',arguments: id);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(242, 242, 242, 1),
                    blurRadius: 10,
                  ),
                ],
              ),
              height: 140,
              width: 140,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            Text(name),
          ],
        ),
      ),
    );
  }
}
