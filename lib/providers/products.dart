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
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Product getSingleProduct(String prodId) {
    return _items.singleWhere((element) => element.id == prodId);
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
              price: double.parse(e['price']),
              category: e['subcategory'],
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
