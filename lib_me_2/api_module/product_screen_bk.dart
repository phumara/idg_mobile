// import 'dart:convert';

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
//       appBar: AppBar(
//         title: Text("Product Screen"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 _futureData = _fakeReading();
//               });
//             },
//             icon: Icon(Icons.refresh),
//           ),
//         ],
//       ),
//       body: _buildFuture(),
//     );
//   }

//   Future<List<Map<String, dynamic>>> _fakeReading() async {
//     final url = "https://fakestoreapi.com/users";
//     try {
//       http.Response response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
//       //200: success
//       if (response.statusCode == 200) {
//         List list = jsonDecode(response.body);
//         List<Map<String, dynamic>> data = list
//             .map((x) => x as Map<String, dynamic>)
//             .toList();
//         return data;
//       }
//       throw Exception("Error status code: ${response.statusCode}");
//     } catch (e) {
//       throw Exception("Error ${e.toString()}");
//     }
//   }

//   late Future<List<Map<String, dynamic>>> _futureData = _fakeReading();

//   Widget _buildFuture() {
//     return Center(
//       child: RefreshIndicator(
//         onRefresh: () async {
//           setState(() {
//             _futureData = _fakeReading();
//           });
//         },
//         child: FutureBuilder<List<Map<String, dynamic>>>(
//           future: _futureData,
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: .center,
//                   children: [
//                     Icon(Icons.error, size: 50),
//                     Text("Error: ${snapshot.error.toString()}"),
//                     FilledButton(
//                       onPressed: () {
//                         setState(() {
//                           _futureData = _fakeReading();
//                         });
//                       },
//                       child: Text("RETRY"),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             if (snapshot.connectionState == .done) {
//               return _buildGridView(snapshot.data);
//              // return _buildListView(snapshot.data);
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }
// Widget _buildListView(List<Map<String, dynamic>>? items) {
//   if (items == null) return Icon(Icons.list);

//   return ListView.separated(
//     padding: const EdgeInsets.all(8),
//     physics: const BouncingScrollPhysics(),
//     itemCount: items.length,
//     separatorBuilder: (_, __) => const Divider(height: 1),
//     itemBuilder: (context, index) {
//       final item = items[index];
//       final name = item['name'] as Map<String, dynamic>;
//       final address = item['address'] as Map<String, dynamic>;
//       final fullName = "${name['firstname']} ${name['lastname']}";

//       return ListTile(
//         leading: CircleAvatar(
//           child: Text(fullName[0].toUpperCase()),
//         ),
//         title: Text(fullName),
//         subtitle: Text(
//           "${item['email']}\n${address['city']} ${address['street']}, ${address['number']},${address['zipcode']}",
//         ),
//         isThreeLine: true,
//         trailing: Text("#${item['id']}"),
//       );
//     },
//   );
// }

//  Widget _buildGridView(List<Map<String, dynamic>>? items) {

//     if (items == null) {
//       return Icon(Icons.list);
//     }

//     bool landscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return GridView.builder(
//       padding: .all(8),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         mainAxisSpacing: 8,
//         crossAxisSpacing: 8,
//         crossAxisCount: landscape ? 4 : 2,
//         childAspectRatio: 4 / 5, //x / y
//       ),
//       physics: BouncingScrollPhysics(),
//       shrinkWrap: true,
//       scrollDirection: .vertical,
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         final item = items[index];
//         final name = item['name'] as Map<String, dynamic>;
//         final address = item['address'] as Map<String, dynamic>;
//         final fullName = "${name['firstname']} ${name['lastname']}";
//         final fulladdress = "${address['city']} ${address['street']}, ${address['number']},${address['zipcode']},Geolocation( ${address['geolocation']['lat']},${address['geolocation']['long']})";
//         final phone = item['phone'];
//         // final email = item['email'];
//         // final website = item['website'];
//         // final company = item['company'];
//         return Card(
//           child: Column(
//             children: [
                           
//               // Expanded(
//               //   // child: ClipRRect(
//               //   //   //borderRadius: .circular(8),
//               //   //   // child: Container(
//               //   //   //   color: const Color.fromARGB(255, 65, 102, 117),
//               //   //   //   alignment: .center,
//               //   //   //   child: Text(
//               //   //   //     fullName[0].toUpperCase(),
//               //   //   //     style: TextStyle(fontSize: 40),
//               //   //   //   ),
//               //   //   // ),
//               //   // ),
//                //),
              
//           Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
//                 child: Text("${item['id']}", maxLines: 1, overflow: .ellipsis),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
//                 child: Text(fullName, maxLines: 1, overflow: .ellipsis),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
//                 child: Text("${item['email']}", maxLines: 1, overflow: .ellipsis),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
//                 child: Text("${item['username']}/${item['password']}}", maxLines: 2, overflow: .ellipsis),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
//                 child: Text(fulladdress, maxLines: 3, overflow: .ellipsis),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
//                 child: Text(phone, maxLines: 1, overflow: .ellipsis),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
//               //   child: Text(address['street'], maxLines: 1, overflow: .ellipsis),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
//               // ),
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
//               //   child: Text(address['zipcode'], maxLines: 1, overflow: .ellipsis),
              
//             ],
//           ),
//         );
//       },
//     );
//   }


// //   Widget _buildGridView(List<Map<String, dynamic>>? items) {

// //     if (items == null) {
// //       return Icon(Icons.list);
// //     }

// //     bool landscape =
// //         MediaQuery.of(context).orientation == Orientation.landscape;

// //     return GridView.builder(
// //       padding: .all(8),
// //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //         mainAxisSpacing: 8,
// //         crossAxisSpacing: 8,
// //         crossAxisCount: landscape ? 4 : 2,
// //         childAspectRatio: 4 / 5, //x / y
// //       ),
// //       physics: BouncingScrollPhysics(),
// //       shrinkWrap: true,
// //       scrollDirection: .vertical,
// //       itemCount: items.length,
// //       itemBuilder: (context, index) {
// //         final item = items[index];
// //         return Card(
// //           child: Column(
// //             children: [
// //               Expanded(
// //                 child: ClipRRect(
// //                   borderRadius: .circular(8),
// //                   child: Image.network(item['image'], fit: .cover),
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
// //                 child: Text(item['title'], maxLines: 1, overflow: .ellipsis),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
// //                 child: Text("US\$ ${item['price']}", maxLines: 1, overflow: .ellipsis),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
 
// }