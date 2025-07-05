import 'package:flutter/material.dart';
import 'package:grocery_mart_app/models/cart_items_model/cart_items_model.dart';

import '../../constants/colors.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemCard({
    Key? key,
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 70,
            height: 70,
            child: Center(
              child:
              Image.asset(
                cartItem.product.image, // Use asset path from product.image
                fit: BoxFit.cover, // Adjusts image to fit container
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: AppColors.textSecondary); // Fallback if image fails to load
                },
              ),
            ),
          ),

          SizedBox(width: 15),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  cartItem.product.unit,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quantity Controls
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (cartItem.quantity > 1) {
                              onQuantityChanged(cartItem.quantity - 1);
                            }
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.borderColor),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Icon(
                              Icons.remove,
                              color: AppColors.textSecondary,
                              size: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          '${cartItem.quantity}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            onQuantityChanged(cartItem.quantity + 1);
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.borderColor),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Icon(
                              Icons.add,
                              color: AppColors.primaryGreen,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Price and Remove
                    Row(
                      children: [
                        Text(
                          '\$${cartItem.product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(width: 15),
                        GestureDetector(
                          onTap: onRemove,
                          child: Icon(
                            Icons.close,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}