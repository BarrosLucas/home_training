import 'package:flutter/material.dart';
import 'package:hometraining/ChallengeRun.dart';
import 'TrainingRunFirstPage.dart';
import 'file.dart';

class ChallengeDescription extends StatefulWidget {
  Map<String, dynamic> challenge;
  int ind;

  ChallengeDescription(this.challenge,this.ind);

  @override
  _ChallengeDescriptionState createState() =>
      _ChallengeDescriptionState(this.challenge,this.ind);
}

class _ChallengeDescriptionState extends State<ChallengeDescription> {
  Map<String, dynamic> challenge;
  int ind;
  _ChallengeDescriptionState(this.challenge,this.ind);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
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
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20, top: 40),
                            child: Text(challenge['title'].toUpperCase(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold)),
                          ))
                    ]),
              ])),
          SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        child: Column(
                          children: <Widget>[
                            Video(
                                challenge['link']??"")
                          ],
                          mainAxisAlignment: MainAxisAlignment.end,
                        ),
                      ),
                  Text(challenge['desc']),
                ],
              ),
            ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
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
                                  challenge['isIn'] = true;
                                  print(challenge);
                                  setState(() {
                                    AccessFile.map['challenge'][ind] = challenge;
                                    AccessFile.saveData();
                                  });

                                  print(AccessFile.map['challenge'][ind]);
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChallengeRun(
                                              challenge,ind)));
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
                ),
              ],
            ),
          )


        ],
      ),
    );
  }
}
