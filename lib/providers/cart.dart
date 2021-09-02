import 'package:flutter/material.dart';

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

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

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
    _items.removeWhere((productId, existingItem)=> existingItem.quantity == 0);
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += double.parse((cartItem.price).toStringAsFixed(3)) * cartItem.quantity;
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
