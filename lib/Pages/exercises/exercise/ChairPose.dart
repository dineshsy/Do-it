import 'package:do_it/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:do_it/Pages/do_it/ImageTaker.dart';
import 'package:do_it/utils/SlideTransition.dart';

class ChairPose extends StatefulWidget {
  @override
  _ChairPoseState createState() => _ChairPoseState();
}

class _ChairPoseState extends State<ChairPose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chair Pose',
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
      "Step 1\n\nStand in Tadasana. Inhale and raise your arms perpendicular to the floor. Either keep the arms parallel, palms facing inward, or join the palms.\n\nStep 2\n\nExhale and bend your knees, trying to take the thighs as nearly parallel to the floor as possible. Keep the inner thighs parallel to each other and press the heads of the thigh bones down toward the heels.\n\nStep 3\n\nFirm your shoulder blades against the back. Take your tailbone down toward the floor and in toward your pubis to keep the lower back long.\n\nStep 4\n\nStay for 30 seconds to a minute. To come out of this pose straighten your knees with an inhalation, lifting strongly through the arms. Exhale and release your arms to your sides into Tadasana.";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Image.asset("images/chairpose.png"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
              child: Text(
            "$description",
            overflow: TextOverflow.visible,
            style: TextStyle(fontSize: 9.7, fontWeight: FontWeight.bold),
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
                  SlideRightRoute(widget: ImageTaker(2)),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
