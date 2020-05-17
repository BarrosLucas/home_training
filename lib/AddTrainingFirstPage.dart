import 'package:flutter/material.dart';
import 'package:hometraining/AddMTSecondPage.dart';
import 'package:hometraining/AddModuleTraining.dart';

class AddTrainingFirstPage extends StatefulWidget {
  @override
  _AddTrainingFirstPageState createState() => _AddTrainingFirstPageState();
}

class _AddTrainingFirstPageState extends State<AddTrainingFirstPage> {
  List treining = [];



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Expanded(
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
        child: Container(
          child: ListView.builder(
              itemCount: treining.length + 1, itemBuilder: generateRow),
        ),
      ),
    ]));
  }

  Widget generateRow(context, index) {
    if(index < treining.length) {
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
                    color: new Color(0xCCFFFFFF),
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
                          print("Clicou: $index");
                        },
                        title: Container(
                          padding: EdgeInsets.all(5),
                          child: new Text(treining[index]['title'],
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
                              treining[index]['desc'],
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
                  image: new AssetImage("assets/images/Imagem5.png"),
                  height: 92.0,
                  width: 92.0,
                ),
              )
            ],
          ));
    }else{
      return addButtonDefault();
    }
  }

  Widget addButtonDefault() {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        decoration: new BoxDecoration(
          color: new Color(0xCCFFFFFF),
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
            alignment: Alignment(0, 0),
            child: new ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddModuleTraining()));
              },
              title: Container(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.add_circle, color: Colors.red, size: 70),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text("ADICIONAR MÓDULO",
                              style: new TextStyle(
                                fontSize: 25.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        )
                      ],
                    ),
                  )),
            )));
  }
}
