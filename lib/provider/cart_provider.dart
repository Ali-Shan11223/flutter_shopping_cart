import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  // Creating two variables for counter and totalPrice
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  //Setting counter and totalPrice in sharedPreferences
  void setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    setPrefItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    getPrefItems();
    return _counter;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice += productPrice;
    setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice -= productPrice;
    setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    getPrefItems();
    return _totalPrice;
  }
}
