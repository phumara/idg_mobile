// import 'package:flutter/material.dart';
// import 'theme_provider.dart';
// import 'package:provider/provider.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     bool dark = context.watch<ThemeProvider>().dark;
//     return Scaffold(
//       // backgroundColor: _dark ? Colors.grey : Colors.white,
//       //final pic=Image.network(foodList1[0].image);
//       appBar: AppBar(title: Text("Settings")),
//       //body: Center(
//         // child: IconButton(
//         //   onPressed: () {
//         //     //remote controller
//         //     context.read<ThemeProvider>().toggleDark();
//         //   },
//         //   icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
//         // ),
//       body:Padding(
//         padding: EdgeInsets.all(16.0),

//         child: ListView(
//         children: [
//           CircleAvatar(
//           radius: 120,
//           backgroundImage: NetworkImage(
//         "https://i.pinimg.com/736x/0b/97/6f/0b976f0a7aa1aa43870e1812eee5a55d.jpg",
//       ),
//     ),
//           ListTile(
//             title: Text("Dark Mode ${dark ? "ON" : "OFF"}"),
//             trailing: Switch(
//               value: dark,
//               onChanged: (value) {
//                 context.read<ThemeProvider>().toggleDark();
//               },
//             ),
//           ),
//         ],
//       )
//     ),
     
   
//     );
    
//   }
// }

import 'package:flutter/material.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';
import 'color_provider.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dark = false;

  @override
  Widget build(BuildContext context) {
    _dark = context.watch<ThemeProvider>().dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _buildProfileImage(),
            const Divider(),
            _buildDarkModeSwitch(),
            const Divider(),
            _buildColorSelector(),
            const Divider(),
          ],
        ),
      ),
    );
  }



// List colorList = [
//     Colors.pink,
//     Colors.lime,
//     Colors.purple,
//     Colors.blue,
//     Colors.greenAccent,
//   ];

  int _selectedIndex = 1;

  Widget _buildColorSelector() {
    _selectedIndex = context.watch<ColorProvider>().index;
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 50,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemCount: colorList.length,
      itemBuilder: (context, index) {
        if (_selectedIndex == index) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(color: colorList[index]),
              Container(color: Colors.white, child: Icon(Icons.check)),
            ],
          );
        } else {
          return InkWell(
            onTap: () {
              context.read<ColorProvider>().setIndex(index);
            },
            child: Container(color: colorList[index]),
          );
        }
      },
    );
  }


  // int selectedIndex = 1;

  // Widget _buildColorSelector() {
  //   return Card(
  //     child: ListTile(
  //       title: Row(
  //         mainAxisAlignment: .spaceAround,
  //         children: [
  //           for (int index = 0; index < colorList.length; index++)
  //             selectedIndex == index
  //                 ? Container(color: colorList[index], width: 60, height: 60)
  //                 : InkWell(
  //                     onTap: () {
  //                       setState(() {
  //                         selectedIndex = index;
  //                       });
  //                     },
  //                     child: Container(
  //                       color: colorList[index],
  //                       width: 50,
  //                       height: 50,
  //                     ),
  //                   ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // List colorList = [
  //   Colors.pink,
  //   Colors.lime,
  //   Colors.purple,
  //   Colors.blue,
  //   Colors.greenAccent,
  // ];

  // int selectedIndex = 1;

  // Widget _buildColorSelector() {
  //   return Card(
  //     child: ListTile(
  //       title: Row(
  //         mainAxisAlignment: .spaceAround,
  //         children: [
  //           for (int index = 0; index < colorList.length; index++)
  //             selectedIndex == index
  //                 ? Container(color: colorList[index], width: 60, height: 60)
  //                 : InkWell(
  //                     onTap: () {
  //                       setState(() {
  //                         selectedIndex = index;
  //                       });
  //                     },
  //                     child: Container(
  //                       color: colorList[index],
  //                       width: 50,
  //                       height: 50,
  //                     ),
  //                   ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  
  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 100,
      backgroundImage: NetworkImage(
        "https://i.pinimg.com/736x/0b/97/6f/0b976f0a7aa1aa43870e1812eee5a55d.jpg",
      ),
    );
  }

  Widget _buildDarkModeSwitch() {
    return Card(
      child: SwitchListTile(
        title: Text("Dark Mode"),
        subtitle: Text("Currently in ${_dark ? "Dark" : "Light"} Mode"),
        value: _dark,
        onChanged: (_) {
          context.read<ThemeProvider>().toggleDark();
        },
      ),
    );
  }
}
