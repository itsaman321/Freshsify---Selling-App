import 'package:flutter/material.dart';
import 'package:freshsify/widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDisplay extends StatefulWidget {
  const ProductDisplay({Key? key}) : super(key: key);

  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  var products = [];

  @override
  void didChangeDependencies() {
    products = Provider.of<Products>(context).items;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Our Products',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 280,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (ctx, index) {
            return ProductItem(
                id: products[index].id,
                title: products[index].title,
                imageUrl: products[index].imageUrl,
                description: products[index].description,
                price: products[index].price,
                isfavorite: products[index].isFavorite.toString());
          },
        ),
      ),
    );
  }
}
