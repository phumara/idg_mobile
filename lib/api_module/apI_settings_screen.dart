import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../basic_module/color_provider.dart';
import '../basic_module/theme_provider.dart';

class ApiSettingsScreen extends StatefulWidget {
  const ApiSettingsScreen({super.key});

  @override
  State<ApiSettingsScreen> createState() => _ApiSettingsScreenState();
}

class _ApiSettingsScreenState extends State<ApiSettingsScreen> {
  bool _dark = false;

  @override
  Widget build(BuildContext context) {
    _dark = context.watch<ThemeProvider>().dark;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _buildProfileImage(),
            Divider(),
            _buildDarkModeSwitch(),
            _buildColorSelector(),
            // Divider(),
          ],
        ),
      ),
    );
  }

  int _selectedIndex = 1;

  Widget _buildColorSelector() {
    _selectedIndex = context.watch<ColorProvider>().index;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
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
      ),
    );
  }

  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 100,
      backgroundImage: NetworkImage(
        "https://imgcdn.stablediffusionweb.com/2025/4/11/226007a0-6491-4374-a84c-4ee3140826c4.jpg",
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
