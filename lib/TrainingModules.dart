import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hometraining/TrainingRun.dart';
import 'package:path_provider/path_provider.dart';

class TrainingModules extends StatefulWidget {
  @override
  _TrainingModulesState createState() => _TrainingModulesState();
}

class _TrainingModulesState extends State<TrainingModules> {
  List _treining = [];

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        if (data != null) {
          _treining = json.decode(data);
        } else {
          _addToDo("TREINO A", "MMI e Ombro");
          _addToDo("TREINO B", "Costa e Bíceps");
          _addToDo("TREINO C", "Peito e Tríceps");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
            color: Colors.grey[200],
            child: Stack(children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 40, left: 10),
                      child: IconButton(
                        icon: Icon(
                          Icons.navigate_before,
                          color: Colors.black,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          "assets/images/Imagem2.png",
                          width: 220,
                          height: 220,
                          alignment: Alignment.topRight,
                        ),
                      ))
                ],
              ),
              generateContent()
            ])));
  }

  Widget generateRow(context, index) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            Container(
                height: 124.0,
                width: 500,
                margin: new EdgeInsets.only(left: 46.0),
                decoration: new BoxDecoration(
                  color: new Color(0xCCFFFFFF),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingRun(_treining[index]['title'],false)));
                      },
                      title: Container(
                        padding: EdgeInsets.all(5),
                        child: new Text(_treining[index]['title'],
                            style: new TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                      subtitle: Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            _treining[index]['desc'],
                            style: new TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.grey[600]),
                          ))),
                )),
            Container(
              margin: new EdgeInsets.symmetric(vertical: 16.0),
              alignment: FractionalOffset.centerLeft,
              child: new Image(
                image: new AssetImage("assets/images/Imagem3.png"),
                height: 92.0,
                width: 92.0,
              ),
            )
          ],
        ));
  }

  void _addToDo(String title, String desc) {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo['title'] = title;
      newToDo['desc'] = desc;
      _treining.add(newToDo);
      _saveData();
    });
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/treiningModule.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_treining);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      if (FileSystemEntity.typeSync(file.path) !=
          FileSystemEntityType.notFound) {
        return file.readAsString();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Widget generateContent() {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20, top: 60),
            child: Text("TREINOS",
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
          )),
      Expanded(
        child: Container(
          child: ListView.builder(
              itemCount: _treining.length, itemBuilder: generateRow),
        ),
      ),
    ]);
  }
}
