import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hometraining/HomePageBody.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset(
                "assets/images/Imagem2.png",
                width: 150,
                height: 150,
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  new HomePageBody("TREINO 1", "Descrição 1"),
                  new HomePageBody("TREINO 2", "Descrição 2"),
                  new HomePageBody("TREINO 3", "Descrição 3"),
                ],
              ),
            ),
          ),
        ]),
        Align(
          alignment: Alignment.topRight,
          child:
          Padding(
          padding: EdgeInsets.only(right: 20,top:40),
          child: Text("TREINOS",
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 40,
                  fontWeight: FontWeight.bold)),
          )

        )
      ],
    );
  }
}
