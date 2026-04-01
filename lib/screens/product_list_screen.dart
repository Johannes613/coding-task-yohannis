import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar_field.dart';
import '../widgets/state_views.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _service = ProductService();
  late Future<List<Product>> _future;

  bool _isSearching = false;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _future = _service.fetchProducts();
  }

  void _refresh() => setState(() => _future = _service.fetchProducts());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: _buildAppBar(),
      body: FutureBuilder<List<Product>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView();
          }
          if (snapshot.hasError) {
            return ErrorView(onRetry: _refresh);
          }

          final all = snapshot.data ?? [];
          final filtered = all.where((p) {
            if (_searchQuery.isEmpty) return true;
            final q = _searchQuery.toLowerCase();
            return p.title.toLowerCase().contains(q) ||
                p.brand.toLowerCase().contains(q);
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isSearching)
                SearchBarField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
                child: Text(
                  '${filtered.length} product${filtered.length == 1 ? '' : 's'}',
                  style: const TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(child: _buildList(filtered)),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF2F2F7),
      elevation: 0,
      centerTitle: false,
      title: const Text(
        'Explore',
        style: TextStyle(
          color: Color(0xFF1C1C1E),
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF1C1C1E)),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.search_off_rounded : Icons.search_rounded),
          onPressed: () => setState(() {
            _isSearching = !_isSearching;
            if (!_isSearching) {
              _searchQuery = '';
              _searchController.clear();
            }
          }),
          tooltip: 'Search',
        ),
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed: _refresh,
          tooltip: 'Refresh',
        ),
      ],
    );
  }

  Widget _buildList(List<Product> filtered) {
    if (filtered.isEmpty) return const EmptyView();

    return RefreshIndicator(
      color: const Color(0xFF5E5CE6),
      backgroundColor: const Color(0xFFFFFFFF),
      onRefresh: () async => _refresh(),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.55,
        ),
        itemCount: filtered.length,
        itemBuilder: (_, i) => ProductCard(product: filtered[i]),
      ),
    );
  }
}
