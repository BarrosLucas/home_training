import 'package:flutter/material.dart';

class AddModuleTrainingSecondPage extends StatefulWidget {
  static List fullExercises;
  AddModuleTrainingSecondPage(FullExercises){
    if(FullExercises==null){
      print("NULLLLLL");
    }
    fullExercises=FullExercises;
    print("AAAAAAA");
  }
  static List secondList = [];
  static List secondFinalList = [];

  static void generateFinalListSecond(){
    secondFinalList = [];
    for(var i = 0; i < secondList.length;i++){
      if(secondList[i]['doing']){
        secondFinalList.add(secondList[i]);
      }
    }
  }

  static void generateSecondList(title,bool doing,int amount,int index) {

    Map<String, dynamic> newToDo = Map();
    newToDo['title'] = title;
    newToDo['doing'] = doing;
    newToDo['amount'] = amount;
    newToDo['index'] = index;
    AddModuleTrainingSecondPage.secondList.add(newToDo);

  }



  static void zeroSecondList(){
    AddModuleTrainingSecondPage.secondList=[];

    if(AddModuleTrainingSecondPage.fullExercises!= null) {
      for (var i = 0; i < AddModuleTrainingSecondPage.fullExercises.length; i++) {
        generateSecondList(AddModuleTrainingSecondPage.fullExercises[i]['title'], false,AddModuleTrainingSecondPage.fullExercises[i]['settings'][0],i);
      }
    }

  }

  static List generateFinalList(){
    List ret = [];
    for(var i = 0; i < secondFinalList.length;i++){
      if(secondFinalList[i]['doing']){
        print("Titulo full: ${fullExercises[secondFinalList[i]['index']]['title']}");
        print("Second: ${secondFinalList[i]['amount']}");
        fullExercises[secondFinalList[i]['index']]['settings'][0] = secondFinalList[i]['amount'];
        ret.add(fullExercises[secondFinalList[i]['index']]);
      }
    }
    return ret;
  }

  @override
  _AddModuleTrainingSecondPageState createState() =>
      _AddModuleTrainingSecondPageState(fullExercises);
}

class _AddModuleTrainingSecondPageState
    extends State<AddModuleTrainingSecondPage> {

  final List fullExercises;
  _AddModuleTrainingSecondPageState(this.fullExercises);

  //List _exercises = [];

  @override
  Widget build(BuildContext context) {
    print("exercisesFull: ");
    print("$fullExercises");
    print("${fullExercises.length}");
    return Expanded(
        child:
        Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20, top: 60),
                  child: Text("NOVO\nMÓDULO",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                )),
            Expanded(
              child: ListView.builder(itemBuilder:buidItem, padding: EdgeInsets.only(top: 10),
                itemCount: fullExercises.length,),
            )
          ],
    ));
  }

  @override
  void initState() {
    super.initState();
    if(fullExercises!= null) {
      for (var i = 0; i < fullExercises.length; i++) {
        AddModuleTrainingSecondPage.generateSecondList(fullExercises[i]['title'], false, fullExercises[i]['settings'][0],i);
      }
    }
    setState(() {
      AddModuleTrainingSecondPage.secondList = AddModuleTrainingSecondPage.secondList;
    });
  }

  Widget buidItem(context, index) {
    return CheckboxListTile(
      title:

          Text(AddModuleTrainingSecondPage.secondList[index]['title']),


      value: AddModuleTrainingSecondPage.secondList[index]['doing'],
      secondary: CircleAvatar(
          child: new Image(
            image: new AssetImage("assets/images/Imagem5.png"),
            height: 92.0,
            width: 92.0,
          )
      ),
      onChanged: (check) {
        setState(() {
          AddModuleTrainingSecondPage.secondList[index]['doing'] = check;
        });
      },
    );
  }
}

