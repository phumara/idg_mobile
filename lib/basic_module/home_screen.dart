import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('កម្មវិធីខ្មែរ',style: GoogleFonts.moul(fontSize: 20,fontWeight: FontWeight.bold)),
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
        
      )  ,   
     body: Image.network(
          'https://i.pinimg.com/736x/fa/b5/8c/fab58cfd10957d5db2c1611b705992bb.jpg',
          fit: .cover,
          width: double.maxFinite,
          height: double.maxFinite,
        ),
     bottomNavigationBar: BottomAppBar(
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
     ),
     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
     floatingActionButton: FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: const Color.fromARGB(255, 128, 121, 121),
      onPressed: () {},
      child: Icon(Icons.add),

     ),
    );
    
}
}
