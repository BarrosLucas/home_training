import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hometraining/HomePageBody.dart';
import 'dart:developer' as developer;

void main() {
  developer.log("VEIO");
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
      home: MyHomePage(title: 'Home Training'),
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
  int _counter = 0;
  int _selectedIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:

          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                new HomePageBody("Treino Padrão","Treino para definição muscular"),
                new HomePageBody("Treino Emagreça","Treino para emagrecimento"),
                new HomePageBody("Treino Engorde","Treino para ganho de massa"),
              ],
          ),
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
