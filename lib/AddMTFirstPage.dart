import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class AddModuleTrainingFirstPage extends StatefulWidget {
  static TextEditingController titleController = TextEditingController();
  static TextEditingController descController = TextEditingController();
  @override
  _AddModuleTrainingFirstPageState createState() => _AddModuleTrainingFirstPageState();
}

class _AddModuleTrainingFirstPageState extends State<AddModuleTrainingFirstPage> {



  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:
        Column(children: <Widget>[
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                  child: TextField(
                    controller: AddModuleTrainingFirstPage.titleController,
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
                    controller: AddModuleTrainingFirstPage.descController,
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    super.initState();
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
