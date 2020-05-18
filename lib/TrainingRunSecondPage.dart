import 'dart:ui';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class TrainingRunSecondPage extends StatefulWidget {
  final List _list;
  final String _title;
  TrainingRunSecondPage(this._title,this._list);
  @override
  _TrainingRunSecondPageState createState() => _TrainingRunSecondPageState(this._title,this._list);
}

class _TrainingRunSecondPageState extends State<TrainingRunSecondPage> {
  final List _list;
  final String _title;
  var key = GlobalKey();
  _TrainingRunSecondPageState(this._title,this._list);
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
                              await Share.file('esys image', 'esys.png', pngBytes, 'image/png', text: 'Acabei de concluir meu treino! Olha meu desempenho <3');
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
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(30),
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
                        "1000",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    Text(
                      "KCAL",
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
}
