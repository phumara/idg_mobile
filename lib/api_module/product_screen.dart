import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Screen"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _futureData = _fakeReading();
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildFuture(),
    );
  }

  Future<List<Map<String, dynamic>>> _fakeReading() async {
    final url = "https://fakestoreapi.com/products";
    try {
      http.Response response = await http.get(Uri.parse(url));
      //200: success
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        List<Map<String, dynamic>> data = list
            .map((x) => x as Map<String, dynamic>)
            .toList();
        return data;
      }
      throw Exception("Error status code: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }

  late Future<List<Map<String, dynamic>>> _futureData = _fakeReading();

  Widget _buildFuture() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureData = _fakeReading();
          });
        },
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.error, size: 50),
                    Text("Error: ${snapshot.error.toString()}"),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _futureData = _fakeReading();
                        });
                      },
                      child: Text("RETRY"),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.connectionState == .done) {
              return _buildGridView(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>>? items) {

    if (items == null) {
      return Icon(Icons.list);
    }

    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return GridView.builder(
      padding: .all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: landscape ? 4 : 2,
        childAspectRatio: 4 / 5, //x / y
      ),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: .vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: .circular(8),
                  child: Image.network(item['image'], fit: .cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text(item['title'], maxLines: 1, overflow: .ellipsis),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text("US\$ ${item['price']}", maxLines: 1, overflow: .ellipsis),
              ),
            ],
          ),
        );
      },
    );
  }
}
