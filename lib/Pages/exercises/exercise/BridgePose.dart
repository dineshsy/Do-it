import 'package:do_it/Pages/do_it/ImageTaker.dart';
import 'package:do_it/utils/SlideTransition.dart';
import 'package:do_it/utils/Utils.dart';
import 'package:flutter/material.dart';

class BridgePose extends StatefulWidget {
  @override
  _BridgePoseState createState() => _BridgePoseState();
}

class _BridgePoseState extends State<BridgePose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Warrior 1',
          style: buildTextStyle(Colors.white),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Exercise(),
    );
  }
}

class Exercise extends StatefulWidget {
  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  String description =
      "Virabhadra\'s Pose is also known as the Warrior Pose. It may seem strange to name a yoga pose after a warrior, after all, aren\'t yogis known for their non-violent ways? But remember that one of the most revered of all the yoga texts, the Bhagavad-Gita, is the dialog between two famous and feared warriors, Krishna and Arjuna, set on a battlefield between two great armies spoiling for a fight.What\'s really being commemorated in this pose\'s name, and held up as an ideal for all practitioners, is the \"spiritual warrior,\" who bravely does battle with the universal enemy, self-ignorance (avidya), the ultimate source of all our suffering.";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.center,
            child: Image.asset("images/warriorone.jpg"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Text(
            "$description",
            overflow: TextOverflow.visible,
            style: TextStyle(fontSize: 11.0),
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: RaisedButton(
            onPressed: _showDialog,
            child: Text(
              "Do It",
              style: buildTextStyle(Colors.blue),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(color: Colors.blue)),
          ),
        )
      ],
    );
  }

  void _showDialog() {
    // flutter defined function

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Instructions"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
                "1.Take the picture of your Exercise.\n2.The feedback will be given."),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  SlideRightRoute(widget: ImageTaker(0)),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
