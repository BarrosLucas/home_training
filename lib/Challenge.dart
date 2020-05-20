import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'ChallengeDescription.dart';
import 'ChallengeDone.dart';
import 'ChallengeRun.dart';
import 'file.dart';

class Challenge extends StatefulWidget {
  @override
  _ChallengeState createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {
  List _challenges = [];
  void completeChallenge() async{
    print("Uafa");
    print(json.decode(await AccessFile.readData())['challenge']);
    _challenges = json.decode(await AccessFile.readData())['challenge'];
    setState(() {
      _challenges=_challenges;
    });
  }

  @override
  void initState() {
    super.initState();
    completeChallenge();
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
    if(_challenges[index]["isIn"]){
      if(getOut(_challenges[index]["lastDay"])){
        _challenges[index]["isIn"] = false;
        _challenges[index]["result"] = "over";
        _challenges[index]["lastDay"] = "";
        _challenges[index]["amountDay"] = 0;
          AccessFile.map["challenge"] = _challenges;
          AccessFile.saveData();
      }
    }

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
                  color: _challenges[index]['isIn']? new Color(0x6677DD77) : new Color(0x66F80000),
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
                        if(!(_challenges[index]['isIn'])){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChallengeDescription(_challenges[index],index)));
                        }else{
                          if(!finished(_challenges[index])){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChallengeRun(_challenges[index],index)));
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChallengeDone(_challenges[index])));
                          }
                      }},
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

  bool finished(Map<String,dynamic> challenge){
    print("qnt: ${challenge['amountDay']}");
    print("tot: ${challenge['amountTotal']}");
    if(challenge["amountDay"] ==
        challenge["amountTotal"]){
      return true;
    }
    return false;
  }

  bool getOut(String date){
    if(date.isEmpty){
      return false;
    }
    var today = new DateTime.now();
    var other = DateTime.parse(date);

    var differenceInDay = today.difference(other).inDays;
    if(differenceInDay>1){
      return true;
    }
    return false;
  }

}
