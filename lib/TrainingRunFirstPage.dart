import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hometraining/TrainingRunSecondPage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:screen/screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'TrainingRun.dart';
import 'file.dart';

class TrainingRunFirstPage extends StatefulWidget {
  final String _title;
  final List exercisesOfModule;

  TrainingRunFirstPage(this._title, this.exercisesOfModule);

  @override
  _TrainingRunFirstPageState createState() =>
      _TrainingRunFirstPageState(this._title, this.exercisesOfModule);
}

class _TrainingRunFirstPageState extends State<TrainingRunFirstPage> {
  final List exercisesOfModule;
  final String _title;
  int selectedIndex = 0;
  bool visible = false;
  bool waiting = false;
  double calor = 0;
  final snackBar = SnackBar(content: Text("Não pode descansar mais que um minuto", style: TextStyle(color: Colors.white),),backgroundColor: Colors.red[900],);
  var currentExercise;
  Stopwatch stopwatch = Stopwatch();
  Stopwatch stopwatchSeconder = Stopwatch();
  Stopwatch stopwatchWaiting = Stopwatch();
  int page = 0;
  List<Map<dynamic, dynamic>> listTraning = [];
  List<YoutubePlayerController> _controllers;
  int totalTimer = 30;
  final GlobalKey<AnimatedCircularChartState> _key =
      new GlobalKey<AnimatedCircularChartState>();

  _TrainingRunFirstPageState(this._title, this.exercisesOfModule);

  int second = 0;
  int series = 0;
  var key = GlobalKey();
  Map<String, dynamic> _profile;
  Timer _timer;


  List<CircularStackEntry> circularStackEntry = <CircularStackEntry>[
    new CircularStackEntry(<CircularSegmentEntry>[
      new CircularSegmentEntry(30, Colors.green[400]),
      new CircularSegmentEntry(0, Colors.grey)
    ])
  ];
  final List<CircularStackEntry> initialCircularStackEntry = <CircularStackEntry>[
    new CircularStackEntry(<CircularSegmentEntry>[
      new CircularSegmentEntry(30, Colors.green[400]),
      new CircularSegmentEntry(0, Colors.grey)
    ])
  ];

  void completeProfile() async {
    _profile = json.decode(await AccessFile.readData())['profile'];
    setState(() {
      _profile = _profile;
    });
  }

  void sumCalories(int timeSeconds, var calPerSecond) {
    _profile['calories'] += calPerSecond * timeSeconds;
    calor += calPerSecond * timeSeconds;
    setState(() {
      AccessFile.map['profile'] = _profile;
      AccessFile.saveData();
    });
  }

