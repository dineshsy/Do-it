import 'package:do_it/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Results extends StatefulWidget {
  final List post;
  Results(this.post);
  @override
  _ResultsState createState() => _ResultsState(this.post);
}

class _ResultsState extends State<Results> {
  final List post;
  _ResultsState(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result',style:buildTextStyle(Colors.white)),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Final(post),
    );
  }
}

class Final extends StatefulWidget {
  final List post;
  Final(this.post);
  @override
  _FinalState createState() => _FinalState(this.post);
}

class _FinalState extends State<Final> {
  final List post;
  _FinalState(this.post);
  double rating;
  @override
  void initState() {
    setState(() {
      rating = ratingHandler(post);
    });

    super.initState();
  }

  double ratingHandler(List post) {
    // int n;
    if(post.length <= 2){
      return 5;
    }
    var correct = (post.length / 14) * 5;

    return 5-correct;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        
        Center(
          child: RatingBar(
            initialRating: rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            ignoreGestures: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ),
        (post.length > 1) ?
        Column(children: <Widget>[
        Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Positions needs to be improved :',style: TextStyle(fontSize: 20,letterSpacing: 5,fontWeight: FontWeight.bold)),
            ),
      Container(
        height: MediaQuery.of(context).size.height/2.5,
        width: MediaQuery.of(context).size.height/1.5,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          
          itemCount: post.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('\t - ${post[index]}',style: TextStyle(fontSize: 20,letterSpacing: 5,)),
            );
              
        },
      ))],): Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('You\'re doing great!',style: TextStyle(fontSize: 20,letterSpacing: 5,)),
            )
        
                ],
              );
            }
          
        
}
