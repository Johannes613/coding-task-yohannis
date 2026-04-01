import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/info_grid.dart';
import '../widgets/review_tile.dart';


class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _imageIndex = 0;
  final _pageController = PageController();

  Product get _p => widget.product;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: CustomScrollView(
        slivers: [
          _buildImageAppBar(),
          SliverToBoxAdapter(child: _buildBody()),
        ],
      ),
    );
  }

  SliverAppBar _buildImageAppBar() {
    final allImages = _p.images.isNotEmpty ? _p.images : [_p.thumbnail];

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: const Color(0xFFF2F2F7),
      leading: _BackButton(),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: allImages.length,
              onPageChanged: (i) => setState(() => _imageIndex = i),
              itemBuilder: (_, i) => _GalleryImage(url: allImages[i]),
            ),
            if (allImages.length > 1)
              _DotIndicators(
                count: allImages.length,
                current: _imageIndex,
              ),
            if (_p.hasDiscount)
              Positioned(
                top: 0,
                right: 16,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: _DiscountRibbon(percent: _p.discountPercentage),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BrandCategoryRow(product: _p),
          const SizedBox(height: 8),
          _TitleText(title: _p.title),
          const SizedBox(height: 10),
          _StatusRow(product: _p),
          const SizedBox(height: 16),
          _PriceDisplay(product: _p),
          const SizedBox(height: 20),
          _SectionTitle('Description'),
          const SizedBox(height: 8),
          Text(
            _p.description,
            style: const TextStyle(
              color: Color(0xFF8E8E93),
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          InfoGrid(product: _p),
          const SizedBox(height: 24),
          if (_p.reviews.isNotEmpty) ...[
            _SectionTitle('Reviews (${_p.reviews.length})'),
            const SizedBox(height: 12),
            ..._p.reviews.map((r) => ReviewTile(review: r)),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF).withValues(alpha: 0.8),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          color: Color(0xFF1C1C1E),
        ),
      ),
    );
  }
}

class _GalleryImage extends StatelessWidget {
  final String url;

  const _GalleryImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.image_not_supported_rounded,
          size: 60,
          color: Color(0xFF8E8E93),
        ),
      ),
    );
  }
}

class _DotIndicators extends StatelessWidget {
  final int count;
  final int current;

  const _DotIndicators({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (i) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == current ? 18 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: i == current
                  ? const Color(0xFF5E5CE6)
                  : Colors.black26,
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }),
      ),
    );
  }
}

class _DiscountRibbon extends StatelessWidget {
  final double percent;

  const _DiscountRibbon({required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3B30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '-${percent.toStringAsFixed(0)}% OFF',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _BrandCategoryRow extends StatelessWidget {
  final Product product;

  const _BrandCategoryRow({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          product.brand.toUpperCase(),
          style: const TextStyle(
            color: Color(0xFF5E5CE6),
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFE5E5EA)),
          ),
          child: Text(
            product.category,
            style: const TextStyle(
              color: Color(0xFF8E8E93),
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}

class _TitleText extends StatelessWidget {
  final String title;

  const _TitleText({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF1C1C1E),
        fontSize: 22,
        fontWeight: FontWeight.w800,
        height: 1.2,
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final Product product;

  const _StatusRow({required this.product});

  @override
  Widget build(BuildContext context) {
    final Color statusColor;
    if (product.isOutOfStock) {
      statusColor = const Color(0xFFFF3B30);
    } else if (product.isLowStock) {
      statusColor = const Color(0xFFFF9F0A);
    } else {
      statusColor = const Color(0xFF34C759);
    }

    return Row(
      children: [
        Text(
          '${product.reviews.length} reviews',
          style: const TextStyle(
            color: Color(0xFF8E8E93),
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            product.availabilityStatus,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _PriceDisplay extends StatelessWidget {
  final Product product;

  const _PriceDisplay({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '\$${product.discountedPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Color(0xFF1C1C1E),
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        if (product.hasDiscount) ...[
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Color(0xFF8E8E93),
                fontSize: 16,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF1C1C1E),
        fontSize: 17,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
