import 'package:grocery_mart_app/models/product_model/product_model.dart';


class ProductService {
  static List<Product> getAllProducts() {
    return [
      // Fruits
      Product(
        id: '1',
        name: 'Organic Bananas',
        description: 'Fresh organic bananas, perfect for snacking',
        price: 4.99,
        image: 'assets/images/banana.png',
        category: 'Fruits',
        unit: '7pcs, Price',
      ),
      Product(
        id: '2',
        name: 'Red Apple',
        description: 'Apples are nutritious. Apples may be good for weight loss. apples may be good for your heart. As part of a healtful and varied diet.',
        price: 4.99,
        image: 'assets/images/apple.png',
        category: 'Fruits',
        unit: '1kg, Price',
      ),
      Product(
        id: '3',
        name: 'Bell Pepper Red',
        description: 'Fresh red bell peppers',
        price: 4.99,
        image: 'assets/images/bell_paper_red.png',
        category: 'Vegetables',
        unit: '1kg, Price',
      ),
      Product(
        id: '4',
        name: 'Ginger',
        description: 'Fresh ginger root',
        price: 4.99,
        image: 'assets/images/fres_ginger.png',
        category: 'Vegetables',
        unit: '250gm, Price',
      ),
      // Beverages
      Product(
        id: '5',
        name: 'Diet Coke',
        description: 'Coca-Cola diet drink',
        price: 1.99,
        image: 'assets/images/coke_can.png',
        category: 'Beverages',
        unit: '325ml, Price',
      ),
      Product(
        id: '6',
        name: 'Sprite Can',
        description: 'Refreshing lemon-lime soda',
        price: 1.50,
        image: 'assets/images/sprite_can.png',
        category: 'Beverages',
        unit: '325ml, Price',
      ),
      // Dairy
      Product(
        id: '7',
        name: 'Egg Chicken Red',
        description: 'Fresh chicken eggs',
        price: 4.99,
        image: 'assets/images/egg_chicken_red.png',
        category: 'Dairy',
        unit: '4pcs, Price',
      ),
      Product(
        id: '8',
        name: 'Egg Chicken White',
        description: 'Fresh white chicken eggs',
        price: 1.50,
        image: 'assets/images/egg_chicken_white.png',
        category: 'Dairy',
        unit: '1kg, Price',
      ),
      // Snacks
      Product(
        id: '9',
        name: 'Egg Noodles',
        description: 'Delicious instant noodles',
        price: 15.99,
        image: 'assets/images/egg_noodles.png',
        category: 'Snacks',
        unit: '2L, Price',
      ),
      Product(
        id: '10',
        name: 'Mayonnaise Eggless',
        description: 'Creamy eggless mayonnaise',
        price: 15.99,
        image: 'assets/images/mayonnaise_eggless.png',
        category: 'Snacks',
        unit: '325ml, Price',
      ),
    ];
  }

  static List<String> getCategories() {
    return ['Fruits', 'Vegetables', 'Beverages', 'Dairy', 'Snacks'];
  }

  static List<Product> getProductsByCategory(String category) {
    return getAllProducts().where((product) => product.category == category).toList();
  }

  static List<Product> getFeaturedProducts() {
    return getAllProducts().take(4).toList();
  }

  static List<Product> getBestSellingProducts() {
    return getAllProducts().skip(4).take(4).toList();
  }
}