import 'package:flutter/material.dart';
import 'TrainingRunFirstPage.dart';

class TrainingRun extends StatefulWidget {
  final String _title;

  TrainingRun(this._title);

  @override
  _TrainingRunState createState() => _TrainingRunState(_title);
}

class _TrainingRunState extends State<TrainingRun> {
  final String _title;

  _TrainingRunState(this._title);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(children: <Widget>[
          Container(
              color: Colors.grey[200],
              child:Column(
                children: <Widget>[
                  Stack(children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 40, left: 10),
                            child: IconButton(
                              icon: Icon(
                                Icons.navigate_before,
                                color: Colors.black,
                                size: 40,
                              ),
                              onPressed: () {
                                print("UAI");
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
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
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20, top: 60),
                          child: Text(_title.toUpperCase(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                        )),
                  ]),
                  setPage(_selectedIndex),
                ],
              )


              )
        ]));
  }

  Widget setPage(int index) {
    switch (index) {
      case 1:
        return Container();
      case 0:
      default:
        print("AQUI");
        return TrainingRunFirstPage(_title);
    }
  }
}
