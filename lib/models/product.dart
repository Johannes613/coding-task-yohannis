import 'review.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final double discountPercentage;

  final int stock;
  final String brand;
  final String category;
  final String description;
  final String thumbnail;
  final List<String> images;
  final String availabilityStatus;
  final String returnPolicy;
  final String shippingInformation;
  final List<Review> reviews;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercentage,

    required this.stock,
    required this.brand,
    required this.category,
    required this.description,
    required this.thumbnail,
    required this.images,
    required this.availabilityStatus,
    required this.returnPolicy,
    required this.shippingInformation,
    required this.reviews,
  });

  double get discountedPrice => price * (1 - discountPercentage / 100);

  bool get hasDiscount => discountPercentage > 0;

  bool get isOutOfStock => availabilityStatus.toLowerCase().contains('out');

  bool get isLowStock => availabilityStatus.toLowerCase().contains('low');

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        title: json['title'] as String,
        price: (json['price'] as num).toDouble(),
        discountPercentage:
            (json['discountPercentage'] as num? ?? 0).toDouble(),

        stock: (json['stock'] as num? ?? 0).toInt(),
        brand: json['brand'] as String? ?? 'Unknown',
        category: json['category'] as String? ?? '',
        description: json['description'] as String? ?? '',
        thumbnail: json['thumbnail'] as String? ?? '',
        images: (json['images'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        availabilityStatus:
            json['availabilityStatus'] as String? ?? 'In Stock',
        returnPolicy: json['returnPolicy'] as String? ?? '',
        shippingInformation: json['shippingInformation'] as String? ?? '',
        reviews: (json['reviews'] as List<dynamic>?)
                ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}
