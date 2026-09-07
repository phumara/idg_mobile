import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dummy_product_model.dart';

class DummyProductService {

  final base = "https://dummyjson.com/products";

  Future<List<DummyProduct>> read() async {
    final url = base;
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw _statusError(response.statusCode);
      }
      List<DummyProduct> data = dummyProductFromJson(response.body);
      return data;
    } on Exception {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // dummyjson has a single search endpoint (/products/search?q=) and it matches
  // the query against title, description and tags only -- NOT category, so
  // "beauty" or "furniture" legitimately come back empty. There is no
  // title-only or description-only filter, so do not drop the rows it returns.
  Future<List<DummyProduct>> _search(String query) async {
    final url = "$base/search?q=${Uri.encodeQueryComponent(query)}";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw _statusError(response.statusCode);
      }
      List<DummyProduct> data = dummyProductFromJson(response.body);
      return data;
    } on Exception {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Everything the API matched is kept; rows whose [field] actually contains
  // the query are just moved to the front so the closest hits read first.
  List<DummyProduct> _titleFirst(
    List<DummyProduct> data,
    String query,
    String Function(DummyProduct) field,
  ) {
    final needle = query.toLowerCase();
    final hits = <DummyProduct>[];
    final rest = <DummyProduct>[];
    for (final item in data) {
      if (field(item).toLowerCase().contains(needle)) {
        hits.add(item);
      } else {
        rest.add(item);
      }
    }
    return [...hits, ...rest];
  }

  Future<List<DummyProduct>> searchByTitle(String title) async {
    final query = title.trim();
    if (query.isEmpty) return [];

    final data = await _search(query);
    return _titleFirst(data, query, (item) => item.title);
  }

  Future<List<DummyProduct>> searchByDescription(String description) async {
    final query = description.trim();
    if (query.isEmpty) return [];

    final data = await _search(query);
    return _titleFirst(data, query, (item) => item.description);
  }

  Exception _statusError(int statusCode) {
    if (statusCode == 429) {
      return Exception("Too many requests -- wait a few seconds and try again.");
    }
    return Exception("Error status code: $statusCode");
  }

  static final Map<int, DummyProduct> _cache = {};

  Future<DummyProduct?> get(int id, {bool hardRefresh = false}) async {

    if(hardRefresh){
      _cache.remove(id);
    }

    if (_cache.containsKey(id)) {
      return _cache[id];
    } else {
      final url = "$base/$id";
      try {
        http.Response response = await http.get(Uri.parse(url));
        if (response.statusCode != 200) {
          throw _statusError(response.statusCode);
        }
        final item = DummyProduct.fromJson(jsonDecode(response.body));
        _cache[id] = item;
        return item;
      } on Exception {
        rethrow;
      } catch (e) {
        throw Exception(e.toString());
      }
    }
  }
  
}
