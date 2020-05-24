import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hometraining/Challenge.dart';
import 'package:hometraining/Exercises.dart';
import 'package:hometraining/Home.dart';
import 'package:hometraining/Profile.dart';
import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';

import 'file.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String _appSecret;
  String _installId = 'Unknown';
  bool _areAnalyticsEnabled = false, _areCrashesEnabled = false;
  MyApp(){
    final ios = defaultTargetPlatform == TargetPlatform.iOS;
    _appSecret = ios ? "d3b04268-5f5a-44e8-b50d-484df1579d4a" : "a65498d8-a8ed-44cd-a39e-f536bf1782ce";
    initPlatformState();
  }

  initPlatformState() async {
    await AppCenter.start(
        _appSecret, [AppCenterAnalytics.id, AppCenterCrashes.id]);

    var installId = await AppCenter.installId;

    var areAnalyticsEnabled = await AppCenterAnalytics.isEnabled;
    var areCrashesEnabled = await AppCenterCrashes.isEnabled;

    _installId = installId;
    _areAnalyticsEnabled = areAnalyticsEnabled;
    _areCrashesEnabled = areCrashesEnabled;

  }

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
        AppCenterAnalytics.trackEvent("Home");
        return Home();
      case 1:
        AppCenterAnalytics.trackEvent("Challenge");
        return Challenge();
      case 2:
        AppCenterAnalytics.trackEvent("Exercises");
        return Exercices();
      case 3:
        AppCenterAnalytics.trackEvent("Profile");
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
