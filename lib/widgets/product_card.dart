import 'package:flutter/material.dart';

import '../models/product.dart';


class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE5E5EA)),
        ),
        child: Row(
          children: [
            _buildThumbnail(),
            Expanded(child: _buildInfo()),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _DetailRouter(product: product),
      ),
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(18),
        bottomLeft: Radius.circular(18),
      ),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: const Color(0xFFFFFFFF)),
            Image.network(
              product.thumbnail,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.image_not_supported_rounded,
                color: Color(0xFF8E8E93),
              ),
            ),
            if (product.hasDiscount)
              Positioned(
                top: 6,
                left: 6,
                child: _DiscountBadge(percent: product.discountPercentage),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.brand,
            style: const TextStyle(
              color: Color(0xFF5E5CE6),
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF1C1C1E),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                '\$${product.discountedPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xFF1C1C1E),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (product.hasDiscount) ...[
                const SizedBox(width: 6),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
              const Spacer(),
              _StockBadge(product: product),
            ],
          ),
        ],
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  final double percent;

  const _DiscountBadge({required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3B30),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '-${percent.toStringAsFixed(0)}%',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _StockBadge extends StatelessWidget {
  final Product product;

  const _StockBadge({required this.product});

  @override
  Widget build(BuildContext context) {
    final Color color;
    final String label;

    if (product.isOutOfStock) {
      color = const Color(0xFFFF3B30);
      label = 'Out';
    } else if (product.isLowStock) {
      color = const Color(0xFFFF9F0A);
      label = 'Low';
    } else {
      color = const Color(0xFF34C759);
      label = 'In Stock';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DetailRouter extends StatelessWidget {
  final Product product;

  const _DetailRouter({required this.product});

  @override
  Widget build(BuildContext context) {
    return _ProductDetailScreenProxy(product: product);
  }
}

class _ProductDetailScreenProxy extends StatelessWidget {
  final Product product;

  const _ProductDetailScreenProxy({required this.product});

  @override
  Widget build(BuildContext context) {
    final builder = ProductCardRouter.detailBuilder;
    assert(builder != null,
        'ProductCardRouter.detailBuilder must be set before navigation.');
    return builder!(product);
  }
}

abstract final class ProductCardRouter {
  static Widget Function(Product)? detailBuilder;
}
