import 'dart:convert';
import 'dart:ui';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'file.dart';
class TrainingRunSecondPage extends StatefulWidget {
  final List _list;
  final String _title;
  final double calor;
  TrainingRunSecondPage(this._title,this._list,this.calor);
  @override
  _TrainingRunSecondPageState createState() => _TrainingRunSecondPageState(this._title,this._list,this.calor);
}

class _TrainingRunSecondPageState extends State<TrainingRunSecondPage> {
  final List _list;
  final String _title;
  Map<String, dynamic> _profile;
  final double calor;
  var key = GlobalKey();



  _TrainingRunSecondPageState(this._title,this._list,this.calor);
  Widget pageTwo(List list) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex:4,
              child: Center(
                child: Image.asset(
                  "assets/images/Imagem8.png",
                ),
              ),
            ),

          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 140, left: 20,right: 20),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      child: Text(
                        "Treino Concluído!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black54),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Colors.black,
                          ),
                          onPressed: (){
                            takescrshot() async {
                              //final _imageSaver =  ImageSaver();
                              RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
                              var image = await boundary.toImage();
                              var byteData = await image.toByteData(format: ImageByteFormat.png);
                              var pngBytes = byteData.buffer.asUint8List();
                              print(pngBytes);
                              //final res = await _imageSaver.saveImage(imageBytes: pngBytes,imageName: DateTime.now().toIso8601String(),directoryName: (await getApplicationDocumentsDirectory ()).path);
                              await Share.file('At Home', 'esys.png', pngBytes, 'image/png', text: 'Acabei de concluir meu treino! Olha meu desempenho <3');
                            }
                            takescrshot();
                            print("VEIOOO");
                          },
                        )),
                    flex: 1,
                  )
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: 500,
                  child: generateList(_list),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(45),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: new Offset(0.0, 10.0),
                      ),
                    ]),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.wb_sunny,
                      color: Colors.black,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 5),
                      child: Text(
                        '${calor.toStringAsPrecision(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    Text(
                      "CAL",
                      style: TextStyle(fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget generateList(List list){
    return ListView.builder(itemBuilder: buildItemFinish,itemCount: list.length,padding: EdgeInsets.only(top: 15),);
  }

  Widget buildItemFinish(context,index){
    return ListTile(
      title: Text(_list[index]['title']),
      leading: Text(_list[index]['time']),
    );
  }

  void completeProfile() async{
    _profile = json.decode(await AccessFile.readData())['profile'];
    print("Aqui");
    print(_profile);
    setState(() {
      _profile=_profile;
      if(!dateEqual(_profile["lastDayTraining"])){
        _profile["lastDayTraining"] = new DateFormat("yyyy-MM-dd").format(DateTime.now());
        _profile["trainingDays"]++;
        AccessFile.map['profile']=_profile;
        AccessFile.saveData();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    
    completeProfile();
    print("lastDayTraining:");
    print(_profile);

  }


  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
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
          pageTwo(_list),
        ])),key: key,);
  }

  bool dateEqual(String date){
    print(date);
    if (date.isEmpty) {
      return false;
    } else {
      var today = new DateTime.now();
      var other = DateTime.parse(date);

      if(today.difference(other).inDays == 0){
        return true;
      }
    }
    return false;
  }
}
