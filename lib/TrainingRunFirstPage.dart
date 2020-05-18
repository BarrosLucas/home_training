import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';

class TrainingRunFirstPage extends StatefulWidget {
  final String _title;

  TrainingRunFirstPage(this._title);

  @override
  _TrainingRunFirstPageState createState() =>
      _TrainingRunFirstPageState(this._title);
}

class _TrainingRunFirstPageState extends State<TrainingRunFirstPage> {
  final String _title;

  _TrainingRunFirstPageState(this._title);

  int second = 0;

  @override
  Widget build(BuildContext context) {
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();

    Stopwatch stopwatchSeconder = Stopwatch();

    return
      SingleChildScrollView(
          child: Column(

            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top:00),
                      alignment: Alignment.topLeft,
                      child: TimerText(stopwatch,
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              Container(
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
                child: Video(
                    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
                margin: EdgeInsets.all(30),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        Icons.navigate_before,
                        size: 40,
                        color: Colors.black,
                      ),
                      onPressed: (){},
                    ),
                  ),
                  Expanded(
                    child:
                    Text("1. Nome do Treino",style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),textAlign: TextAlign.center,),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        Icons.navigate_next,
                        size: 40,
                        color: Colors.black,
                      ),
                      onPressed: (){},
                    ),
                  )
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[ generateProgressBarGeneral(3, 1, Colors.white, Colors.green[300],180,20,leading: "Séries",trailing: "1/3")]),
              Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 60,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child:TimerText(stopwatchSeconder,TextStyle(fontSize: 50)),
                      ),),
                    Container(
                        padding: EdgeInsets.all(5),
                        child: Center(
                            child: IconButton(
                              icon: Icon(Icons.play_circle_filled, color: Colors.red,size: 50,),
                            )
                        ))
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 20),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  generateProgressBarGeneral(8, 3, Colors.white, Colors.red,280,15)
                ],
              )
            ],
          ),
        );

  }
}

class TimerText extends StatefulWidget {
  final Stopwatch stopwatch;
  final TextStyle textStyle;

  TimerText(this.stopwatch, this.textStyle);

  @override
  _TimerTextState createState() =>
      _TimerTextState(this.stopwatch, this.textStyle);
}

class _TimerTextState extends State<TimerText> {
  final Stopwatch stopwatch;
  final TextStyle textStyle;
  Timer timer;


  _TimerTextState(this.stopwatch, this.textStyle) {

    timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if(this.mounted) {
        if (stopwatch.isRunning) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        TimerTextFormatter.format(stopwatch.elapsedMilliseconds);
    return Text(
      formattedTime,
      style: textStyle,
    );
  }
}

class TimerTextFormatter {
  static String format(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, "0");

    return '$minutesStr:$secondsStr';
  }
}

class Video extends StatefulWidget {
  final String linkVideo;

  Video(this.linkVideo);

  @override
  _VideoState createState() => _VideoState(linkVideo);
}

class _VideoState extends State<Video> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  final String linkVideo;

  _VideoState(this.linkVideo);

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      linkVideo,
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Stack(children: <Widget>[
      Container(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the VideoPlayer.
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child:
                Stack(
                children: <Widget>[
                  VideoPlayer(_controller),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 45,
                      height: 45,
                      color: new Color(0xAAFFFFFF),

                      child:
                      Center(child: IconButton(
                        onPressed: (){
                          print("CLICOU");
                          setState(() {
                            if(_controller.value.isPlaying){
                              _controller.pause();
                            }else{
                              _controller.play();
                            }
                          });
                        },
                        alignment: Alignment.center,
                        icon:
                        Icon(
                          (_controller.value.isPlaying)?Icons.pause_circle_outline:Icons.play_circle_outline,
                          color: Colors.black,
                          size: 35,
                        ),
                      )),
                    ),
                  ),
                ],
                )
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),

    ],
    );
   }
}

Widget generateProgressBarGeneral(int total, int current, Color background, Color progresssBar,double width, double height, {String leading, String trailing}){
  var percent = 100*(current/total);
  return Padding(
    padding: EdgeInsets.all(15),
    child: LinearPercentIndicator(
      width: width,
      animation: true,
      animationDuration: 1000,
      lineHeight: height,
      leading: Padding(
        padding: EdgeInsets.all(10),
        child: Text(leading?? '',style: TextStyle(
        fontSize: 15,
        color: Colors.grey[600]
      ),),),
      trailing: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
        trailing??'',style: TextStyle(
        fontSize: 15,
        color: Colors.grey[600]
      ),
      ),),
      percent: (current/total),
      center: Text("${percent.toStringAsPrecision(2)}%"),
      linearStrokeCap: LinearStrokeCap.roundAll,
      backgroundColor: background,
      progressColor: progresssBar,
    ),
  );
}