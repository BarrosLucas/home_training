import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hometraining/TrainingRunSecondPage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';
import 'file.dart';


class TrainingRunFirstPage extends StatefulWidget {
  final String _title;
  final List exercisesOfModule;


  TrainingRunFirstPage(this._title,this.exercisesOfModule);

  @override
  _TrainingRunFirstPageState createState() =>
      _TrainingRunFirstPageState(this._title,this.exercisesOfModule);
}

class _TrainingRunFirstPageState extends State<TrainingRunFirstPage> {
  final List exercisesOfModule;
  final String _title;
  int selectedIndex = 0;
  bool visible = false;
  double calor = 0;

  var currentExercise;
  Stopwatch stopwatch = Stopwatch();
  Stopwatch stopwatchSeconder = Stopwatch();
  int page = 0;
  List<Map<dynamic,dynamic>> listTraning = [];
  _TrainingRunFirstPageState(this._title,this.exercisesOfModule);
  int second = 0;
  int series = 0;
  var key = GlobalKey();
  Map<String,dynamic> _profile;


  void completeProfile() async{
    _profile = json.decode(await AccessFile.readData())['profile'];
    setState(() {
      _profile=_profile;
    });
  }

  void sumCalories(int timeSeconds, var calPerSecond){
    _profile['calories'] += calPerSecond*timeSeconds;
    calor += calPerSecond*timeSeconds;
    setState(() {
      AccessFile.map['profile'] = _profile;
      AccessFile.saveData();
    });
    print("Calories:");
    print(_profile);
  }

  void addToList(String time, String title){
    Map<String,String> map = Map();
    map['time']  = time;
    map['title'] = title;
    listTraning.add(map);
  }

  void next() {
    int timerSecond = stopwatchSeconder.elapsedMilliseconds;

    if (stopwatchSeconder.isRunning) {
      stopwatchSeconder.reset();
      stopwatchSeconder.stop();
    }
    if (stopwatch.isRunning) {
      stopwatch.stop();
    }
    addToList(TimerTextFormatter.format(timerSecond), exercisesOfModule[selectedIndex]['title']);
    sumCalories((stopwatchSeconder.elapsedMilliseconds/1000).toInt(), exercisesOfModule[selectedIndex]['settings'][1]);
    if (selectedIndex < (exercisesOfModule.length - 1)) {
      setState(() {
        selectedIndex++;
        series = 0;
        stopwatchSeconder.reset();
      });
    } else {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingRunSecondPage(_title,listTraning,calor)));
    }
  }

  void before() {
    if (selectedIndex > 0) {
      selectedIndex--;
    }
  }

  Widget buildItem(context, index) {
    return ListTile(
      title: Text(
        "${index + 1}. ${exercisesOfModule[index]['title']}",
        style: TextStyle(
            fontWeight:
                (selectedIndex == index) ? FontWeight.bold : FontWeight.normal),
      ),
      onTap: () {
        setState(() {
          visible = false;
          selectedIndex = index;
        });
        print("Item clicado: ${exercisesOfModule[index]['title']}");
      },
    );
  }

  Widget dialogWidget(Widget child) {
    return Visibility(
        visible: visible,
        child: Container(
          color: new Color(0x99000000),
          child: Center(
            child: Container(
              height: 400,
              width: 300,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    decoration: new BoxDecoration(
                      color: new Color(0xFFFFFFFF),
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
                    child: child,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                visible = false;
                              });
                            },
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget cronometer(TextStyle textStyle, int which) {
    Timer timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (this.mounted) {
        if (stopwatch.isRunning) {
          setState(() {});
        }
        if (stopwatchSeconder.isRunning) {
          setState(() {});
        }
      }
    });

    String formattedTime;
    if (which == 0) {
      formattedTime = TimerTextFormatter.format(stopwatch.elapsedMilliseconds);
    } else {
      formattedTime =
          TimerTextFormatter.format(stopwatchSeconder.elapsedMilliseconds);
    }

    return Text(
      formattedTime,
      style: textStyle,
    );
  }

  Widget pageOne() {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 140),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 00),
                        alignment: Alignment.topLeft,
                        child: cronometer(
                            TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                            0),
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
                        onPressed: () {
                          setState(() {
                            before();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Text(
                          (exercisesOfModule.length > 0)
                              ? "${selectedIndex + 1}. ${exercisesOfModule[selectedIndex]['title']}"
                              : "",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          setState(() {
                            visible = true;
                            print("Clicado");
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(
                          Icons.navigate_next,
                          size: 40,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            next();
                            /*if (selectedIndex < (_exercises.length - 1)) {
                              selectedIndex++;
                              print("Veio: $selectedIndex");
                              print("Total: ${_exercises.length}");
                            } else {}*/
                          });
                        },
                      ),
                    )
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      generateProgressBarGeneral(exercisesOfModule[selectedIndex]['settings'][0], series,
                          Colors.white, Colors.green[300], 180, 20,
                          leading: "Séries", trailing: "$series/${exercisesOfModule[selectedIndex]['settings'][0]}")
                    ]),
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
                          child: cronometer(TextStyle(fontSize: 50), 1),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Center(
                              child: IconButton(
                            icon: Icon(
                              (stopwatchSeconder.isRunning)
                                  ? Icons.check_circle
                                  : Icons.play_circle_filled,
                              color: (stopwatchSeconder.isRunning)
                                  ? Colors.green
                                  : Colors.red,
                              size: 50,
                            ),
                            onPressed: () {
                              setState(() {
                                print(
                                    "isRunning: ${stopwatchSeconder.isRunning}");
                                if (stopwatchSeconder.isRunning) {
                                  stopwatchSeconder.stop();
                                  stopwatch.stop();
                                  series++;
                                  if (series == exercisesOfModule[selectedIndex]['settings'][0]) {
                                    Future.delayed(Duration(seconds: 2), () {
                                      next();
                                    });
                                  }
                                } else {
                                  stopwatchSeconder.start();
                                  stopwatch.start();
                                }
                              });
                            },
                          )))
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    generateProgressBarGeneral((exercisesOfModule.length - 1),
                        (selectedIndex), Colors.white, Colors.red, 280, 15)
                  ],
                )
              ],
            ),
          ),
        ),
        dialogWidget(ListView.builder(
          itemBuilder: buildItem,
          padding: EdgeInsets.all(1),
          itemCount: exercisesOfModule.length,
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return pageOne();
  }

  @override
  void initState() {
    super.initState();
    completeProfile();
    setState(() {
      currentExercise = exercisesOfModule[selectedIndex];
    });
    print("Teste: ");


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
    return Stack(
      children: <Widget>[
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
                    child: Stack(
                      children: <Widget>[
                        VideoPlayer(_controller),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 45,
                            height: 45,
                            color: new Color(0xAAFFFFFF),
                            child: Center(
                                child: IconButton(
                              onPressed: () {
                                print("CLICOU");
                                setState(() {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                });
                              },
                              alignment: Alignment.center,
                              icon: Icon(
                                (_controller.value.isPlaying)
                                    ? Icons.pause_circle_outline
                                    : Icons.play_circle_outline,
                                color: Colors.black,
                                size: 35,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ));
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

Widget generateProgressBarGeneral(int total, int current, Color background,
    Color progresssBar, double width, double height,
    {String leading, String trailing}) {
  print("Total: $total");
  print("Curre: $current");
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
