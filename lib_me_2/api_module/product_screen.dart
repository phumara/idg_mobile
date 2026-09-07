import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';
import 'ui_config.dart';
import 'widget/my_loading.dart';
import 'widget/my_error.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}


class _ProductScreenState extends State<ProductScreen> {
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
      floatingActionButton: _showIcon ? _buildFloating() : null,
      //body: _buildSampleSkeleton(),
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

  Widget _buildFloating() {
    return FloatingActionButton(
      onPressed: (){
        _scroller.animateTo(0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        );
      },
       
      child: Icon(Icons.arrow_upward),
    );
  }
  
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
              return  MyError(snapshot.error.toString(), onPressed: (){});
              
            }

            if (snapshot.connectionState == .done) {
              //return _buildGridView(snapshot.data);
              return _buildGridView(snapshot.data);
            } else {
              return MyLoading(context,
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

  // Widget _buildError(String error) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Column(
  //       mainAxisAlignment: .center,
  //       children: [
  //         Icon(Icons.error, size: 50),
  //         Text("Error: $error"),
  //         FilledButton(
  //           onPressed: () {
  //             setState(() {
  //               _futureData = _fakeReading();
  //             });
  //           },
  //           child: Text("RETRY"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  //  Widget _buildLoading() {
  //   bool landscape =
  //       MediaQuery.of(context).orientation == Orientation.landscape;

  //   return Skeletonizer(
  //     child: GridView.builder(
  //       padding: .all(padding),
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         mainAxisSpacing: padding,
  //         crossAxisSpacing: padding,
  //         crossAxisCount: landscape ? landscapeGrid : portraitGrid,
  //         childAspectRatio: gridRatio,
  //       ),
  //       physics: BouncingScrollPhysics(),
  //       shrinkWrap: true,
  //       scrollDirection: .vertical,
  //       itemCount: 20,
  //       itemBuilder: (context, index) {
  //         return Card(
  //           child: Column(
  //             children: [
  //               Expanded(
  //                 child: ClipRRect(
  //                   borderRadius: .circular(8),
  //                   child: Container(),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                   vertical: 8,
  //                   horizontal: 4,
  //                 ),
  //                 child: Text(
  //                   "asdsadsdas dsa das das da",
  //                   maxLines: 1,
  //                   overflow: .ellipsis,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                   vertical: 8,
  //                   horizontal: 4,
  //                 ),
  //                 child: Text(
  //                   "sadsa das ds d as",
  //                   maxLines: 1,
  //                   overflow: .ellipsis,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

final _scroller = ScrollController();


  Widget _buildGridView(List<Map<String, dynamic>>? items) {

    if (items == null) {
      return Icon(Icons.list);
    }

    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return GridView.builder(
      controller: _scroller,
      padding: .all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: padding,
        crossAxisSpacing: padding,
        crossAxisCount: landscape ? landscapeGrid : portraitGrid,
        childAspectRatio: gridRatio, //x / y
      ),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: .vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/detail", arguments: item['id']);
          },
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: .circular(8),
                    child: Image.network(item['image'], fit: .cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  child: Text(item['title'], maxLines: 1, overflow: .ellipsis),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  child: Text(
                    "US\$ ${item['price']}",
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

  Widget _buildSampleSkeleton(){
    return Skeletonizer(
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.face),
              title: Text("Some text sadasd sadas das dwwwwwwwwwwwwwwwwwwwwwwwwwwww"),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.face),
              title: Text("Some text  343434 434343 eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"),
            ),
          ),
        ],
      ),
    );
  }

}
