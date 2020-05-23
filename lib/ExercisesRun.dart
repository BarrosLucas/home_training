import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'TrainingRunFirstPage.dart';

class ExercisesRun extends StatefulWidget {
  final String _title;
  final int total;
  final String _link;
  ExercisesRun(this._title,this.total,this._link);
  @override
  _ExercisesRunState createState() => _ExercisesRunState(this._title,this.total,this._link);
}

class _ExercisesRunState extends State<ExercisesRun> {
  Stopwatch stopwatch = Stopwatch();
  int current = 0;

  YoutubePlayerController _controller;
  final String _title;
  final int total;
  final String _link;
  _ExercisesRunState(this._title,this.total,this._link);


  Widget cronometer(TextStyle textStyle) {
    Timer timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (this.mounted) {
        if (stopwatch.isRunning) {
          setState(() {});
        }
      }
    });

    String formattedTime =  TimerTextFormatter.format(stopwatch.elapsedMilliseconds);

    return Text(
      formattedTime,
      style: textStyle,
    );
  }


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
                              flex: 4,
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
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                child:
                SingleChildScrollView(
                 child: Column(
                   children: <Widget>[
                     YoutubePlayer(
                       key: ObjectKey(_controller),
                       controller: _controller,
                       showVideoProgressIndicator: true,
                     ),
                     Row(children:<Widget>[Text(
                       _title,style:TextStyle(
                         fontSize: 24
                     ),
                     ),],
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,),

                     Padding(
                       padding: EdgeInsets.only(top: 50),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           cronometer(TextStyle(color: Colors.black,fontSize: 50)),
                           IconButton(
                             icon: Icon(
                               (stopwatch.isRunning)? Icons.check_circle:Icons.play_circle_filled,
                               color: (stopwatch.isRunning)? Colors.green:Colors.red,
                               size: 50,
                             ),
                             onPressed: (){
                               if(stopwatch.isRunning){
                                 setState(() {
                                   stopwatch.stop();
                                   current++;
                                   if (current == total) {
                                     Future.delayed(Duration(seconds: 2), () {
                                       setState(() {
                                         current = 0;
                                       });

                                     });
                                   }
                                 });
                               }else{
                                 setState(() {
                                   stopwatch.start();
                                 });
                               }
                             },
                           )
                         ],
                       )
                     )

                   ],
                   mainAxisAlignment: MainAxisAlignment.end
                   ,),
                )
              )),
          Expanded(
            flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  generateProgressBarGeneral(total,current,Colors.grey[350],Colors.green,190,30,leading: "Séries",trailing: "$current/$total")
          ])
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(this._link),
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }
}
Widget generateProgressBarGeneral(int total, int current, Color background,
    Color progresssBar, double width, double height,
    {String leading, String trailing}) {
  var percent = 100 * (current / total);
  return Padding(
    padding: EdgeInsets.all(15),
    child: LinearPercentIndicator(
      width: width,
      animation: true,
      animationDuration: 1000,
      lineHeight: height,
      leading: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          leading ?? '',
          style: TextStyle(fontSize: 15, color: Colors.grey[600]),
        ),
      ),
      trailing: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          trailing ?? '',
          style: TextStyle(fontSize: 15, color: Colors.grey[600]),
        ),
      ),
      percent: (current / total),
      center:
      Text((percent < 100) ? "${percent.toStringAsPrecision(2)}%" : "100%"),
      linearStrokeCap: LinearStrokeCap.roundAll,
      backgroundColor: background,
      progressColor: progresssBar,
    ),
  );
}
