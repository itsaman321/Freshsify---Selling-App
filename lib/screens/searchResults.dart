import 'package:flutter/material.dart';
import 'package:freshsify/widgets/horizontalProductItem.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<Product> prodList = [];

  @override
  void initState() {
    prodList = Provider.of<Products>(context, listen: false).SearchProdList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(prodList);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Search Results',
          style: TextStyle(color: Colors.black),
        ),
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
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return HorizontalProductItem(
              prodId: prodList[index].id,
              title: prodList[index].title,
              description: prodList[index].description,
              imageUrl: prodList[index].imageUrl,
              price: prodList[index].price,
            );
          },
          itemCount: prodList.length,
        ),
      ),
    );
  }
}
