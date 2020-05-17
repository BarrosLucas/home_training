import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Exercices extends StatefulWidget {
  @override
  _ExercicesState createState() => _ExercicesState();
}

class _ExercicesState extends State<Exercices> {
  List _exercises = [];

  void _addExercice(String title) {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo['title'] = title;
      _exercises.add(newToDo);
      _saveData();
    });
  }

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        if(data != null) {
          _exercises = json.decode(data);
        }else{
          _addExercice("CORRIDA");
          _addExercice("AGACHAMENTO SUMÔ");
          _addExercice("AGACHAMENTO STIFF");
          _addExercice("PASSADA");
          _addExercice("AVANÇO");
          _addExercice("FLEXÃO DE POSTERIOR");
          _addExercice("AGACHAMENTO NA PAREDE");
          _addExercice("COICE PARA GLÚTEOS");
          _addExercice("PANTURRILHA  EM PÉ");
          _addExercice("DESENVOLVIMENTO EM PÉ");
          _addExercice("ELEVAÇÃO LATERAL");
          _addExercice("ELEVAÇÃO FRONTAL");
          _addExercice("ABDOMINAL SUPRA");
          _addExercice("PULAR CORDA");
          _addExercice("REMADA SUPINADA");
          _addExercice("PULL OVER");
          _addExercice("REMADA");
          _addExercice("ROSCA DIRETA");
          _addExercice("ROSCA INVERTIDA");
          _addExercice("ROSCA UNILATERAL");
          _addExercice("ROSCA ALTERNADA");
          _addExercice("ROSCA MARTELO");
          _addExercice("ABDOMINAL REMADOR");
          _addExercice("POLICHINELO");
          _addExercice("FLEXÕES");
          _addExercice("VOADOR UNILATERAL");
          _addExercice("CRUCIFIXO UNILATERAL");
          _addExercice("TRÍCEPS TESTA");
          _addExercice("TRÍCEPS FRANCÊS");
          _addExercice("TRÍCEPS AFUNDO");
          _addExercice("PRANCHA");
        }
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
                      print("Clicou: $index");
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

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/exercises.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_exercises);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      if(FileSystemEntity.typeSync(file.path) != FileSystemEntityType.notFound){
        return file.readAsString();
      }else{
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
