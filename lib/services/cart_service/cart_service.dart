import 'dart:convert';
import 'package:grocery_mart_app/models/cart_items_model/cart_items_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const String _cartKey = 'cart_items';

  static Future<void> saveCart(List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = cartItems.map((item) => item.toJson()).toList();
    await prefs.setString(_cartKey, jsonEncode(cartJson));
  }

  static Future<List<CartItem>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString(_cartKey);

    if (cartString != null) {
      final cartJson = jsonDecode(cartString) as List;
      return cartJson.map((item) => CartItem.fromJson(item)).toList();
    }

    return [];
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}