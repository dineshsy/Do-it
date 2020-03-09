import 'package:flutter/material.dart';

import 'exercises/Exercises.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Rubik'),
      home: Exercise(),
    );
  }
}
