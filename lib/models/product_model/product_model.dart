class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;
  final String unit;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.unit,
    this.rating = 4.5,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'unit': unit,
      'rating': rating,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
      category: json['category'],
      unit: json['unit'],
      rating: json['rating']?.toDouble() ?? 4.5,
    );
  }
}