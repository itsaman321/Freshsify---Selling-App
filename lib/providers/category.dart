import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Category {
  final String id;
  final String name;
  final String imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});
}

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories {
    return _categories;
  }

  Future getCategory() async {
    final url = Uri.parse('http://freshsify.com/freshsify/getCategory.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final categoryData = json.decode(response.body);
      if (_categories.length == 0) {
        categoryData.forEach((e) {
          _categories.add(
              Category(id: e['id'], name: e['name'], imageUrl: e['img_dir']));
        });
      } else {
        return;
      }
      print(_categories);
    }
  }
}
