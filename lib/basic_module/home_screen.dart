import 'package:flutter/material.dart';
import 'food_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      // bottomNavigationBar: _buildBottomAppBar(),
      floatingActionButtonLocation: .endFloat,
      floatingActionButton: _buildFloating(),
    );
  }

  Widget _buildStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(color: Colors.red, width: 300, height: 300),
        Container(color: Colors.blue, width: 200, height: 100),
        Container(color: Colors.purple, width: 100, height: 200),
        Positioned(
          right: 10,
          bottom: 10,
          child: Container(color: Colors.yellow, width: 50, height: 50),
        ),
        Positioned(
          left: 10,
          top: 10,
          child: Container(color: Colors.white, width: 50, height: 50),
        ),
      ],
    );
  }

  Widget _buildFloating() {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      foregroundColor: Theme.of(context).colorScheme.onTertiary,
      onPressed: () {},
      child: Icon(Icons.add),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        mainAxisAlignment: .spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.home, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return _buildMainListView();
  }

  Widget _buildMainListView() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        _buildLabel("ម្ងូបបរទេស", Icons.card_travel),
        _buildFoodCircleStory(),
        _buildLabel("ម្ងូបថ្មី", Icons.new_label),
        _buildFoodStory(),
        _buildLabel("ម្ងូបប្រចាំហាង", Icons.hot_tub),
        _buildFoodGridView(),
      ],
    );
  }

  ListTile _buildLabel(String text, IconData icon) {
    return ListTile(
      // titleTextStyle: Theme.of(
      //   context,
      // ).textTheme.bodyLarge?.copyWith(fontSize: 20),
      // textColor: Theme.of(context).colorScheme.onSurface,
      leading: Icon(icon),
      title: Text(text),
    );
  }

  Widget _buildFoodCircleStory() {
    return SizedBox(
      height: 250,
      child: GridView.builder(
        padding: .all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 1,
          childAspectRatio: 4 / 4,
        ),
        physics: BouncingScrollPhysics(),
        scrollDirection: .horizontal,
        itemCount: westernFoods.length,
        itemBuilder: (context, index) {
          final item = westernFoods[index];
          return Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: .center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipOval(
                        child: Image.network(
                          item.image,
                          fit: .cover,
                          width: .maxFinite,
                        ),
                      ),
                    ),
                    Icon(Icons.play_arrow, size: 100, color: Colors.white70),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(item.title, maxLines: 1, overflow: .ellipsis),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFoodStory() {
    return SizedBox(
      height: 250,
      child: GridView.builder(
        padding: .all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 1,
          childAspectRatio: 4 / 3,
        ),
        physics: BouncingScrollPhysics(),
        scrollDirection: .horizontal,
        itemCount: foodList1.length,
        itemBuilder: (context, index) {
          final item = foodList1[index];
          return Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: .circular(8),
                  child: Image.network(
                    item.image,
                    fit: .cover,
                    width: .maxFinite,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(item.title, maxLines: 1, overflow: .ellipsis),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFoodGridView() {
    bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return GridView.builder(
      padding: .all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: landscape ? 4 : 2,
        childAspectRatio: 4 / 5, //x / y
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: .vertical,
      itemCount: foodList2.length,
      itemBuilder: (context, index) {
        final item = foodList2[index];
        return Card(
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: .circular(8),
                  child: Image.network(item.image, fit: .cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(item.title, maxLines: 1, overflow: .ellipsis),
              ),
            ],
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("កម្មវិធីលក់ម្ហូប"),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.face),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
      ],
    );
  }
}
