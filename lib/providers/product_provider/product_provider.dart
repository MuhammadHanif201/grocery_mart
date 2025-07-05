import 'package:flutter/foundation.dart';
import 'package:grocery_mart_app/models/product_model/product_model.dart';
import '../../services/product_service/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _featuredProducts = [];
  List<Product> _bestSellingProducts = [];
  String _selectedCategory = 'All';
  bool _isLoading = false;

  List<Product> get products => _products;
  List<Product> get featuredProducts => _featuredProducts;
  List<Product> get bestSellingProducts => _bestSellingProducts;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  List<String> get categories => ['All', ...ProductService.getCategories()];

  ProductProvider() {
    loadProducts();
  }

  void loadProducts() {
    _isLoading = true;
    notifyListeners();

    _products = ProductService.getAllProducts();
    _featuredProducts = ProductService.getFeaturedProducts();
    _bestSellingProducts = ProductService.getBestSellingProducts();

    _isLoading = false;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    if (category == 'All') {
      _products = ProductService.getAllProducts();
    } else {
      _products = ProductService.getProductsByCategory(category);
    }
    notifyListeners();
  }

}