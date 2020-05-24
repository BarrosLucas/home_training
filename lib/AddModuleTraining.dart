import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hometraining/AddMTFirstPage.dart';
import 'package:hometraining/AddMTSecondPage.dart';
import 'package:hometraining/AddMTThirdPage.dart';
import 'package:hometraining/file.dart';
import 'AddTrainingFirstPage.dart';

class AddModuleTraining extends StatefulWidget {
  AddTrainingFirstPage instance;
  AddModuleTraining(this.instance);

  @override
  _AddModuleTrainingState createState() => _AddModuleTrainingState(this.instance);
}

class _AddModuleTrainingState extends State<AddModuleTraining> {

  List _exercises = [{}];

  void completeExercise() async{
    _exercises = json.decode(await AccessFile.readData())['exercises'];
    setState(() {
      _exercises=_exercises;
    });
    print(_exercises);
  }

  AddTrainingFirstPage instance;


  @override
  void initState() {
    super.initState();
    completeExercise();
  }

  int _selectedIndex = 0;
  _AddModuleTrainingState(this.instance);
    @override
    Widget build(BuildContext context) {
      Widget getBackButton(int index){
        if(index == 0) {
          return Container(
              width: 120
          );
        }else{
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.navigate_before, color: Colors.white),
                    Text(
                      "Voltar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ],
                )),
          );
        }
      }
      Widget getNextButton(int index){
        if(index == 0){
          return Container(
            margin: EdgeInsets.all(20),
            width: 120,
            child: RaisedButton(
                splashColor: Colors.white,
                onPressed: () {
                  setState(() {
                    if(AddModuleTrainingFirstPage.titleController.text.isNotEmpty && AddModuleTrainingFirstPage.descController.text.isNotEmpty) {
                      _selectedIndex++;
                    }

                  });
                },
                color: Colors.red[900],
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Avançar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                    Icon(Icons.navigate_next, color: Colors.white)
                  ],
                )),
          );
        }else if(index == 1){
          return Container(
            margin: EdgeInsets.all(20),
            width: 120,
            child: RaisedButton(
                splashColor: Colors.white,
                onPressed: () {
                  setState(() {
                    AddModuleTrainingSecondPage.generateFinalListSecond();
                    if(AddModuleTrainingSecondPage.secondFinalList != null){
                      if(AddModuleTrainingSecondPage.secondFinalList.length>0){
                        _selectedIndex ++;
                      }
                    }
                  });

                  /*

                  if(AddModuleTrainingFirstPage.titleController.text.isNotEmpty && AddModuleTrainingFirstPage.descController.text.isNotEmpty && list.length>0) {
                    Map map = {
                      "title": AddModuleTrainingFirstPage.titleController.text
                          .toUpperCase(),
                      "desc": AddModuleTrainingFirstPage.descController.text,
                      "exercises": list
                    };
                    setState(() {
                      AddTrainingFirstPage.treining.add(map);
                      AddModuleTrainingFirstPage.titleController.text = "";
                      AddModuleTrainingFirstPage.descController.text = "";
                      AddModuleTrainingSecondPage.zeroSecondList();
                    });
                    Navigator.pop(context,AddTrainingFirstPage.treining);
                  }

                   */
                },
                color: Colors.red[900],
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Avançar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                    Icon(Icons.navigate_next, color: Colors.white)
                  ],
                )),
          );
        }
        else{
          return Container(
            margin: EdgeInsets.all(20),
            width: 120,
            child: RaisedButton(
                splashColor: Colors.white,
                onPressed: () {
                  List list = AddModuleTrainingSecondPage.generateFinalList();
                  print("List length: ${list.length}");
                  print("isNotEmpty Title: ${AddModuleTrainingFirstPage.titleController.text.isNotEmpty}");
                  print("isNotEmpty Title: ${AddModuleTrainingFirstPage.descController.text.isNotEmpty}");
                  if(AddModuleTrainingFirstPage.titleController.text.isNotEmpty && AddModuleTrainingFirstPage.descController.text.isNotEmpty && list.length>0) {
                    Map map = {
                      "title": AddModuleTrainingFirstPage.titleController.text
                          .toUpperCase(),
                      "desc": AddModuleTrainingFirstPage.descController.text,
                      "exercises": list
                    };
                    setState(() {
                      AddTrainingFirstPage.treining.add(map);
                      AddModuleTrainingFirstPage.titleController.text = "";
                      AddModuleTrainingFirstPage.descController.text = "";
                      AddModuleTrainingSecondPage.zeroSecondList();
                    });
                    Navigator.pop(context,AddTrainingFirstPage.treining);
                  }
                },
                color: Colors.green,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Concluir",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                    Icon(Icons.navigate_next, color: Colors.white)
                  ],
                )),
          );
        }
      }


      return Scaffold(
        body: Container(
          color: Colors.grey[200],
          child: Stack(

              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child:

                      Container(alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top:40,left:10),
                        child: IconButton(
                          icon: Icon(Icons.navigate_before,color: Colors.black,size: 40,),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),),),
                    Expanded(
                        flex: 2,
                        child:
                        Container(
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
                              child: getNextButton(_selectedIndex)),
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
                                    color: (_selectedIndex == 0)? Colors.grey[850]: Colors.white,
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
                                    color: (_selectedIndex == 1)? Colors.grey[850]: Colors.white,
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
                                    color: (_selectedIndex == 2)? Colors.grey[850]: Colors.white,
                                    border: Border.all(),
                                    boxShadow: <BoxShadow>[
                                      new BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 10.0,
                                        offset: new Offset(0.0, 10.0),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),

              ]),
        ),
      );
    }
  Widget setPage(int index) {
      if(_exercises==null || _exercises == []){
        completeExercise();
      }
    switch (index) {
      case 2:
        return AddModuleTrainingThirdPage();
      case 1:
        return AddModuleTrainingSecondPage(_exercises);
      case 0:
      default:
        print(AddModuleTrainingSecondPage.secondFinalList);
        return AddModuleTrainingFirstPage();
    }
  }
  }
