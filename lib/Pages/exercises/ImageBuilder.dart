import 'package:do_it/Pages/exercises/exercise/BridgePose.dart';
import 'package:do_it/Pages/exercises/exercise/CatPose.dart';
import 'package:do_it/Pages/exercises/exercise/ChairPose.dart';
import 'package:do_it/Pages/exercises/exercise/GatePose.dart';
import 'package:do_it/utils/SlideTransition.dart';
import 'package:flutter/material.dart';

class ImageBuilder extends StatefulWidget {
  @override
  _ImageBuilderState createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> {
  var imageLoc = [
    "images/warriorone.jpg",
    "images/catpose.png",
    "images/chairpose.png",
    "images/cowpose.jpg"
  ];
  var imageNames = ["Warrior 1 Pose", "Cat Pose", "Chair Pose", "Cow Pose"];
  var exerciseClasses = [BridgePose(),CatPose(),ChairPose(),GatePose()];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "YOGA IS PEACE",
              style: TextStyle(fontSize: 20.0, letterSpacing: 5.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildImage(0),
                buildImage(1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildImage(2),
                buildImage(3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  imageNames[index],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                SlideRightRoute(widget: exerciseClasses[index]),
              ),
              child: Container(
                width: 120,
        height: 120,
                  decoration:
                  BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.white,
                image: DecorationImage(image: AssetImage(imageLoc[index]))),
                
              ),
            )
          ],
        ),
      ),
    );
  }
}
