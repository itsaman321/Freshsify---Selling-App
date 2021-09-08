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
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2,vertical: 3),
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 228,
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
