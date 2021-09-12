import 'package:flutter/material.dart';
import 'package:freshsify/providers/category.dart';
import 'package:freshsify/widgets/product_sub.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({Key? key}) : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  List allProducts = [];
  List subProduct = [];

  var arg;
  @override
  void initState() {
    Future.delayed(
        Duration(
          seconds: 0,
        ),
        () {});
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    arg = ModalRoute.of(context)!.settings.arguments.toString();
    print(arg);
    allProducts = Provider.of<Products>(context, listen: false).items;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    subProduct =
        allProducts.where((element) => element.category == arg).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return SubCategoryItem(
                id: subProduct[index].id,
                category: subProduct[index].category,
                title: subProduct[index].title,
                description: subProduct[index].description,
                imageUrl: subProduct[index].imageUrl,
                price: subProduct[index].price);
          },
          itemCount: subProduct.length,
        ),
      ),
    );
  }
}
