import 'package:flutter/material.dart';

class AddModuleTrainingSecondPage extends StatefulWidget {
  static List fullExercises;
  AddModuleTrainingSecondPage(FullExercises){
    fullExercises=FullExercises;
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
    if(secondFinalList!= null){
      if(secondFinalList.length>0){
        secondFinalList = orderList(secondFinalList);
      }
    }

  }

  static List orderList(List list){
    int minSequence = list[0]['sequence'];
    int minIndex = 0;

    List ret = [];

    while(list.length>0){
      int ind = 0;
      while(ind < list.length){
        if(list[ind]['sequence']<minSequence){
          minSequence = list[ind]['sequence'];
          minIndex = ind;
        }
        ind++;
      }
      ret.add(list[minIndex]);
      list.removeAt(minIndex);
      if(list.length>0){
        minSequence = list[0]['sequence'];
      }
      minIndex = 0;
    }

    return ret;
  }

  static void generateSecondList(title,bool doing,int amount,int index,int sequence) {

    Map<String, dynamic> newToDo = Map();
    newToDo['title'] = title;
    newToDo['doing'] = doing;
    newToDo['amount'] = amount;
    newToDo['index'] = index;
    newToDo['sequence'] = sequence;
    AddModuleTrainingSecondPage.secondList.add(newToDo);

  }



  static void zeroSecondList(){
    AddModuleTrainingSecondPage.secondList=[];

    if(AddModuleTrainingSecondPage.fullExercises!= null) {
      for (var i = 0; i < AddModuleTrainingSecondPage.fullExercises.length; i++) {
        generateSecondList(AddModuleTrainingSecondPage.fullExercises[i]['title'], false,AddModuleTrainingSecondPage.fullExercises[i]['settings'][0],i,-1);
      }
    }

  }

  static List generateFinalList(){
    List ret = [];
    for(var i = 0; i < secondFinalList.length;i++){
      if(secondFinalList[i]['doing']){
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


  int sequence = 0;
  //List _exercises = [];

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
        AddModuleTrainingSecondPage.generateSecondList(fullExercises[i]['title'], false, fullExercises[i]['settings'][0],i,-1);
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
          if(check) {
            AddModuleTrainingSecondPage.secondList[index]['sequence'] =
                sequence;
            sequence++;
          }else{
            AddModuleTrainingSecondPage.secondList[index]['sequence'] = -1;
          }
        });
      },
    );
  }
}

