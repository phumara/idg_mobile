import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expandable_text/expandable_text.dart';

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
   
  return  _buildHorizontalListview();  
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
