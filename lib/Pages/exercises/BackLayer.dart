import 'package:do_it/utils/Utils.dart';
import 'package:flutter/material.dart';

class BackLayer extends StatefulWidget {
  @override
  _BackLayerState createState() => _BackLayerState();
}

class _BackLayerState extends State<BackLayer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.white,
                ),
            width: 200,
            height: 200,
          ),
        ),
        FlatButton(
          onPressed: () {},
          child: Text(
            "Profile",
            style: buildTextStyle(Colors.white),
          ),
        ),
        FlatButton(
            onPressed: () {}, child: Text("Home", style: buildTextStyle(Colors.white))),
        FlatButton(
            onPressed: () {}, child: Text("Rate us!", style: buildTextStyle(Colors.white))),
        FlatButton(
            onPressed: () {}, child: Text("Share!", style: buildTextStyle(Colors.white))),
      ],
    );
  }

}