import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ProductService {
  Future<List<Product>> read() async {
    final url = "https://fakestoreapi.com/products";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Product> data = productFromJson(response.body);
        return data;
      }
      throw Exception("Error status code: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }

  static final Map<int, Product> _cache = {};

  Future<Product?> get(int id, {bool hardRefresh = false}) async {

    if(hardRefresh){
      _cache.remove(id);
    }

    if (_cache.containsKey(id)) {
      return _cache[id];
    } else {
      final url = "https://fakestoreapi.com/products/$id";
      try {
        http.Response response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final item = Product.fromJson(jsonDecode(response.body));
          _cache[id] = item;
          return item;
        }
        throw Exception("Error status code: ${response.statusCode}");
      } catch (e) {
        throw Exception("Error ${e.toString()}");
      }
    }
  }
  
}
