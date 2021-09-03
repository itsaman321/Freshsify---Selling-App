import 'package:flutter/material.dart';
import 'package:freshsify/providers/cart.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var productDetails;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prodId = ModalRoute.of(context)!.settings.arguments;
    print(prodId);
    productDetails = Provider.of<Products>(context, listen: false)
        .getSingleProduct(prodId.toString());
    print(productDetails);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(productDetails.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(productDetails.title.toString(),
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                  Text(
                      double.parse(productDetails.price.toString())
                          .toStringAsFixed(2),
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16),child: Text(productDetails.description)),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Provider.of<Cart>(context,listen: false).addItem(
              productDetails.id,
              productDetails.price,
              productDetails.title,
              productDetails.imageUrl);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 12,
          ),
          width: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black26,
              )
            ],
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(60),
          ),
          child: Row(children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            Text(
              'Add to Cart',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }
}
