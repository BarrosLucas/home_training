import 'dart:ui';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChallengeDone extends StatefulWidget {
  final Map<String, dynamic> challenge;
  ChallengeDone(this.challenge);
  @override
  _ChallengeDoneState createState() => _ChallengeDoneState(this.challenge);
}

class _ChallengeDoneState extends State<ChallengeDone> {
  final Map<String,dynamic> challenge;
  _ChallengeDoneState(this.challenge);

  var key = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: key,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            child: Text(
                              "Desafio Concluído!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.black54),
                            ),
                            padding: EdgeInsets.only(left: 20,top: 130),
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(right: 20,top: 130),
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
                                    await Share.file('esys image', 'esys.png', pngBytes, 'image/png', text: 'Olha só o desafio que acabei de completar!!!');
                                  }
                                  takescrshot();
                                  print("VEIOOO");
                                },
                              )),
                          flex: 1,
                        )
                      ]),
                ]),flex: 2,),
            Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                  child: Column(children: <Widget>[
                    Image.asset(
                        'assets/images/Imagem8.png')
                  ]
                    ,
                  mainAxisAlignment: MainAxisAlignment.center,),
                )),
            Expanded(
              flex: 1,
              child: Text(
                "PARABÉNS",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child:
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:Text(
                challenge['done'],
                textAlign: TextAlign.center,style: TextStyle(fontSize: 16),
              )),
            )
          ],
        ),
      )
    );
  }
}
