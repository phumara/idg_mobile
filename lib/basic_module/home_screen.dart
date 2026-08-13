import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expandable_text/expandable_text.dart';
import 'food_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar()  ,   
     body: _buildBody(),
     bottomNavigationBar: _buildBottomAppBar(),
     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
     floatingActionButton: _buildFloating(),
    );
    
}

  Widget _buildFloating() {
    return FloatingActionButton(
    shape: CircleBorder(),
    backgroundColor: const Color.fromARGB(255, 128, 121, 121),
    onPressed: () {},
    child: Icon(Icons.add),

   );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
       color: const Color.fromARGB(255, 229, 194, 196),
       child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
      IconButton(onPressed: () {}, icon: Icon(Icons.home)),
      IconButton(onPressed: () {}, icon: Icon(Icons.search)),
      IconButton(onPressed: () {}, icon: Icon(Icons.person)),
      IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
    ],
   ),
   );
  }

// Widget _buildBody() {
//     return Container(
//       color: Colors.red,
//       alignment: Alignment.topLeft,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
//         child: Container(color : Colors.blue),
//     ) 
//     ); 
//   }

  // Widget _buildBody() {
  //   return Image.network(
  //       'https://i.pinimg.com/736x/fa/b5/8c/fab58cfd10957d5db2c1611b705992bb.jpg',
  //       fit: .cover,
  //       width: double.maxFinite,
  //       height: double.maxFinite,
  //     );
  // }

Widget _buildBody() {
   
  return _buildFoodGridview();
  }

Widget _buildFoodGridview() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 3/5,
      ),
      itemCount: foods.length,
      itemBuilder:((context, index) {
        final item = foods[index];
        //return _buildFoodCard(item);
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: GridTile(
            child: Image.network(item.image, fit: BoxFit.cover),
            //footer: GridTileBar(
             // backgroundColor: Colors.black54,
             // title: Text(item.title, style: TextStyle(fontSize: 14)),
             // subtitle: Text('Rating: ${item.rate}', style: TextStyle(fontSize: 12)),
           // ),
          ),
        );
      })
      //itemBuilder: (context, index) => _buildFoodCard(foods[index]),
      //physics: const BouncingScrollPhysics(),
    );
  }


Widget _buildFoodCard(Food food) {
  return Card(
    clipBehavior: Clip.antiAlias,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Image.network(
            food.image,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.broken_image)),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(food.des,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12)),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 3),
                    Text(food.rate.toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        maxCrossAxisExtent: 200,
        childAspectRatio: 0.62,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: foods.length,
      itemBuilder: (context, index) => _buildFoodCard(foods[index]),
    );
  }


Widget _buildHorizontalListview() {
  return Container(
    height: 200,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(color: Colors.red, width: 100),
        Container(color: Colors.blue, width: 100),
        Container(color: Colors.green, width: 100),
        Container(color: Colors.yellow, width: 100),
        Container(color: Colors.orange, width: 100),
      ],
    ),
  );
}

Widget _buildPoster() {
    final pic = 'https://i.pinimg.com/1200x/c6/99/c9/c699c918cf736e8efeaa6c55b031ef6d.jpg';
    final text = 'Create eye-catching Sprite poster designs that highlight freshness and vibrant graphics Create eye-catching Sprite poster designs that highlight freshness and vibrant graphics Create eye-catching Sprite poster designs that highlight freshness and vibrant graphics. The primary keyword "facebook advertising poster design" is reflected in inspiring ads and brand promotion';
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
    
    child: Padding(
      padding:const EdgeInsets.all(8.0),
      child: Column(
        children:[
          _buildPosterImage(pic),
          _buildPosterText(text),
          _buildPosterIconRow(),
        ],
      )
    )
      );
    
  }

Widget _buildPosterIconRow() {
  return Container(
          color: const Color.fromARGB(255, 192, 216, 191),
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.heart),color: Colors.red,),
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.comment),color: Colors.blue,),
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.bookmark),color: Colors.green,),
              Spacer(),
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.share),color: Colors.purple,),
            ],
            
          ),
        );
}

Widget _buildPosterText(String text) {
  return Container(
          color: const Color.fromARGB(255, 241, 236, 236),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpandableText(
              text,
              style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.bold),
              expandText: 'Read more',
              collapseText: 'Read less',
               maxLines: 3,
               linkColor: Colors.blue,
        

            ),
          ),
        );
}

Widget _buildPosterImage(String pic) {
  return ClipRRect(
          borderRadius: BorderRadius.only( 
          topLeft: .circular(16), 
          topRight: .circular(16)),
          child: AspectRatio(
            aspectRatio: 1.5,
            child: Image.network(
              pic,
              fit: BoxFit.cover,
            ),
          ),
        );
}


Widget _buildRow() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(color: Colors.pink, width: 70, height: 80),
        Container(color: Colors.blue, width: 50, height: 70),
        Container(color: Colors.orange, width: 80, height: 50),
        Container(color: Colors.lime, width: 60, height: 30),
        Container(color: Colors.purple, width: 30, height: 40),
      ],
    )
    );
  }

Widget _buildColumn() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(color: Colors.pink, width: 70, height: 80),
        Container(color: Colors.blue, width: 50, height: 70),
        Container(color: Colors.orange, width: 80, height: 50),
        Container(color: Colors.lime, width: 60, height: 30),
        Container(color: Colors.purple, width: 30, height: 40),
      ],
    )
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text('កម្មវិធីខ្មែរ App',style: GoogleFonts.moul(fontSize: 20,fontWeight: FontWeight.bold)),
      backgroundColor: const Color.fromARGB(255, 173, 162, 13),
      foregroundColor: const Color.fromARGB(255, 53, 50, 50),
      centerTitle: true,
      //leading: Icon(Icons.face),
      leading:Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnguGqGO1HdZWfvIbdeoX3rdDjE3j5Erp4yDS2bT_3zA&s=10'),
        ),
      ),
      // Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnguGqGO1HdZWfvIbdeoX3rdDjE3j5Erp4yDS2bT_3zA&s=10'),
      actions: [
        IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.share)),
        IconButton(onPressed: () {}, icon: Icon(Icons.settings)),    
      ],
      flexibleSpace: Image.network(
        'https://i.pinimg.com/736x/17/53/de/1753deb9a06e9a9e8d791d6f1d17a41d.jpg',
        fit: .cover,
      ),
      
    );
  }
}