  void addToList(String time, String title) {
    Map<String, String> map = Map();
    map['time'] = time;
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

    if (timerSecond > 0 &&
        series == exercisesOfModule[selectedIndex]['settings'][0]) {
      addToList(TimerTextFormatter.format(timerSecond),
          exercisesOfModule[selectedIndex]['title']);
      sumCalories((stopwatchSeconder.elapsedMilliseconds / 1000).toInt(),
          exercisesOfModule[selectedIndex]['settings'][1]);
    }

    if (selectedIndex < (exercisesOfModule.length - 1)) {
      setState(() {
        selectedIndex++;
        series = 0;
        stopwatchSeconder.reset();
      });
    } else {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  TrainingRunSecondPage(_title, listTraning, calor)));
    }
  }

  void before() {
    if (stopwatchSeconder.isRunning) {
      stopwatchSeconder.reset();
      stopwatchSeconder.stop();
    }
    if (stopwatch.isRunning) {
      stopwatch.stop();
    }

    if (selectedIndex > 0) {
      setState(() {
        selectedIndex--;
      });
    }
  }

  void alert(int act) {
    bool isRunning = stopwatchSeconder.isRunning;
    if (stopwatchSeconder.isRunning) {
      stopwatchSeconder.stop();
    }
    if (stopwatch.isRunning) {
      stopwatch.stop();
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Mudar exercício"),
            content: Text("Se mudar ele não será contabilizado no treino"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                  if (isRunning) {
                    stopwatchSeconder.start();
                    stopwatch.start();
                  }
                },
              ),
              FlatButton(
                child: Text("Sim"),
                onPressed: () {
                  if (isRunning) {
                    stopwatchSeconder.start();
                    stopwatch.start();
                  }
                  if (act == 0) {
                    //Avançar
                    Navigator.pop(context);
                    next();
                  } else {
                    //voltar
                    Navigator.pop(context);
                    before();
                  }
                },
              )
            ],
          );
        });
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

  void showRegressiveTimer() {
    setState(() {
      waiting = true;
    });
    stopwatchWaiting.start();
    double second = double.parse(TimerTextFormatter.formatToOnlySeconds(
        stopwatchWaiting.elapsedMilliseconds, totalTimer));

    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      print("uai: ${timer.toString()}");
      if (this._key.currentState.mounted) {
        if (stopwatchWaiting.isRunning) {
          print("Vindo...");
          second = double.parse(TimerTextFormatter.formatToOnlySeconds(
              stopwatchWaiting.elapsedMilliseconds, totalTimer));
          circularStackEntry = <CircularStackEntry>[
            new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(second, Colors.green[400]),
                  new CircularSegmentEntry(totalTimer-second, Colors.grey)
                ]
            )
          ];
          setState(() {
            _key.currentState.updateData(circularStackEntry);
            if (waiting) {
              print("Second: $second");
              print("TotalTimer: $totalTimer");
              if (second <= 0) {
                setState(() {
                  stopwatchWaiting.stop();
                  stopwatchWaiting.reset();
                  _timer.cancel();
                  waiting = false;
                  stopwatch.start();
                  stopwatchSeconder.start();
                  totalTimer = 30;
                  second = 30;
                });
              }
            }
          });
        }
      }
    });
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
                  child: generateListVideo(),
                  margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Visibility(
                        visible: (selectedIndex > 0) ? true : false,
                        child: IconButton(
                          icon: Icon(
                            Icons.navigate_before,
                            size: 40,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              if (selectedIndex > 0) {
                                alert(1);
                              }
                            });
                          },
                        ),
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
                            alert(0);
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
                      generateProgressBarGeneral(
                          exercisesOfModule[selectedIndex]['settings'][0],
                          series,
                          Colors.white,
                          Colors.green[300],
                          180,
                          20,
                          leading: "Séries",
                          trailing:
                              "$series/${exercisesOfModule[selectedIndex]['settings'][0]}")
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
                                if (stopwatchSeconder.isRunning) {
                                  stopwatchSeconder.stop();
                                  stopwatch.stop();
                                  series++;
                                  if (series ==
                                      exercisesOfModule[selectedIndex]
                                          ['settings'][0]) {
                                    Future.delayed(Duration(seconds: 2), () {
                                      next();
                                    });
                                  } else {
                                    setState(() {
                                      showRegressiveTimer();
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
        )),
        Visibility(
          visible: waiting,
          child: Container(
              color: new Color(0xEE000000),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: AnimatedCircularChart(
                      size: const Size(300, 300),
                      initialChartData: initialCircularStackEntry,
                      key: _key,
                      chartType: CircularChartType.Radial,
                    ),
                  ),
                  Center(
                    child: Text(
                      TimerTextFormatter.formatToOnlySeconds(
                        stopwatchWaiting.elapsedMilliseconds, totalTimer),
                      style: TextStyle(fontSize: 80,color: Colors.white),),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.all(30),
                      child: IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.green[400],
                          size: 50,
                        ),
                        onPressed: (){
                          setState(() {
                            if(totalTimer < 50){
                              totalTimer += 10;
                            }else{
                              totalTimer = 59;
                              TrainingRun.scaffoldKey.currentState.showSnackBar(snackBar);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.all(30),
                      child: IconButton(
                        icon: Icon(
                          Icons.pause_circle_filled,
                          color: Colors.red[900],
                          size: 50,
                        ),
                        onPressed: (){
                          setState(() {
                            stopwatchWaiting.stop();
                            stopwatchWaiting.reset();
                            waiting = false;
                            _timer.cancel();
                            stopwatch.start();
                            stopwatchSeconder.start();
                            totalTimer = 30;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    alignment: Alignment.topCenter,
                    child: Text(
                      "É hora de descansar!\nAproveite para beber água...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }

  @override
  void dispose() {
    Screen.keepOn(false);
    super.dispose();
  }

  Widget generateListVideo() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Visibility(
            visible: (selectedIndex == index) ? true : false,
            child: YoutubePlayer(
              key: ObjectKey(_controllers[index]),
              controller: _controllers[index],
              showVideoProgressIndicator: true,
            ));
      },
      itemCount: _controllers.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return pageOne();
  }

  List<String> generateIDVideos() {
    List<String> list = [];
    for (var i = 0; i < exercisesOfModule.length; i++) {
      list.add(YoutubePlayer.convertUrlToId(exercisesOfModule[i]['link']));
    }
    return list;
  }

  List<YoutubePlayerController> generateControllers() {
    List<YoutubePlayerController> list = [];
    list = generateIDVideos()
        .map<YoutubePlayerController>(
          (videoId) => YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              autoPlay: false,
            ),
          ),
        )
        .toList();
    return list;
  }

  @override
  void initState() {
    super.initState();
    completeProfile();
    Screen.keepOn(true);

    setState(() {
      currentExercise = exercisesOfModule[selectedIndex];
    });

    _controllers = generateIDVideos()
        .map<YoutubePlayerController>(
          (videoId) => YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              autoPlay: false,
            ),
          ),
        )
        .toList();
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

  static String formatToOnlySeconds(int milliseconds, int total) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();

    int waiting = total - (seconds % 60);

    String secondsStr = waiting.toString().padLeft(2, "0");

    return '$secondsStr';
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
