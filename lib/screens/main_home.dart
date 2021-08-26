import 'package:flutter/material.dart';
import 'package:freshsify/providers/category.dart';
import 'package:freshsify/widgets/category_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).categories;
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          // shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Image.asset(
                  'assets/icon/logo.png',
                  width: 100,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: CarouselSlider(
                options: CarouselOptions(height: 180),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.amber),
                        child: Center(
                          child: Text(
                            'text $i',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Categories',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (ctx, index) {
                return CategoryItem(
                    id: categories[index].id,
                    name: categories[index].name,
                    imageUrl: categories[index].imageUrl);
              },
              itemCount: categories.length,
            ),
          ],
        ),
      ),
    );
  }
}
