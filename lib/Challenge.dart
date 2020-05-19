import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hometraining/ChallengeRun.dart';
import 'package:path_provider/path_provider.dart';

import 'ChallengeDescription.dart';

class Challenge extends StatefulWidget {
  @override
  _ChallengeState createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {
  List _challenges = [];

  void _addChallenge(String title, String desc, bool done) {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo['title'] = title;
      newToDo['desc'] = desc;
      newToDo['done'] = done;
      _challenges.add(newToDo);
      _saveData();
    });
  }

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        if(data != null) {
          _challenges = json.decode(data);
        }else{
          _addChallenge("1000 FLEXÕES", "Faça 100 flexões por dia em 10 dias", false);
          _addChallenge("1000 ABDOMINAIS", "Faça 100 abdominais por dia em 10 dias", false);
          _addChallenge("5000 POLICHINELOS", "Faça 500 flexões por dia em 10 dias", false);
          _addChallenge("1000 AGACHAMENTOS", "Faça 100 agachamentos por dia em 10 dias", false);
          _addChallenge("50 KM", "Corra 5 km por dia em 10 dias", false);
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
            child: Text("DESAFIOS",
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
          )),
      Expanded(
        child: Container(
          child: ListView.builder(
              itemCount: _challenges.length, itemBuilder: generateRow),
        ),
      ),
    ]);
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
                  color: _challenges[index]['done']? new Color(0x6677DD77) : new Color(0x66F80000),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChallengeDescription(_challenges[index]['title'],"Descrição descrição descrição descrição")));
                      },
                      title: Container(
                        padding: EdgeInsets.all(5),
                        child: new Text(_challenges[index]['title'],
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
                            _challenges[index]['desc'],
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
                image: new AssetImage("assets/images/Imagem10.png"),
                height: 92.0,
                width: 92.0,
              ),
            )
          ],
        ));
  }


  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/challenges.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_challenges);
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
