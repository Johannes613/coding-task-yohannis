# 🌍 Explore

A modern, beautifully designed product catalog application built with Flutter. **Explore** demonstrates clean UI design principles with a modular architecture, dynamic search functionality, and intricate product detail views.

## ✨ Features

- **Product Listing:** A clean layout displaying products fetched dynamically from an external API (`dummyjson.com/products`).
- **Dynamic Search:** Instantly interact with the catalog by filtering products by title or brand using a sleek, integrated search bar.
- **Detailed Product Views:** 
  - Swipeable image galleries showcasing diverse product shots.
  - Granular pricing information including clear and visual discount markers.
  - Detailed grids illustrating product stock levels, shipping terms, and return policies.
  - Full review cards displaying customer feedback and sentiment.
- **State-of-the-Art Aesthetics:** Carefully crafted typography, dynamic micro-animations, and integrated components styled directly in-place without the need for external theme constants.
- **Robust Architecture:** Strict decoupling into `api_client`, services, immutable models, robust screens, and modular widgets ensures elite testability and simplified maintenance.

## 🗂️ Project Structure

The underlying source code is flat and highly organized under the `lib/` directory:

- `models/` - Dart definitions for immutable data transfers (e.g., `Product`, `Review`).
- `services/` - Direct integrations (`api_client.dart` for base HTTP mappings, `product_service.dart` for fetching endpoints).
- `screens/` - Complete UI navigations (`product_list_screen.dart`, `product_detail_screen.dart`).
- `widgets/` - Reusable layout tools (`product_card.dart`, `search_bar_field.dart`, `review_tile.dart`, `info_grid.dart`).

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and properly configured.

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Johannes613/coding-task-yohannis.git
   cd coding-task-yohannis
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the Application:**
   Connect an emulator or physical device, then execute:
   ```bash
   flutter run
   ```

## 🧪 Testing

The app comes bundled with unit and widget tests to guarantee reliability. 

```bash
flutter test
```

## 🛠️ Technology Stack

- **Framework:** Flutter (Dart)
- **Data Provider:** [DummyJSON](https://dummyjson.com/) 
- **Networking:** Native Dart `http` package
