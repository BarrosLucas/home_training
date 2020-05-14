import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class MuscleRow extends StatelessWidget {
  static List<String> titles = List<String>();
  static List<String> descrs = List<String>();
  static int count = 0;
  MuscleRow(String title,String descr){
    titles.add(title);
    descrs.add(descr);
    count++;
  }

  final muscleCard =
  Material(
    child:InkWell(
      onTap: (){},
      child: Container(
          height: 124.0,
          width: 500,
          margin: new EdgeInsets.only(left: 46.0),
          decoration: new BoxDecoration(
            color: new Color(0xFFFFFFAA),
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
          child: Padding(
            padding: EdgeInsets.only(left: 60),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: new Text(titles[count],
                      style: new TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        color: new Color(0xFF26C6DA),
                      )),
                ),

                new Text(
                  descrs[count],
                  style: new TextStyle(
                      fontSize: 15.5,
                      fontFamily: 'Roboto',
                      color: new Color(0xFF26C6DA)),
                )
              ],
            ),
          )),
    )
  );
  final muscleThumbnail = new Container(
    margin: new EdgeInsets.symmetric(vertical: 16.0),
    alignment: FractionalOffset.centerLeft,
    child: new Image(
      image: new AssetImage("assets/images/Imagem3.png"),
      height: 92.0,
      width: 92.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    developer.log("VEIO");
    debugPrint(titles[count]);
    return new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            muscleCard,
            muscleThumbnail,
          ],
        ));
  }
}
