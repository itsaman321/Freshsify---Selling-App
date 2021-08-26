import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});
}

class CategoryProvider with ChangeNotifier {

  List<Category> _categories = [
    Category(id: 'c1', name: 'Fish Zone', imageUrl: 'https://thumbs.dreamstime.com/b/isolated-fish-icon-logo-vector-design-silhouette-white-background-vector-fish-logo-icon-design-106628756.jpg'),
    Category(id: 'c2', name: 'Poultry ', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGFmCiNZaU6jRsNEKtNr0rcpvnMX9V0iUURw&usqp=CAU'),
    Category(id: 'c3', name: 'Tender Meat', imageUrl: 'https://thumbs.dreamstime.com/b/piece-meat-beef-icon-isometric-d-style-isolated-white-background-food-symbol-83177703.jpg'),
    Category(id: 'c4', name: 'Freshly Cut', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQI9XtACiCF-Nk5he9zZrQ7ivEpD0KTXxc4PA&usqp=CAU'),
    Category(id: 'c5', name: 'Combos', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsm89AB0Oeh_ujOpAmjUQVkohbxujq6oUAjA&usqp=CAU'),
  ] ;

  List<Category> get categories {
    return _categories ;
  }


}
