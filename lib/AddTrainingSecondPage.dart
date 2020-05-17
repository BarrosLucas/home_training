import 'package:flutter/material.dart';

class AddTrainingSecondPage extends StatefulWidget {
  @override
  _AddTrainingSecondPageState createState() => _AddTrainingSecondPageState();
}

class _AddTrainingSecondPageState extends State<AddTrainingSecondPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:
        Column(children: <Widget>[
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                    child: TextField(
                    controller: _titleController,
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
                    controller: _descController,
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
}
