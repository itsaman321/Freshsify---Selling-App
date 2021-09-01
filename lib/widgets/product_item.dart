import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String isfavorite;

  ProductItem(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.isfavorite});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(242, 242, 242, 1),
                blurRadius: 10,
              ),
            ],
          ),
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
              Container(
                width: 160,
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      description,
                      style: TextStyle(fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border_outlined),
        )
      ],
    );
  }
}
