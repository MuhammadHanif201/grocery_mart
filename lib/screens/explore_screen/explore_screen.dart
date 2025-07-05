import 'package:flutter/material.dart';
import 'package:grocery_mart_app/screens/product_details_screen/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider/product_provider.dart';
import '../../constants/colors.dart';
import '../../widgets/product_card_widget/product_card.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase().trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Find Products',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final filteredProducts = productProvider.products.where((product) {
            final matchesCategory = productProvider.selectedCategory == 'All' ||
                product.category.toLowerCase() ==
                    productProvider.selectedCategory.toLowerCase();
            final matchesSearch = product.name.toLowerCase().contains(_searchQuery);
            return matchesCategory && matchesSearch;
          }).toList();

          return Column(
            children: [
              // Search Bar
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Store',
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textSecondary,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              // Category Filter
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: productProvider.categories.length,
                  itemBuilder: (context, index) {
                    final category = productProvider.categories[index];
                    final isSelected =
                        productProvider.selectedCategory == category;

                    return GestureDetector(
                      onTap: () {
                        productProvider.setCategory(category);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryGreen
                              : AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),

              // Products Grid
              Expanded(
                child: filteredProducts.isEmpty
                    ? Center(
                  child: Text(
                    'No products found',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                )
                    : GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
