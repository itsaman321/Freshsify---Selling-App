import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/products.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  final String isfavorite;

  ProductItem(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.price,
      required this.isfavorite});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/productpage', arguments: id);
      },
      child: Container(
        height: 220,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(242, 242, 242, 1),
              blurRadius: 2,
            ),
          ],
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 200,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 30,
              height: 30,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              child: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Provider.of<Cart>(context, listen: false)
                      .addItem(id, price, title, imageUrl);
                },
                icon: Icon(
                  Icons.add,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
