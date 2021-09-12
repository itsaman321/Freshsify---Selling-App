import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../providers/cart.dart';

class SubCategoryItem extends StatelessWidget {
  final String title;
  final String id;
  final String description;
  final String imageUrl;
  final double price;
  final String category;

  SubCategoryItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/productpage', arguments: id);
      },
      child: Card(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '\$ ${double.parse(
                          price.toString(),
                        ).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Provider.of<Products>(context, listen: false)
                        .toggleFavorite(id);
                  },
                  icon: Icon(
                    Icons.favorite_border,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false)
                        .addItem(id, price, title, imageUrl);
                  },
                  icon: Icon(
                    Icons.shopping_cart_sharp,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
