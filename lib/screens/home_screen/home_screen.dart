import 'package:flutter/material.dart';
import 'package:grocery_mart_app/screens/cart_screen/cart_screen.dart';
import 'package:grocery_mart_app/screens/product_details_screen/product_detail_screen.dart';
import 'package:grocery_mart_app/widgets/category_card/category_card.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider/product_provider.dart';
import '../../providers/cart_provider/cart_provider.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../widgets/product_card_widget/product_card.dart';
import '../../widgets/custom_bottom_navbar/custom_bottom_navbar.dart';
import '../explore_screen/explore_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeTab(),
    ExploreScreen(),
    CartScreen(),
    Container(), // Favourite placeholder
    Container(), // Account placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  // Define your categories
  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Pulses',
      'image': 'assets/images/pulses.png',
      'color': Color(0xFFF8A44C),
    },
    {
      'title': 'Rice',
      'image': 'assets/images/rice.png',
      'color': Color(0xFF53B175),
    },

  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query.trim();
      _isSearching = query.trim().isNotEmpty;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _isSearching = false;
    });
  }

  // Modified search function to include categories
  Map<String, dynamic> _getSearchResults(ProductProvider productProvider) {
    List<dynamic> allProducts = [
      ...productProvider.featuredProducts,
      ...productProvider.bestSellingProducts,
    ];

    List<dynamic> filteredProducts = [];
    List<Map<String, dynamic>> filteredCategories = [];

    if (_searchQuery.isEmpty) {
      return {
        'products': allProducts,
        'categories': _categories,
      };
    }

    // Filter products
    filteredProducts = allProducts.where((product) {
      return product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (product.category?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
    }).toList();

    // Filter categories
    filteredCategories = _categories.where((category) {
      return category['title'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return {
      'products': filteredProducts,
      'categories': filteredCategories,
    };
  }

  Widget _buildSearchResults(Map<String, dynamic> searchResults) {
    final filteredProducts = searchResults['products'] as List<dynamic>;
    final filteredCategories = searchResults['categories'] as List<Map<String, dynamic>>;
    final totalResults = filteredProducts.length + filteredCategories.length;

    return Column(
      children: [
        // Results count
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '$totalResults results found',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              if (_searchQuery.isNotEmpty) ...[
                Text(
                  ' for "$_searchQuery"',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 20),

        // Categories Section
        if (filteredCategories.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 105,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final category = filteredCategories[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to category products
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExploreScreen(),
                      ),
                    );
                  },
                  child: CategoryCard(
                    title: category['title'],
                    image: category['image'],
                    color: category['color'],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
        ],

        // Products Section
        if (filteredProducts.isNotEmpty) ...[
          if (filteredCategories.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
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
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],

        // No results
        if (filteredProducts.isEmpty && filteredCategories.isEmpty) ...[
          Container(
            padding: EdgeInsets.all(40),
            child: Column(
              children: [
                Icon(
                  Icons.search_off,
                  size: 80,
                  color: AppColors.textSecondary,
                ),
                SizedBox(height: 20),
                Text(
                  'No results found',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Try searching for something else',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],

        SizedBox(height: 30),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final searchResults = _getSearchResults(productProvider);

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Location
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Dhaka, Bangladesh',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Search Bar
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: _performSearch,
                          decoration: InputDecoration(
                            hintText: AppStrings.searchHint,
                            hintStyle: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.textSecondary,
                            ),
                            suffixIcon: _searchQuery.isNotEmpty
                                ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: _clearSearch,
                            )
                                : null,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Results or Default Content
                if (_isSearching) ...[
                  _buildSearchResults(searchResults),
                ] else ...[
                  // Default Home Content
                  // Banner
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage('assets/images/banner.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // Exclusive Offer
                  Column(
                    children: [
                      // Section Header
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.exclusiveOffer,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExploreScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                AppStrings.seeAll,
                                style: TextStyle(
                                  color: AppColors.primaryGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Products Grid
                      Container(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          shrinkWrap: true,
                          itemCount: productProvider.featuredProducts.length,
                          itemBuilder: (context, index) {
                            final product = productProvider.featuredProducts[index];
                            return Container(
                              width: 173,
                              margin: EdgeInsets.only(right: 15),
                              child: ProductCard(
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
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  // Best Selling
                  Column(
                    children: [
                      // Section Header
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.bestSelling,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExploreScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                AppStrings.seeAll,
                                style: TextStyle(
                                  color: AppColors.primaryGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Products Grid
                      Container(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          shrinkWrap: true,
                          itemCount: productProvider.bestSellingProducts.length,
                          itemBuilder: (context, index) {
                            final product =
                            productProvider.bestSellingProducts[index];
                            return Container(
                              width: 173,
                              margin: EdgeInsets.only(right: 15),
                              child: ProductCard(
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
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  // Groceries Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.groceries,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExploreScreen(),
                              ),
                            );
                          },
                          child: Text(
                            AppStrings.seeAll,
                            style: TextStyle(
                              color: AppColors.primaryGreen,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Category Cards
                  Container(
                    height: 105,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      shrinkWrap: true,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExploreScreen(),
                              ),
                            );
                          },
                          child: CategoryCard(
                            title: category['title'],
                            image: category['image'],
                            color: category['color'],
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 30),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

