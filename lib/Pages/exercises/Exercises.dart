import 'package:do_it/Pages/exercises/BackLayer.dart';
import 'package:do_it/Pages/exercises/ImageBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';

class Exercise extends StatefulWidget {
  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
    title: Text("DO IT",
            style: TextStyle(
                color: Colors.white,
                fontSize: 27.0,
                letterSpacing: 5,
                fontWeight: FontWeight.bold)),
    backLayer: Center(
        child: BackLayer(),
    ),
    frontLayer: Center(
        child: ImageBuilder(),
    ),
    iconPosition: BackdropIconPosition.leading,
    
);
  }
}


