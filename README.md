GroceryMart is a Flutter-based mobile application developed for a 3-day intern assessment. It implements core features of an online grocery shopping platform, including product display, shopping cart functionality, and local data persistence using SharedPreferences. The UI is inspired by the provided Figma design, prioritizing clean code, effective state management, and usability.

📱 Features Implemented
✅ Core Features
Home Screen: Displays featured products and 3 categories (Fruits, Vegetables, Snacks).
Product Listing: Shows products with name, price, image, and category filtering.
Shopping Cart:
Add/remove items from the product list.
View cart with item quantities and total price.
Cart data persists across app restarts using SharedPreferences.
Local Product Data:
15 products hardcoded in ProductService (JSON-like structure).
No backend integration required.
✨ Bonus Features (Nice-to-Have)
Product Detail Screen: Basic view with product details (name, price, image, description).
Quantity Adjustment: Increase/decrease item quantities in the cart.
Smooth Navigation: Basic page transitions using Flutter’s Navigator.
🗂️ Project Structure
text



lib/
├── models/              # Data models
│   ├── product.dart     # Product model (id, name, price, image, category)
│   ├── cart_item.dart   # Cart item model (product, quantity)
├── providers/           # State management using Provider
│   ├── cart_provider.dart
│   ├── product_provider.dart
├── services/            # Local services for data handling
│   ├── product_service.dart
│   ├── cart_service.dart
├── screens/             # UI screens
│   ├── home_screen.dart
│   ├── product_list_screen.dart
│   ├── cart_screen.dart
│   ├── product_detail_screen.dart
├── widgets/             # Reusable UI components
│   ├── product_card.dart
│   ├── cart_item_card.dart
├── constants/           # App colors, strings, dummy data
│   ├── app_colors.dart
│   ├── app_string.dart
└── main.dart            # App entry point
🛠️ Technical Details
Framework: Flutter (tested with Flutter 3.32.4)
State Management: Provider (chosen for simplicity and efficient state updates)
Persistence: SharedPreferences for cart data persistence
Dependencies:
yaml



dependencies:
flutter:
sdk: flutter
provider: ^6.0.0
shared_preferences: ^2.0.0
Architecture: Feature-based structure with clear separation of UI, business logic, and data models for maintainability.
🚀 Setup Instructions
Prerequisites:
Flutter SDK (latest stable version, tested with 3.19.x)
Dart
Code editor (e.g., VS Code, Android Studio)
Emulator or physical device (iOS/Android)
Installation:
bash




# Clone the repository
git clone https://github.com/MuhammadHanif201/grocery_mart.git

# Navigate to project directory
cd grocerymart  # Corrected from 'grocery_mart' to match repository name

# Install dependencies
flutter pub get

# Run the app
flutter run
💡 Technical Decisions
State Management: Selected Provider over Bloc for its lightweight setup, ideal for a small-scale app with straightforward cart and product state updates.
Data Storage: Hardcoded 15 products in ProductService to focus on frontend logic, using SharedPreferences for cart persistence to meet requirements.
UI Approach: Prioritized functional, responsive UI inspired by the Figma design, focusing on usability and smooth navigation over pixel-perfect replication.
Architecture: Adopted a feature-based structure to ensure separation of concerns, making the codebase scalable and maintainable.
⚠️ Challenges and Solutions
Challenge: Persisting cart data across app restarts.
Solution: Used SharedPreferences to serialize cart items as JSON, with deserialization on app start. Tested to ensure data retention.
Challenge: Efficient state updates for cart operations.
Solution: Implemented ChangeNotifier in CartProvider to handle add/remove operations reactively, minimizing unnecessary UI rebuilds.
Challenge: Time constraints for implementing bonus features.
Solution: Focused on core features for robust functionality, adding product detail screen and quantity adjustments as time permitted.
⏰ Time Breakdown
Day 1 (8 hours): Analyzed requirements, set up project, created models, and built home screen UI.
Day 2 (8 hours): Developed product list, cart functionality, Provider integration, and cart persistence.
Day 3 (6 hours): Implemented product detail screen, tested features, fixed bugs, and wrote documentation/README.
📚 Learnings
Gained proficiency in using Provider for state management in Flutter.
Improved skills in structuring Flutter projects for clarity and scalability.
Learned to prioritize core features under tight deadlines while maintaining code quality.
Enhanced ability to write clear documentation and meaningful commit messages.#   g r o c e r y _ m a r t 
 
 