import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/item_venda.dart';

class ShoppingCartProvider extends ChangeNotifier {
  List<ItemVenda> items = [];

  void add(ItemVenda item) {
    if (hasProduct(item.produto!.id!)) {
      increment(items.firstWhere((i) => i.produto!.id == item.produto!.id));
    } else {
      items.add(item);
    }
    notifyListeners();
  }

  void remove(ItemVenda item) {
    items.remove(item);
    notifyListeners();
  }

  int getQuantity(String id) {
    if (hasProduct(id)) {
      return items.firstWhere((element) => element.produto?.id == id).quantity;
    }
    return 0;
  }

  bool hasProduct(String productId) {
    return items.indexWhere((item) => item.produto?.id == productId) != -1;
  }

  double get totalPrice {
    return items.fold(
        0.0, (total, item) => total + (item.price * item.quantity));
  }

  int get totalItems {
    return items.fold(0, (total, current) => total + current.quantity);
  }

  int get totalIndividualItems {
    return items.fold(0, (total, current) => total + 1);
  }

  void clear() {
    items = [];
    notifyListeners();
  }

  List<ItemVenda> get getItems {
    return [...items];
  }

  void increment(ItemVenda item) {
    if (item.quantity < item.produto!.quantity) {
      item.quantity++;
      notifyListeners();
    }
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
