import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'ExercisesRun.dart';

class Exercices extends StatefulWidget {
  @override
  _ExercicesState createState() => _ExercicesState();
}

class _ExercicesState extends State<Exercices> {
  List _exercises = [];

  void _addExercice(String title, bool doing) {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo['title'] = title;
      newToDo['doing'] = doing;
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
        }
        else{
          _addExercice("CORRIDA",false);
          _addExercice("AGACHAMENTO SUMÔ",false);
          _addExercice("AGACHAMENTO STIFF",false);
          _addExercice("PASSADA",false);
          _addExercice("AVANÇO",false);
          _addExercice("FLEXÃO DE POSTERIOR",false);
          _addExercice("AGACHAMENTO NA PAREDE",false);
          _addExercice("COICE PARA GLÚTEOS",false);
          _addExercice("PANTURRILHA  EM PÉ",false);
          _addExercice("DESENVOLVIMENTO EM PÉ",false);
          _addExercice("ELEVAÇÃO LATERAL",false);
          _addExercice("ELEVAÇÃO FRONTAL",false);
          _addExercice("ABDOMINAL SUPRA",false);
          _addExercice("PULAR CORDA",false);
          _addExercice("REMADA SUPINADA",false);
          _addExercice("PULL OVER",false);
          _addExercice("REMADA",false);
          _addExercice("ROSCA DIRETA",false);
          _addExercice("ROSCA INVERTIDA",false);
          _addExercice("ROSCA UNILATERAL",false);
          _addExercice("ROSCA ALTERNADA",false);
          _addExercice("ROSCA MARTELO",false);
          _addExercice("ABDOMINAL REMADOR",false);
          _addExercice("POLICHINELO",false);
          _addExercice("FLEXÕES",false);
          _addExercice("VOADOR UNILATERAL",false);
          _addExercice("CRUCIFIXO UNILATERAL",false);
          _addExercice("TRÍCEPS TESTA",false);
          _addExercice("TRÍCEPS FRANCÊS",false);
          _addExercice("TRÍCEPS AFUNDO",false);
          _addExercice("PRANCHA",false);
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ExercisesRun(_exercises[index]['title'],3)));
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
