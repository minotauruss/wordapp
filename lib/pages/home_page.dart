import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wordapp/models/user_model.dart';
import 'package:wordapp/models/word_model.dart';
import 'package:wordapp/mongo/mongo_db.dart';
import 'package:wordapp/pages/add_word.dart';
import 'package:wordapp/pages/game_page.dart';



class HomePage extends StatefulWidget {
 HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
   final db = FirebaseFirestore.instance;



  void signOut(){
    FirebaseAuth.instance.signOut();
    
  }


  @override
  void initState() {
  
    super.initState();
   

  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddWord()));
      },child: Icon(Icons.plus_one),),
    appBar: AppBar(actions: [
      IconButton(onPressed: signOut, icon: Icon(Icons.exit_to_app))
    ]),
      body: Center(child: TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>GamePage()));
      },child: Text("game"),),),
    );
  }
}