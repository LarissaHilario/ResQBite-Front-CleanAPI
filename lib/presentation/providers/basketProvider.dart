import 'package:flutter/material.dart';
import '../../../../domain/models/product_model.dart';

class BasketProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get basketItems => _items;

  void addItem(ProductModel product, int quantity) {
    final existingItemIndex = _items.indexWhere((item) => item['product'].id == product.id);
    if (existingItemIndex >= 0) {
      _items[existingItemIndex]['quantity'] += quantity;
    } else {
      _items.add({
        'product': product,
        'quantity': quantity,
      });
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
  void removeItemById(int productId) {
    basketItems.removeWhere((item) => item['product'].id == productId);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    final product = _items[index]['product'];
    if (_items[index]['quantity'] < product.stock) {
      _items[index]['quantity']++;
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (_items[index]['quantity'] > 1) {
      _items[index]['quantity']--;
      notifyListeners();
    } else {
      removeItem(index);
    }
  }
}
