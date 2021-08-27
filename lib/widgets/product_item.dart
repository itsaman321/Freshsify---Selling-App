import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
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
                child: Image.network(
                  'https://i.pinimg.com/originals/ed/64/a8/ed64a82cc8de3a46b2567d8a0074a18a.jpg',
                  width: 160,
                  fit: BoxFit.cover,
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
                      'Food',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Address the nation',
                      style: TextStyle(fontSize: 10),
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
