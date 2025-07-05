import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider/cart_provider.dart';
import '../../constants/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryGreen,
      unselectedItemColor: AppColors.textSecondary,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/icons/shop_icon.png'),
          activeIcon: Image.asset('assets/images/icons/shop_icon.png'),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/icons/explore_icon.png'),
          activeIcon: Image.asset('assets/images/icons/explore_icon.png'),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  Icon(Icons.shopping_cart_outlined),
                  if (cartProvider.totalItems > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(

                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, -5),
                              spreadRadius: 0,
                              blurRadius: 15,
                              color: Colors.white
                            )
                          ],
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cartProvider.totalItems}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          activeIcon: Image.asset('assets/images/icons/cart_icon.png'),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/icons/favorite_icon.png'),
          activeIcon: Image.asset('assets/images/icons/favorite_icon.png'),
          label: 'Favourite',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/icons/user_icon.png'),
          activeIcon:Image.asset('assets/images/icons/user_icon.png'),
          label: 'Account',
        ),
      ],
    );
  }
}
