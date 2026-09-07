import 'package:flutter/material.dart';
import 'platzi_product_model.dart';
import 'platzi_product_service.dart';
import 'widgets/my_loading.dart';
import 'ui_config.dart';
import 'widgets/my_error.dart';

class PlatziSearchProductScreen extends StatefulWidget {
  const PlatziSearchProductScreen({super.key});

  @override
  State<PlatziSearchProductScreen> createState() =>
      _PlatziSearchProductScreenState();
}

class _PlatziSearchProductScreenState extends State<PlatziSearchProductScreen> {
  bool _showIcon = false;

  @override
  void initState() {
    super.initState();
    _scroller.addListener(() {
      if (_scroller.position.pixels < 400) {
        setState(() {
          _showIcon = false;
        });
      } else {
        setState(() {
          _showIcon = true;
        });
      }
      
    });
  }

  final _searchCtrl = TextEditingController();

  Widget _buildSearchTextField() {
    return TextField(
      controller: _searchCtrl,
      decoration: InputDecoration(
        icon: Icon(Icons.title),
        hintText: "Search...",
        suffix: IconButton(
          onPressed: () {
            _searchCtrl.clear();
          },
          icon: Icon(Icons.cancel),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _futureData = _service.searchByTitle(_searchCtrl.text.trim());
            });
          },
          icon: Icon(Icons.search),
        ),
      ),
      onSubmitted: (text) {
        setState(() {
          _futureData = _service.searchByTitle(_searchCtrl.text.trim());
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchTextField(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _futureData = _service.searchByTitle(_searchCtrl.text.trim());
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
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

  final _service = PlatziProductService();

  late Future<List<PlatziProduct>> _futureData = _service.searchByTitle(
    _searchCtrl.text.trim(),
  );

  Widget _buildFuture() {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _futureData = _service.searchByTitle(_searchCtrl.text.trim());
        });
      },
      child: FutureBuilder<List<PlatziProduct>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MyError(
              snapshot.error.toString(),
              onPressed: () {
                setState(() {
                  _futureData = _service.searchByTitle(_searchCtrl.text.trim());
                });
              },
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

  final _scroller = ScrollController();

  Widget _buildGridView(List<PlatziProduct>? items) {
    if (items == null) {
      return Center(child: Icon(Icons.list));
    }

    if (items.isEmpty) {
      return Center(child: Text("No Items"));
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
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: .vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/detail", arguments: item.id);
          },
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: .circular(8),
                    child: Image.network(item.images[0], fit: .cover),
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
