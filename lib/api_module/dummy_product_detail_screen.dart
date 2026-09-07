import 'package:flutter/material.dart';
import 'dummy_product_model.dart';
import 'dummy_product_service.dart';

import 'widgets/my_error.dart';

class DummyProductDetailScreen extends StatefulWidget {
  const DummyProductDetailScreen({super.key});

  @override
  State<DummyProductDetailScreen> createState() => _DummyProductDetailScreenState();
}

class _DummyProductDetailScreenState extends State<DummyProductDetailScreen> {
  final _service = DummyProductService();

  int? _id;
  Future<DummyProduct?>? _futureProduct;

  // The route argument is only readable once the route is attached, so the
  // first load starts here rather than in a field initializer.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)?.settings.arguments as int?;
    if (id != _id) {
      _id = id;
      _load();
    }
  }

  void _load({bool hardRefresh = false}) {
    final id = _id;
    setState(() {
      _futureProduct = id == null
          ? Future.value(null)
          : _service.get(id, hardRefresh: hardRefresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Detail")),
      body: _buildFutureBody(),
    );
  }

  Widget _buildFutureBody() {
    return RefreshIndicator(
      onRefresh: () async {
        _load(hardRefresh: true);
        await _futureProduct;
      },
      child: FutureBuilder<DummyProduct?>(
        future: _futureProduct,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _scrollable(
              MyError(
                snapshot.error.toString(),
                onPressed: () => _load(hardRefresh: true),
              ),
            );
          }

          if (snapshot.connectionState == .done) {
            return _buildListView(snapshot.data);
          } else {
            return _scrollable(CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // RefreshIndicator only reacts to a scrollable child, so the loading and
  // error states get one that always fills the viewport.
  Widget _scrollable(Widget child) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(child: child),
          ),
        );
      },
    );
  }

  Widget _buildListView(DummyProduct? item) {
    if (item == null) return _scrollable(Text("No Item"));

    return ListView(
      padding: EdgeInsets.all(8),
      physics: AlwaysScrollableScrollPhysics(),
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
        if (item.images.isNotEmpty)
          Card(child: Image.network(item.images.first, width: double.maxFinite)),
        Card(child: ListTile(title: Text(item.description))),
        Card(
          child: ListTile(
            leading: Icon(Icons.currency_exchange),
            title: Text("USD ${item.price}"),
          ),
        ),
        FilledButton(onPressed: () {}, child: Text("ADD TO CART")),
        SizedBox(height: 100),
      ],
    );
  }
}
