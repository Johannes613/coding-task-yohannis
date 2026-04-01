import '../models/product.dart';
import 'api_client.dart';

class ProductService {
  final ApiClient _api;

  ProductService({ApiClient? api}) : _api = api ?? ApiClient();

  Future<List<Product>> fetchProducts({int limit = 100}) async {
    final body = await _api.get('/products', queryParams: {
      'limit': '$limit',
    });
    final list = body['products'] as List<dynamic>;
    return list
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
