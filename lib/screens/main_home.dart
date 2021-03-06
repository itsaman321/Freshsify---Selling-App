import 'package:flutter/material.dart';
import 'package:freshsify/providers/category.dart';
import 'package:freshsify/providers/products.dart';
import 'package:freshsify/widgets/category_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../widgets/product_item.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List categories = [];
  List products = [];
  List bestSeller = [];
  var isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      if (categories.isEmpty && products.isEmpty && bestSeller.isEmpty) {
        setState(() {
          isLoading = true;
        });
        await Provider.of<CategoryProvider>(context, listen: false)
            .getCategory();
        categories =
            Provider.of<CategoryProvider>(context, listen: false).categories;
        await Provider.of<Products>(context, listen: false).getProducts();

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    categories = Provider.of<CategoryProvider>(context).categories;
    products = Provider.of<Products>(context, listen: false).items;
    bestSeller = Provider.of<Products>(context, listen: false).bestSellerItems;
    return SafeArea(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              child: ListView(
                primary: true,
                // shrinkWrap: true,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 100,
                    padding: EdgeInsets.all(15),
                    child: Image.asset('assets/icon/logo.png', width: 30),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: 150,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 2)),
                      items: [1, 2].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 2.0),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                'assets/img/$i.png',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // padding: EdgeInsets.all(25),
                      // shrinkWrap: true,
                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //   crossAxisCount: 3,
                      //   crossAxisSpacing: 15,
                      //   mainAxisSpacing: 15,
                      // ),
                      itemBuilder: (ctx, index) {
                        return CategoryItem(
                            id: categories[index].id,
                            name: categories[index].name,
                            imageUrl: categories[index].imageUrl);
                      },
                      itemCount: categories.length,
                    ),
                  ),
                  Container(
                    child: Text(
                      'Best Selling Products',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return ProductItem(
                          id: bestSeller[index].id,
                          title: bestSeller[index].title,
                          imageUrl: bestSeller[index].imageUrl,
                          price: bestSeller[index].price,
                          description: bestSeller[index].description,
                          isfavorite: bestSeller[index].isFavorite.toString(),
                        );
                      },
                      itemCount: bestSeller.length,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'All Products',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/productdisplay');
                        },
                        child: Container(
                          child: Text(
                            'View All',
                            style: TextStyle(
                              color: Color.fromRGBO(249, 100, 0, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return ProductItem(
                          id: products[index].id,
                          title: products[index].title,
                          imageUrl: products[index].imageUrl,
                          price: products[index].price,
                          description: products[index].description,
                          isfavorite: products[index].isFavorite.toString(),
                        );
                      },
                      itemCount: products.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
