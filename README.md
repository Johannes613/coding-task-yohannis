# Explore

A modern, beautifully designed product catalog application built with Flutter. **Explore** demonstrates clean UI design principles with a modular architecture, dynamic search functionality, and intricate product detail views.

<img width="327" height="572" alt="Image" src="https://github.com/user-attachments/assets/c2e69a38-8829-4da6-b3fa-fad6a678e264" />
<img width="327" height="572" alt="Image" src="https://github.com/user-attachments/assets/ddaf1324-6fec-4e33-a73b-dc7f4efd2ff0" />
<img width="327" height="572" alt="Image" src="https://github.com/user-attachments/assets/4fcaee25-6d15-47b1-8f69-16112c242e09" />

## Project Structure

The underlying source code is flat and highly organized under the `lib/` directory:

- `models/` - Dart definitions for immutable data transfers (e.g., `Product`, `Review`).
- `services/` - Direct integrations (`api_client.dart` for base HTTP mappings, `product_service.dart` for fetching endpoints).
- `screens/` - Complete UI navigations (`product_list_screen.dart`, `product_detail_screen.dart`).
- `widgets/` - Reusable layout tools (`product_card.dart`, `search_bar_field.dart`, `review_tile.dart`, `info_grid.dart`).

## Getting Started

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

