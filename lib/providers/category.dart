import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Category {
  final String id;
  final String name;
  final String imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});
}

class Subcategory {
  final String id;
  final String name;
  final String imageUrl;
  final String categoryId;

  Subcategory(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.imageUrl});
}

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Subcategory> _subcategories = [];

  List<Subcategory> get subcategories {
    return _subcategories;
  }

  List<Category> get categories {
    return _categories;
  }

  Future getSubCategory(String cid) async {
    _subcategories = [];
    final url = Uri.parse('http://freshsify.com/freshsify/getSubCategory.php');
    final response = await http.post(url, body: {
      'cid': cid,
    });
    if (response.statusCode == 200) {
      final subcategoryData = json.decode(response.body);
      if (_subcategories.length == 0) {
        subcategoryData.forEach((e) {
          _subcategories.add(Subcategory(
              id: e['id'],
              name: e['name'],
              imageUrl: e['imageUrl'],
              categoryId: e['category_id']));
        });
        print(_subcategories);
      } else {
        return;
      }
    }
    notifyListeners();
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
