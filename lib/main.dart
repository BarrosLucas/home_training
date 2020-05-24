import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hometraining/Challenge.dart';
import 'package:hometraining/Exercises.dart';
import 'package:hometraining/Home.dart';
import 'package:hometraining/Profile.dart';

import 'file.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(
        title: "Treinos",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    printCoisa();

  }

  void printCoisa() async{
    AccessFile.map = json.decode(await AccessFile.readData());
    AccessFile.map['read'] = true;
    setState(() {
      AccessFile.map = AccessFile.map;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget setPage(int index) {
    switch (index) {
      case 0:
        return Home();
      case 1:
        return Challenge();
      case 2:
        return Exercices();
      case 3:
        return Profile();
      default:
        return Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    if(AccessFile.map==null){
      printCoisa();
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:

          /*setPage(_selectedIndex)*/
      Stack(
        alignment: Alignment(1, -1),
        children: <Widget>[
          Image.asset(
            "assets/images/Imagem2.png",
            width: 220,
            height: 220,
          ),
          setPage(_selectedIndex)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            title: Text('Desafios'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk),
            title: Text('Exercícios'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Meu Perfil'),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey[500],
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

}
