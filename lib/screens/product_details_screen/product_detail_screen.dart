import 'package:flutter/material.dart';
import 'package:grocery_mart_app/models/product_model/product_model.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider/cart_provider.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),        automaticallyImplyLeading: false,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset('assets/images/icons/share_icon.png'),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Product Image
                    Center(
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        child: Center(
                          child: Image.asset(
                            widget.product.image,
                            height: 250,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Text(
                                'Image not found: ${widget.product.image}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Product Name and Favorite
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.product.name,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              Image.asset('assets/images/icons/favorite_icon.png'),

                            ],
                          ),

                          SizedBox(height: 5),

                          // Product Unit
                          Text(
                            widget.product.unit,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),

                          SizedBox(height: 20),

                          // Quantity and Price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Quantity Controls
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.borderColor),
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$quantity',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.primaryGreen,
                                    ),
                                  ),
                                ],
                              ),

                              // Price
                              Text(
                                '\$${widget.product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 30),

                          Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Color(0XFFE2E2E2B2),
                            ),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.symmetric(horizontal: 0), // remove side padding

                              title: Text(
                                'Product Detail',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      widget.product.description,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),


                          Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Color(0XFFE2E2E2B2),

                            ),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.symmetric(horizontal: 0), // remove side padding

                              title: Text(
                                'Nutritions',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              trailing: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.cardBackground,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  '100gr',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Nutritional information per 100g',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Color(0XFFE2E2E2B2),

                            ),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.symmetric(horizontal: 0), // remove side padding
                              childrenPadding: EdgeInsets.symmetric(horizontal: 0), // remove children padding

                              title: Text(
                                'Review',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...List.generate(5, (index) {
                                    return Icon(
                                      Icons.star,
                                      size: 16,
                                      color: index < widget.product.rating
                                          ? AppColors.orangeColor
                                          : AppColors.borderColor,
                                    );
                                  }),
                                ],
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Great product! Highly recommended.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Add to Basket Button
          Container(
            padding: EdgeInsets.all(20),
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return SizedBox(
                  width: double.infinity,
                  height: 67,
                  child: ElevatedButton(
                    onPressed: () {
                      for (int i = 0; i < quantity; i++) {
                        cartProvider.addToCart(widget.product);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$quantity x ${widget.product.name} added to cart'),
                          backgroundColor: AppColors.primaryGreen,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                    ),
                    child: Text(
                      AppStrings.addToBasket,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}