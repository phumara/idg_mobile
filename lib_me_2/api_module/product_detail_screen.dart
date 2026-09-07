import 'package:flutter/material.dart';
import 'product_service.dart';

import 'product_model.dart';
import 'widget/my_error.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late int _id;

  @override
  Widget build(BuildContext context) {
    _id = ModalRoute.of(context)?.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(title: Text("Product Detail")),
      body: _buildFutureBody(),
    );
  }

  final _service = ProductService();

  late Future<Product?> _futureProduct = _service.get(_id);

  Widget _buildFutureBody() {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _futureProduct = _service.get(_id, hardRefresh: true);
        });
      },
      child: Center(
        child: FutureBuilder<Product?>(
          future: _futureProduct,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return MyError(
                snapshot.error.toString(),
                onPressed: () {
                  setState(() {
                    _futureProduct = _service.get(_id, hardRefresh: true);
                  });
                },
              );
            }

            if (snapshot.connectionState == .done) {
              return _buildListView(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildListView(Product? item) {
    if (item == null) return Center(child: Text("No Item"));

    return ListView(
      padding: EdgeInsets.all(8),
      children: [
        Card(
          child: ListTile(
            leading: Icon(Icons.code),
            title: Text("CODE: ${item.id}"),
          ),
        ),
        Card(
          child: ListTile(leading: Icon(Icons.title), title: Text(item.title)),
        ),
        Card(child: Image.network(item.image, width: double.maxFinite)),
        Card(child: ListTile(title: Text(item.description))),
        Card(
          child: ListTile(
            leading: Icon(Icons.currency_exchange),
            title: Text("USD ${item.price}"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.star),
            title: Text("RATE: ${item.rating.rate} / ${item.rating.count}"),
          ),
        ),
        FilledButton(onPressed: () {}, child: Text("ADD TO CART")),
        SizedBox(height: 100),
      ],
    );
  }
}
