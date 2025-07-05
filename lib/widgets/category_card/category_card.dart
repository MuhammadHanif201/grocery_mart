import 'package:flutter/material.dart';
import 'package:grocery_mart_app/constants/colors.dart';
class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final Color color;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.image,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}