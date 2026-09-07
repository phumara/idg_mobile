import 'dart:convert';
import 'package:http/http.dart' as http;
import 'platzi_product_model.dart';

class PlatziProductService {

  final base = "https://api.escuelajs.co/api/v1";

  Future<List<PlatziProduct>> read() async {
    final url = "$base/products";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<PlatziProduct> data = platziProductFromJson(response.body);
        return data;
      }
      throw Exception("Error status code: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }


  // Platzi filters server-side: /products/?title=foo returns a bare JSON array
  // of the matching products (not an envelope), already narrowed by title.
  Future<List<PlatziProduct>> searchByTitle(String title) async {
    final query = title.trim();
    if (query.isEmpty) return [];

    final url = "$base/products/?title=${Uri.encodeQueryComponent(query)}";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<PlatziProduct> data = platziProductFromJson(response.body);
        return data;
      }
      throw Exception("Error status code: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }

  static final Map<int, PlatziProduct> _cache = {};

  Future<PlatziProduct?> get(int id, {bool hardRefresh = false}) async {

    if(hardRefresh){
      _cache.remove(id);
    }

    if (_cache.containsKey(id)) {
      return _cache[id];
    } else {
      final url = "$base/products/$id";
      try {
        http.Response response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final item = PlatziProduct.fromJson(jsonDecode(response.body));
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
