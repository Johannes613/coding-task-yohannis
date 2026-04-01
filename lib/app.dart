import 'package:flutter/material.dart';

import 'models/product.dart';
import 'screens/product_detail_screen.dart';
import 'screens/product_list_screen.dart';
import 'widgets/product_card.dart';

class ExploreApp extends StatelessWidget {
  const ExploreApp({super.key});

  @override
  Widget build(BuildContext context) {
    ProductCardRouter.detailBuilder =
        (Product p) => ProductDetailScreen(product: p);

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explore',
      home: ProductListScreen(),
    );
  }
}
