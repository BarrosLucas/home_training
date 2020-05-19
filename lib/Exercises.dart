import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'ExercisesRun.dart';
import 'file.dart';

class Exercices extends StatefulWidget {
  @override
  _ExercicesState createState() => _ExercicesState();
}

class _ExercicesState extends State<Exercices> {
  List _exercises = [];

  void completeExercise() async{
    _exercises = json.decode(await AccessFile.readData())['exercises'];
    setState(() {
      _exercises=_exercises;
    });

  }

  @override
  void initState() {
    super.initState();
    completeExercise();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20, top: 60),
            child: Text("EXERCÍCIOS",
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
          )),
      Expanded(
        child: Container(
          child: ListView.builder(
              itemCount: _exercises.length, itemBuilder: generateRow),
        ),
      ),
    ]);
  }

  Widget generateRow(context, index) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
                height: 62.0,
                width: 500,
                margin: new EdgeInsets.only(left: 46.0),
                decoration: new BoxDecoration(
                  color: new Color(0xAAFFFFFF),
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 40),
                  alignment: Alignment(0, 0),
                  child: new ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ExercisesRun(_exercises[index]['title'],_exercises[index]['settings'][0])));
                    },
                    title: Container(
                      padding: EdgeInsets.all(5),
                      child: new Text(_exercises[index]['title'],
                          style: new TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                  ),
                )),
            Container(
              margin: new EdgeInsets.symmetric(vertical: 5.0),
              alignment: FractionalOffset.centerLeft,
              child: new Image(
                image: new AssetImage("assets/images/Imagem11.png"),
                height: 92.0,
                width: 92.0,
              ),
            )
          ],
        ));
  }
}
