import 'package:do_it/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:do_it/Pages/do_it/ImageTaker.dart';
import 'package:do_it/utils/SlideTransition.dart';

class GatePose extends StatefulWidget {
  @override
  _GatePoseState createState() => _GatePoseState();
}

class _GatePoseState extends State<GatePose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cow Pose',
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
  @override
  Widget build(BuildContext context) {
    var description =
        "Step 1\n\nStart on your hands and knees in a \"tabletop\" position. Make sure your knees are set directly below your hips and your wrists, elbows and shoulders are in line and perpendicular to the floor. Center your head in a neutral position, eyes looking at the floor.\n\nStep 2\n\nAs you inhale, lift your sitting bones and chest toward the ceiling, allowing your belly to sink toward the floor. Lift your head to look straight forward.\n\nStep 3\n\nExhale, coming back to neutral \"tabletop\" position on your hands and knees. Repeat 10 to 20 times.";
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Image.asset("images/cowpose.jpg"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
              child: Text(
            "$description",
            overflow: TextOverflow.visible,
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold),
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
                  SlideRightRoute(widget: ImageTaker(3)),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
