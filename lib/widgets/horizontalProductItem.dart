import 'package:flutter/material.dart';
import 'package:freshsify/providers/cart.dart';
import 'package:provider/provider.dart';

class HorizontalProductItem extends StatelessWidget {
  final String prodId;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  HorizontalProductItem({
    required this.prodId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: double.infinity,
          height: 95,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(242, 242, 242, 1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          double.parse(price.toString()).toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: 30,
                height: 30,
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false)
                        .addItem(prodId, price, title, imageUrl);
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
      ),
    );
  }
}
