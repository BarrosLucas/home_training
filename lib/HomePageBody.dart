import 'package:flutter/material.dart';
import 'package:hometraining/MuscleRow.dart';

class HomePageBody extends StatelessWidget {
  String _title;
  String _desc;
  HomePageBody(this._title,this._desc);
  @override
  Widget build(BuildContext context) {
    return new MuscleRow(_title,_desc);
  }
}