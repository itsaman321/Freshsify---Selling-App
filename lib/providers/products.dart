import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  bool isFavorite;
  bool bestSeller;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.imageUrl,
    this.isFavorite = false,
    this.bestSeller = false,
  });
}

class Products extends ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   category: 'c1',
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Denim Shirt',
    //   description: 'A Denim shirt - it is pretty Blue!',
    //   price: 50.00,
    //   category: 'c1',
    //   imageUrl:
    //       'https://image.freepik.com/free-photo/portrait-handsome-smiling-stylish-young-man-model-wearing-jeans-clothes-fashion-man_158538-5025.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Checked Shirt',
    //   description: 'A Checked shirt - it is pretty dasded!',
    //   price: 10.88,
    //   category: 'c1',
    //   imageUrl:
    //       'https://previews.123rf.com/images/photosvit/photosvit1908/photosvit190802039/129246014-menswear-and-fashionable-clothing-man-looks-handsome-in-casual-style-guy-with-bristle-wear-casual-ou.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Coat',
    //   category: 'c1',
    //   description: 'A Coat shirt - it is pretty red!',
    //   price: 100,
    //   imageUrl:
    //       'https://cf.ltkcdn.net/mens-fashion/images/orig/45866-280x420-Casual_category.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  bool boolResult(double value) {
    if (value == 1) {
      return true;
    } else if (value == 0) {
      return false;
    } else {
      return false;
    }
  }

  Future getProducts() async {
    final url = Uri.parse('http://freshsify.com/freshsify/getproducts.php');
    final response = await http.get(url);
    List<Product> loadedItems = [];
    if (response.statusCode == 200) {
      final productData = json.decode(response.body);
      if (_items.length == 0) {
        productData.forEach((e) {
          loadedItems.add(
            Product(
              id: e['id'],
              title: e['title'],
              price:double.parse(e['price']),
              category: e['category_id'],
              description: e['description'],
              imageUrl: e['imageurl'],
              isFavorite: boolResult(double.parse(e['favorite'])),
              bestSeller: boolResult(double.parse(e['bestseller'])),
            ),
          );
        });
      } else {
        return;
      }
      _items = loadedItems;
      notifyListeners();
      print(_items);
    }
  }

  List<Product> get bestSellerItems {
    return _items.where((prodItem) => prodItem.bestSeller).toList();
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }
}
