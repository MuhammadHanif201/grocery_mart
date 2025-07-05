import 'package:flutter/material.dart';
import 'package:grocery_mart_app/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'constants/colors.dart';
import 'providers/product_provider/product_provider.dart';
import 'providers/cart_provider/cart_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'GroceryMart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryGreen,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          fontFamily: 'Poppins',
        ),
        home: HomeScreen(),
      ),
    );
  }
}