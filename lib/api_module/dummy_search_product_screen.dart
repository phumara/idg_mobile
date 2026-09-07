import 'package:flutter/material.dart';
import 'dummy_product_model.dart';
import 'dummy_product_service.dart';
import 'widgets/my_loading.dart';
import 'ui_config.dart';
import 'widgets/my_error.dart';

class DummySearchProductScreen extends StatefulWidget {
  const DummySearchProductScreen({super.key});

  @override
  State<DummySearchProductScreen> createState() => _DummySearchProductScreenState();
}

class _DummySearchProductScreenState extends State<DummySearchProductScreen> {
  bool _showIcon = false;

  @override
  void initState() {
    super.initState();
    _scroller.addListener(() {
      final show = _scroller.position.pixels >= 400;
      if (show != _showIcon) {
        setState(() {
          _showIcon = show;
        });
      }
    });
  }

  @override
  void dispose() {
    _scroller.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  final _searchCtrl = TextEditingController();

  void _search() {
    setState(() {
      _futureData = _service.searchByTitle(_searchCtrl.text.trim());
    });
  }

  Widget _buildSearchTextField() {
    return TextField(
      controller: _searchCtrl,
      decoration: InputDecoration(
        icon: Icon(Icons.title),
        hintText: "Search...",
        suffixIcon: Row(
          mainAxisSize: .min,
          children: [
            IconButton(
              onPressed: () {
                _searchCtrl.clear();
              },
              icon: Icon(Icons.cancel),
            ),
            IconButton(onPressed: _search, icon: Icon(Icons.search)),
          ],
        ),
      ),
      onSubmitted: (text) {
        _search();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchTextField(),
        actions: [IconButton(onPressed: _search, icon: Icon(Icons.refresh))],
      ),
      body: _buildFuture(),
      floatingActionButton: _showIcon ? _buildFloating() : null,
    );
  }

  Widget _buildFloating() {
    return FloatingActionButton(
      onPressed: () {
        _scroller.animateTo(
          0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: Icon(Icons.arrow_upward),
    );
  }

  final _service = DummyProductService();

  late Future<List<DummyProduct>> _futureData = _service.searchByTitle(
    _searchCtrl.text.trim(),
  );

  Widget _buildFuture() {
    return RefreshIndicator(
      onRefresh: () async {
        _search();
        await _futureData;
      },
      child: FutureBuilder<List<DummyProduct>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _scrollable(
              MyError(snapshot.error.toString(), onPressed: _search),
            );
          }

          if (snapshot.connectionState == .done) {
            return _buildGridView(snapshot.data);
          } else {
            return MyLoading(
              context,
              padding: padding,
              landscapeGrid: landscapeGrid,
              portraitGrid: portraitGrid,
              gridRatio: gridRatio,
            );
          }
        },
      ),
    );
  }

  // RefreshIndicator only reacts to a scrollable child, so the empty/error
  // states get wrapped in one that always fills the viewport.
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

  final _scroller = ScrollController();

  Widget _buildGridView(List<DummyProduct>? items) {
    if (items == null) {
      return _scrollable(Icon(Icons.list));
    }

    if (items.isEmpty) {
      return _scrollable(Text("No Items"));
    }

    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return GridView.builder(
      controller: _scroller,
      padding: .all(padding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: padding,
        crossAxisSpacing: padding,
        crossAxisCount: landscape ? landscapeGrid : portraitGrid,
        childAspectRatio: gridRatio,
      ),
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      scrollDirection: .vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/dummy-detail", arguments: item.id);
          },
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: .circular(8),
                    child: Image.network(item.thumbnail, fit: .cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  child: Text(item.title, maxLines: 1, overflow: .ellipsis),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  child: Text(
                    "US\$ ${item.price}",
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
