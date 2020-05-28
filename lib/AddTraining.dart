import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hometraining/AddMTFirstPage.dart';
import 'package:hometraining/AddTrainingFirstPage.dart';
import 'package:hometraining/AddTrainingSecondPage.dart';
import 'package:hometraining/file.dart';
import 'AddMTSecondPage.dart';

class AddTraining extends StatefulWidget {
  @override
  _AddTrainingState createState() => _AddTrainingState();
}

class _AddTrainingState extends State<AddTraining> {
  int _selectedIndex = 0;
  String _appSecret;

  final snackBar = SnackBar(content: Text("Você precisa adicionar um módulo", style: TextStyle(color: Colors.white),),backgroundColor: Colors.red[900],);
  final snackBarPageTwo = SnackBar(content: Text("Preencha todos os campos", style: TextStyle(color: Colors.white),),backgroundColor: Colors.red[900],);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List _training = [];

  void completeTraining() async{
    _training = json.decode(await AccessFile.readData())['training'];
    setState(() {
      _training=_training;
      AddTrainingFirstPage.treining = AddTrainingFirstPage.treining;
    });

  }

  @override
  void initState() {
    super.initState();
    completeTraining();
  }

  Future<bool> _requestPop(){
    if(AddTrainingFirstPage.treining != null){
      if(AddTrainingFirstPage.treining.length > 0){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text("Decartar Alterações"),
            content: Text("Se sair as alterações serão perdidas"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Sim"),
                onPressed: (){
                  Navigator.pop(context);
                  backToBeforeScreen();
                },
              )
            ],
          );
        });
        return Future.value(false);
      }
    }
    return Future.value(true);

  }

  Widget getBackButton(int index) {
    if (index == 0) {
      return Container(width: 120);
    } else {
      return Container(
        margin: EdgeInsets.all(20),
        width: 120,
        child: RaisedButton(
            splashColor: Colors.white,
            onPressed: () {
              setState(() {
                _selectedIndex--;
              });
            },
            color: Colors.red[900],
            textColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.navigate_before, color: Colors.white),
                Text(
                  "Voltar",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
              ],
            )),
      );
    }
  }

  Widget getNextButton(BuildContext context, index) {
    if (index == 0) {
      return Container(
        margin: EdgeInsets.all(20),
        width: 120,
        child: RaisedButton(
            splashColor: Colors.white,
            onPressed: () {
              if (AddTrainingFirstPage.treining.length == 0) {
                _scaffoldKey.currentState.removeCurrentSnackBar();
                _scaffoldKey.currentState.showSnackBar(snackBar);
              } else {
                setState(() {
                  _selectedIndex++;
                });
              }
            },
            color: Colors.red[900],
            textColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Avançar",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
                Icon(Icons.navigate_next, color: Colors.white)
              ],
            )),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(20),
        width: 120,
        child: RaisedButton(
            splashColor: Colors.white,
            onPressed: () {
              if(AddTrainingSecondPage.titleController.text.isNotEmpty && AddTrainingSecondPage.descController.text.isNotEmpty){
                Map map = {
                  "title": AddTrainingSecondPage.titleController.text.toUpperCase(),
                  "desc": AddTrainingSecondPage.descController.text,
                  "modules":AddTrainingFirstPage.treining
                };
                setState(() {
                  AddTrainingSecondPage.titleController.text = "";
                  AddTrainingSecondPage.descController.text = "";
                  AddModuleTrainingFirstPage.descController.text="";
                  AddModuleTrainingFirstPage.titleController.text="";
                  AddModuleTrainingSecondPage.zeroSecondList();
                  _training.add(map);
                  AccessFile.map['training'] = _training;
                  AccessFile.saveData();
                  AddTrainingFirstPage.treining = [];
                });
                Navigator.pop(context);
              }else{
                _scaffoldKey.currentState.removeCurrentSnackBar();
                _scaffoldKey.currentState.showSnackBar(snackBarPageTwo);
              }
            },
            color: Colors.green,
            textColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Concluir",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
                Icon(Icons.navigate_next, color: Colors.white)
              ],
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      AddTrainingFirstPage.treining = AddTrainingFirstPage.treining;
    });
    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
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
                        if(AddTrainingFirstPage.treining == null || AddTrainingFirstPage.treining.length == 0){
                          backToBeforeScreen();
                        }else{
                          _requestPop();
                        }
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
            Column(
              children: <Widget>[
                setPage(_selectedIndex),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment(-1, 0),
                        child: getBackButton(_selectedIndex),
                      ),
                      Container(
                          alignment: Alignment(1, 0),
                          child: getNextButton(context,_selectedIndex)),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (_selectedIndex == 0)
                                    ? Colors.grey[850]
                                    : Colors.white,
                                border: Border.all(),
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 10.0,
                                    offset: new Offset(0.0, 10.0),
                                  ),
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (_selectedIndex == 1)
                                    ? Colors.grey[850]
                                    : Colors.white,
                                border: Border.all(),
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 10.0,
                                    offset: new Offset(0.0, 10.0),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ]),
        ),
      ),
      onWillPop: _requestPop,
    ) ;
  }

  void backToBeforeScreen(){
    AddTrainingFirstPage.treining = [];
    Navigator.pop(context);
  }
}

Widget setPage(int index) {
  switch (index) {
    case 1:
      return AddTrainingSecondPage();
    case 0:
    default:
      return AddTrainingFirstPage();
  }
}
