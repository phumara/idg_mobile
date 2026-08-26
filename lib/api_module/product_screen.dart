// // import 'package:flutter/material.dart';

// // class ProductScreen extends StatefulWidget {
// //   const ProductScreen({super.key});

// //   @override
// //   State<ProductScreen> createState() => _ProductScreenState();
// // }

// // class _ProductScreenState extends State<ProductScreen> {

// //   int sum(int a, int b){
// //     return a + b;
// //   }

// //   Future<int> add(int a, int b){
// //     return Future.value(a + b);
// //   }

// //   void hello(String name){
// //     debugPrint("hello $name");
// //   }

// //   Future<void> hi(String name) async{
// //     debugPrint("hi $name");
// //   }

// // Future<String>_fakeReading() async{
// // await Future.delayed(Duration(seconds: 2));
// // return "Hello World";
// // }

// // Widget _buildFuture(){
// //   return Center(child: CircularProgressIndicator());
// // }

// //   @override
// //   Widget build(BuildContext context) {
    
// //     // int s = sum(10, 20);
// //     // debugPrint("s = $s");

// //     // add(20, 30).then((a){
// //     //   debugPrint("a = $a");
// //     // });
    
// //     // hello("Sok");
// //     // hi("Sok");


// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Product Screen"),
      
// //       ),
// //       body: _buildFuture(),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ProductScreen extends StatefulWidget {
//   const ProductScreen({super.key});

//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Product Screen")),
//       body: _buildFuture(),
//     );
//   }

//   Future<String> _fakeReading() async {
//     // await Future.delayed(Duration(seconds: 200), () {});
//     // return "Some data  hello word";

//     http.Response response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
//     return response.body;
//   }

//   late Future<String> _futureData = _fakeReading();

//   Widget _buildFuture() {
//     return Center(
//       child: FutureBuilder<String>(
//         future: _futureData,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Column(
//               mainAxisAlignment: .center,
//               children: [
//                 Text("Error: ${snapshot.error.toString()}"),
//                 FilledButton(
//                   onPressed: () {
//                     setState(() {
//                       _futureData = _fakeReading();
//                     });
//                   },
//                   child: Text("RETRY"),
//                 ),
//               ],
//             );
//           }

//           if (snapshot.connectionState == .done) {
//             return Column(
//               mainAxisAlignment: .center,
//               children: [
//                 Text("Data: ${snapshot.data}"),
//                 FilledButton(
//                   onPressed: () {
//                     setState(() {
//                       _futureData = _fakeReading();
//                     });
//                   },
//                   child: Text("REFRESH"),
//                 ),
//               ],
//             );
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }


//Exmaple 31
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

  Future<String> _fakeReading() async {
    final url = "https://fakestoreapi.com/products";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){ //200: success
        return response.body;
      }
      throw Exception("Error status code: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
  }

  late Future<String> _futureData = _fakeReading();

  Widget _buildFuture() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureData = _fakeReading();
          });
        },
        child: FutureBuilder<String>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.error, size: 50,),
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
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Text("${snapshot.data}"),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

