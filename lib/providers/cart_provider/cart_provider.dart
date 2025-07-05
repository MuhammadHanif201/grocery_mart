import 'package:flutter/foundation.dart';
import 'package:grocery_mart_app/models/cart_items_model/cart_items_model.dart';
import 'package:grocery_mart_app/models/product_model/product_model.dart';
import '../../services/cart_service/cart_service.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];
  bool _isLoading = false;

  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  int get totalItems => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  CartProvider() {
    loadCart();
  }

  Future<void> loadCart() async {
    _isLoading = true;
    notifyListeners();

    _cartItems = await CartService.loadCart();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addToCart(Product product) async {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }

    await CartService.saveCart(_cartItems);
    notifyListeners();
  }

  Future<void> removeFromCart(String productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
    await CartService.saveCart(_cartItems);
    notifyListeners();
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = quantity;
      }
      await CartService.saveCart(_cartItems);
      notifyListeners();
    }
  }

  Future<void> clearCart() async {
    _cartItems.clear();
    await CartService.clearCart();
    notifyListeners();
  }

  bool isInCart(String productId) {
    return _cartItems.any((item) => item.product.id == productId);
  }

  int getQuantity(String productId) {
    final item = _cartItems.firstWhere(
          (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product(id: '', name: '', description: '', price: 0, image: '', category: '', unit: ''), quantity: 0),
    );
    return item.quantity;
  }
}