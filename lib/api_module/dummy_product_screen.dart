import 'package:flutter/material.dart';
import 'dummy_product_model.dart';
import 'dummy_product_service.dart';
import 'widgets/my_loading.dart';
import 'ui_config.dart';
import 'widgets/my_error.dart';

class DummyProductScreen extends StatefulWidget {
  const DummyProductScreen({super.key});

  @override
  State<DummyProductScreen> createState() => _DummyProductScreenState();
}

class _DummyProductScreenState extends State<DummyProductScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dummy Product Screen"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _futureData = _service.read();
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

  final _service = DummyProductService();

  late Future<List<DummyProduct>> _futureData = _service.read();

  Widget _buildFuture() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureData = _service.read();
          });
        },
        child: FutureBuilder<List<DummyProduct>>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return MyError(
                snapshot.error.toString(),
                onPressed: () {
                  setState(() {
                    _service.read();
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
      ),
    );
  }

  final _scroller = ScrollController();

  Widget _buildGridView(List<DummyProduct>? items) {
    if (items == null) {
      return Icon(Icons.list);
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
          onTap: (){
            Navigator.of(context).pushNamed("/dummy-detail", arguments: item.id);
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
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(item.title, maxLines: 1, overflow: .ellipsis),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
