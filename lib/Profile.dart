import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List _profile = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController challengesController = TextEditingController();

  void _addProfile(
      String name, int daysTraining, int challengeDone, int calories) {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo['name'] = name;
      newToDo['daysTraining'] = daysTraining;
      newToDo['challengeDone'] = challengeDone;
      newToDo['calories'] = calories;
      _profile.add(newToDo);
      _saveData();
    });
  }

  @override
  void initState() {
    _addProfile("", 5, 15, 1540);
    super.initState();
    _readData().then((data) {
      setState(() {
        _profile = json.decode(data);
        nameController.text = _profile[0]['name'];
        daysController.text = "${_profile[0]['daysTraining']}";
        challengesController.text = "${_profile[0]['challengeDone']}";
        print("Desafios completos: ${challengesController.text}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20, top: 60),
            child: Text("PERFIL",
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
          )),
      Expanded(
          child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40),
          child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      labelText: "Nome",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    enabled: false,
                    controller: daysController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      labelText: "Dias de Treino",
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      enabled: false,
                      controller: challengesController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        labelText: "Desafios Completos",
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        new BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: new Offset(0.0, 10.0),
                        ),
                      ]),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.wb_sunny,
                        color: Colors.black,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15, bottom: 5),
                        child: Text(
                          "${_profile[0]['calories']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      ),
                      Text(
                        "KCAL",
                        style: TextStyle(fontSize: 12,
                        ),
                      )
                    ],
                  ),
                )
              ])),
        ),
      ))
    ]);
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/profile.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_profile);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
