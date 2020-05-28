import 'package:flutter/material.dart';
import 'TrainingRunFirstPage.dart';

class TrainingRun extends StatefulWidget {
  final String _title;
  bool visibility;
  final List exercisesOfModule;
  TrainingRun(this._title,this.visibility,this.exercisesOfModule);

  @override
  _TrainingRunState createState() => _TrainingRunState(_title,visibility,this.exercisesOfModule);
}

class _TrainingRunState extends State<TrainingRun> {
  bool _visibility;
  final String _title;

  final List exercisesOfModule;
  _TrainingRunState(this._title,this._visibility,this.exercisesOfModule){
  }

  int _selectedIndex = 0;

  Future<bool> _requestPop() {
    showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Abandonar Treino"),
              content: Text("Se sair seu treino não poderá ser continuado"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
        return WillPopScope(
          onWillPop: _requestPop,
          child: Scaffold(
              backgroundColor: Colors.grey[200],
              body: Stack(children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                setPage(_selectedIndex),
              ])),
        );
  }

  Widget setPage(int index) {
    switch (index) {
      case 1:
        return Container();
      case 0:
      default:
        return TrainingRunFirstPage(_title,exercisesOfModule);
    }
  }
}
