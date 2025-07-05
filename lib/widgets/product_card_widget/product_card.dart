import 'package:flutter/material.dart';
import 'package:grocery_mart_app/models/product_model/product_model.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider/cart_provider.dart';
import '../../constants/colors.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              boxShadow:[
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: Offset(0, 6)
                )
              ],
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderColor),
            ),



            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Expanded(
                  child: Center(
                    child:
                    Image.asset(
                      product.image,
                      // width: 100,
                      // height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Text('Error: $error'),
                    )
                  ),
                ),
                SizedBox(height: 12),
                // Product Name
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                // Product Unit
                Text(
                  product.unit,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 12),
                // Price and Add Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cartProvider.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} added to cart'),
                            backgroundColor: AppColors.primaryGreen,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Container(
                        width: 45.67,
                        height: 45.67,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Icon(
                          Icons.add,
                          color: AppColors.whiteColor,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}