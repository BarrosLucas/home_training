import 'package:flutter/material.dart';
import 'package:hometraining/AddMTSecondPage.dart';

class AddModuleTrainingThirdPage extends StatefulWidget {
  AddModuleTrainingThirdPage() {
    AddModuleTrainingSecondPage.generateFinalListSecond();
  }

  @override
  _AddModuleTrainingThirdPageState createState() =>
      _AddModuleTrainingThirdPageState();
}

class _AddModuleTrainingThirdPageState
    extends State<AddModuleTrainingThirdPage> {
  _AddModuleTrainingThirdPageState();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
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
          child: ListView.builder(
            itemBuilder: buildItem,
            padding: EdgeInsets.only(top: 10),
            itemCount: AddModuleTrainingSecondPage.secondFinalList.length,
          ),
        )
      ],
    ));
  }

  Widget buildItem(context, index) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            Container(
                height: 140.0,
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
                      onTap: () {},
                      title: Container(
                        padding: EdgeInsets.all(5),
                        child: new Text(
                            "${AddModuleTrainingSecondPage.secondFinalList[index]['title']}"
                                .toUpperCase(),
                            style: new TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                      subtitle: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Qnt. de Séries: "),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: RaisedButton(
                                      child: Text("-"),
                                      onPressed: () {
                                        if (AddModuleTrainingSecondPage
                                                    .secondFinalList[index]
                                                ['amount'] >
                                            1) {
                                          setState(() {
                                            AddModuleTrainingSecondPage
                                                    .secondFinalList[index]
                                                ['amount']--;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(child: Center(
                                    child: Text(
                                        "${AddModuleTrainingSecondPage.secondFinalList[index]['amount']}"),
                                  )),
                                  Expanded(child: RaisedButton(
                                    onPressed: () {
                                      setState(() {
                                        AddModuleTrainingSecondPage
                                            .secondFinalList[index]['amount']++;
                                      });
                                    },
                                    child: Text("+"),
                                  ))
                                ],
                              ),
                            ],
                          ))),
                )),
            Container(
              margin: new EdgeInsets.symmetric(vertical: 16.0),
              alignment: FractionalOffset.centerLeft,
              child: new Image(
                image: new AssetImage("assets/images/Imagem3.png"),
                height: 92.0,
                width: 92.0,
              ),
            )
          ],
        ));
  }
}
