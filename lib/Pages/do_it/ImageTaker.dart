import 'dart:io';
import 'package:do_it/utils/Post.dart';
import 'package:do_it/utils/SlideTransition.dart';
import 'package:do_it/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:do_it/Pages/do_it/Results.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImageTaker extends StatefulWidget {
  final int N;
  ImageTaker(this.N);
  @override
  _ImageTakerState createState() => _ImageTakerState(this.N);
}

class _ImageTakerState extends State<ImageTaker> {
  final int N;
  _ImageTakerState(this.N);
  var isLoaded = true;
  bool switchControl = false;
  bool loading = false;
  File _image;
  int index = 0;
  var type = [ImageSource.camera, ImageSource.gallery];
  List post;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: type[index]);

    setState(() {
      _image = image;
    });
  }

  String url;

  Future imageUploadHelperJSON(int N, File f) async {
    var res = await apiRequest(N, f);
    setState(()  {
      post = res;
    });
    
    print(post[0]);
  }

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
      });

      // Put your code here which you want to execute on Switch ON event.
      setState(() {
        index = 1;
      });
    } else {
      setState(() {
        switchControl = false;
      });
      setState(() {
        index = 0;
      });
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan It',style:buildTextStyle(Colors.white)),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: _image == null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Select an image',
                            style: buildTextStyle(Colors.black),
                          ),
                        )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(height: 250, child: Image.file(_image)),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: RaisedButton(
                                onPressed: () async {
                                  // await imageUploadHelper(_image);
                                  setState(() {
                                    loading = true;
                                  });
                                  await imageUploadHelperJSON(N, _image);
                                  setState(() {
                                    loading = false;
                                  });
                                  Navigator.push(
                                    context,
                                    SlideRightRoute(widget: Results(post)),
                                  );
                                },
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
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Toggle to choose image from gallery",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                    ),
                    Switch(
                      onChanged: toggleSwitch,
                      value: switchControl,
                      activeColor: Colors.blue,
                      activeTrackColor: Colors.greenAccent,
                      inactiveThumbColor: Colors.blue,
                      inactiveTrackColor: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
           loading
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black26,
                )
              : SizedBox(),
          loading
              ? Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height/4,
                    width: MediaQuery.of(context).size.width/1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                    ),
                    child: SpinKitWave(
                      color: Colors.white,
                    ),
                  ),
                )
              : SizedBox(),
         
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _image = null;
          getImage();
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
