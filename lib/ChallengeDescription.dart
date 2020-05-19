import 'package:flutter/material.dart';
import 'package:hometraining/ChallengeRun.dart';
import 'package:video_player/video_player.dart';

import 'TrainingRunFirstPage.dart';

class ChallengeDescription extends StatefulWidget {
  final String _title;
  final String _desc;

  ChallengeDescription(this._title, this._desc);

  @override
  _ChallengeDescriptionState createState() =>
      _ChallengeDescriptionState(this._title, this._desc);
}

class _ChallengeDescriptionState extends State<ChallengeDescription> {
  final String _title;
  final String _desc;

  _ChallengeDescriptionState(this._title, this._desc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
              child: Container(


                  child: Stack(children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.only(top: 40, left: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.navigate_before,
                                  color: Colors.black,
                                  size: 40,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ]))),
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
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
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
          ]))),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                child: Column(children: <Widget>[
                  Video(
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
                ],
                mainAxisAlignment: MainAxisAlignment.end
                  ,),
              )),
          Expanded(
            child: Text(_desc),
          ),
          Expanded(
              child: Container(
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
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChallengeRun(_title, 3, 10)));
                          },
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                child: Text(
                                  "PARTICIPAR",
                                  style: TextStyle(color: Colors.white),
                                ),
                                padding: EdgeInsets.all(5),
                              )
                            ],
                          ),
                          color: Colors.green,
                        ))
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
