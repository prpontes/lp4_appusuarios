import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/item_venda.dart';

class ShoppingCartProvider extends ChangeNotifier {
  List<ItemVenda> items = [
    ItemVenda(id: 1, price: 10.0),
  ];

  void add(ItemVenda item) {
    items.add(item);
    notifyListeners();
  }

  void remove(ItemVenda item) {
    items.remove(item);
    notifyListeners();
  }

  double get totalPrice {
    return items.fold(0, (total, current) => total + current.price);
  }

  int get totalItems {
    return items.fold(0, (total, current) => total + current.quantity);
  }

  void clear() {
    items = [];
    notifyListeners();
  }

  List<ItemVenda> get getItems {
    return [...items];
  }

  void increment(ItemVenda item) {
    item.quantity++;
    notifyListeners();
  }

  void decrement(ItemVenda item) {
    item.quantity--;
    if (item.quantity == 0) {
      remove(item);
    }
    notifyListeners();
  }

  void setQuantity(ItemVenda item, int quantity) {
    item.quantity = quantity;
    if (item.quantity == 0) {
      remove(item);
    }
    notifyListeners();
  }
}
