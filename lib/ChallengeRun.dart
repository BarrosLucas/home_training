import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hometraining/ChallengeDone.dart';

class ChallengeRun extends StatefulWidget {
  final String _title;
  int _qnt;
  final int _total;

  ChallengeRun(this._title, this._qnt, this._total);

  @override
  _ChallengeRunState createState() =>
      _ChallengeRunState(this._title, this._qnt, this._total);
}

class _ChallengeRunState extends State<ChallengeRun> {
  final String _title;
  int _qnt;
  final int _total;


  _ChallengeRunState(this._title, this._qnt, this._total);

  List<Widget> generateRows() {
    print("Qnt.: $_qnt");
    List<Widget> listRows = [];
    double lines = _total / 5;
    for (var i = 0; i < lines; i++) {

      List<Widget> listExpa = [];
      for (var j = 0; (j < 5 && (i * 5 + j) <= _total); j++) {
        listExpa.add(Expanded(
            flex: 1,
            child: InkWell(
              child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(23),
                  decoration: BoxDecoration(
                    color: (((i*5+j) + 1) <= _qnt) ? Colors.green : Colors.red[900],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${(i * 5 + j) + 1}',
                    style: TextStyle(color: Colors.white),
                  )),
            )
        ));
      }
      listRows.add(Row(
        children: listExpa,
      ));
    }
    return listRows;
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(children: <Widget>[
      Expanded(child:
      Stack(children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child:
                Container(

                    margin: EdgeInsets.only(top: 40, left: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[IconButton(
                          icon: Icon(
                            Icons.navigate_before,
                            color: Colors.black,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        ]))
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
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 1, child: Container(),),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20, top: 40),
                    child: Text(_title.toUpperCase(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                  ))
            ]),
      ])),
      Expanded(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: generateRows(),
      )),
      Expanded(child: Container(
        margin: EdgeInsets.only(bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          if(_qnt<_total){
                            _qnt++;
                          }
                          if(_qnt==_total){
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChallengeDone()));
                          }
                        });
                      },
                      padding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(child: Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                          ),
                            padding: EdgeInsets.only(right: 10),),

                          Padding(child: Text(
                            "DIA CONCLUÍDO",
                            style: TextStyle(color: Colors.white),
                          ),
                            padding: EdgeInsets.only(left: 10),)
                        ],
                      ),
                      color: Colors.green,
                    ))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            child: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,),
                            padding: EdgeInsets.only(right: 10),),
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "SAIR DO DESAFIO",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                      color: Colors.red[900],
                    ))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )
          ],
        ),
      ))
    ]),
  );
}}
