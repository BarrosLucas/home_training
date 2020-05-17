import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AddModuleTrainingSecondPage extends StatefulWidget {
  @override
  _AddModuleTrainingSecondPageState createState() =>
      _AddModuleTrainingSecondPageState();
}

class _AddModuleTrainingSecondPageState
    extends State<AddModuleTrainingSecondPage> {
  List _exercises = [];

  void _addExercice(String title,bool doing) {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo['title'] = title;
      newToDo['doing'] = doing;
      _exercises.add(newToDo);
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:
        Column(
          children: <Widget>[
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
              child: ListView.builder(itemBuilder:buidItem, padding: EdgeInsets.only(top: 10),
                itemCount: _exercises.length,),
            )
          ],
    ));
  }

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        if (data != null) {
          _exercises = json.decode(data);
        }
        else {
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

  Widget buidItem(context, index) {
    return CheckboxListTile(
      title: Text(_exercises[index]['title']),
      value: _exercises[index]['doing'],
      secondary: CircleAvatar(
          child: new Image(
            image: new AssetImage("assets/images/Imagem5.png"),
            height: 92.0,
            width: 92.0,
          )
      ),
      onChanged: (check) {
        setState(() {
          _exercises[index]['doing'] = check;
          _saveData();
        });
      },
    );
  }
}

