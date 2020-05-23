import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTrainingSecondPage extends StatefulWidget {
  static TextEditingController titleController = TextEditingController();
  static TextEditingController descController = TextEditingController();
  @override
  _AddTrainingSecondPageState createState() => _AddTrainingSecondPageState();
}

class _AddTrainingSecondPageState extends State<AddTrainingSecondPage> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:
        Column(children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20, top: 60),
                child: Text("NOVO\nTREINO",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              )),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                    child: TextField(
                    controller: AddTrainingSecondPage.titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      labelText: "Título",
                    ),
                  ),),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                    child: TextField(
                    controller: AddTrainingSecondPage.descController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      labelText: "Objetivo",
                    ),
                  ),)

                ],
              ),

          ),
        ]));
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }

  @override
  void dispose() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft
      ]);
      super.dispose();
  }


}
