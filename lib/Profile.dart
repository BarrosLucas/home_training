import 'dart:convert';
import 'package:flutter/material.dart';
import 'file.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String,dynamic> _profile;

  int calories = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController challengesController = TextEditingController();

  void completeProfile() async{
    _profile = json.decode(await AccessFile.readData())['profile'];
    setState(() {
      _profile=_profile;
      nameController.text = _profile['name'];
      daysController.text = "${_profile['trainingDays']}";
      challengesController.text = "${_profile['fullChallenge']}";
      calories=_profile['calories'];
    });
    print(_profile);
  }

  @override
  void initState() {
    super.initState();
    completeProfile();
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
                  padding: EdgeInsets.all(45),
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
                          "$calories",
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

}
