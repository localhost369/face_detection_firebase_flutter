import 'package:face_detector/detection/face_detection_gallery.dart';
import 'package:face_detector/painter/detection/face_detection_camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Always Smile while using app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              minWidth: 200.0,
              height: 35,
              color: Colors.teal,
              child: new Text('Choose Image from Gallery',
                  style: new TextStyle(fontSize: 16.0, color: Colors.white)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetectionFromGallery(),
                  ),
                );
              },
            ),
            MaterialButton(
              minWidth: 200.0,
              height: 35,
              color: Colors.teal,
              child: new Text('Use Camera',
                  style: new TextStyle(fontSize: 16.0, color: Colors.white)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetectionFromCamera(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
