import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartItem {
  final String id;
  final String prodImage;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.prodImage,
    required this.price,
    required this.quantity,
  });
}

class Coupon {
  final String id;
  final String displayValue;
  final String title;
  final double value;
  final String validity;
  Coupon(
      {required this.id,
      required this.displayValue,
      required this.title,
      required this.value,
      required this.validity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  double discountAmount = 0.0;

  List<Coupon> coupons = [];

  void addItem(String productId, double price, String title, String prodImage) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingProduct) => CartItem(
          id: DateTime.now().toString(),
          title: existingProduct.title,
          prodImage: existingProduct.prodImage,
          price: existingProduct.price,
          quantity: existingProduct.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                prodImage: prodImage,
                price: price,
                quantity: 1,
              ));
    }
    print(_items);
    notifyListeners();
  }

  void increaseQuanity(String productId) {
    _items.update(
      productId,
      (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          prodImage: existingItem.prodImage,
          price: existingItem.price,
          quantity: existingItem.quantity + 1),
    );
    notifyListeners();
  }

  void decreaseQuanity(String productId) {
    _items.update(
      productId,
      (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          prodImage: existingItem.prodImage,
          price: existingItem.price,
          quantity: existingItem.quantity - 1),
    );
    _items.removeWhere((productId, existingItem) => existingItem.quantity == 0);
    notifyListeners();
  }

  Future getCoupons() async {
    coupons = [];
    final url = Uri.parse('http://freshsify.com/freshsify/getCoupons.php');
    final response = await http.post(url);
    final couponData;

    couponData = json.decode(response.body);

    couponData.forEach((e) {
      coupons.add(Coupon(
        id: e['id'],
        displayValue: e['displayValue'],
        title: e['title'],
        value: double.parse(e['value']),
        validity: e['validity'],
      ));
    });
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total +=
          double.parse((cartItem.price).toStringAsFixed(3)) * cartItem.quantity;
    });

    return total;
  }

  int get itemCount {
    return _items.length;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            prodImage: existingCartItem.prodImage,
            quantity: existingCartItem.quantity - 1,
            price: existingCartItem.price),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
