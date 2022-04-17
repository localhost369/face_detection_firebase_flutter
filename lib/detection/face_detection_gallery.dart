import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:face_detector/painter/smile_painter.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:ui' as ui show Image;
import 'package:image_picker/image_picker.dart';

class DetectionFromGallery extends StatefulWidget {
  @override
  _DetectionFromGalleryState createState() => _DetectionFromGalleryState();
}

class _DetectionFromGalleryState extends State<DetectionFromGallery> {
  bool loading = true;
  ui.Image image;
  List<Face> faces;
  final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();

  Future<ui.Image> _loadImage(File file) async {
    final data = await file.readAsBytes();
    return await decodeImageFromList(data);
  }

  void pickAndProcessImage() async {
    final File file = await pickImage(ImageSource.gallery);
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(file);
    try {
      faces = await faceDetector.processImage(visionImage);
      image = await _loadImage(file);
    } on Exception catch (error) {
      log(error.toString());
    }

    setState(() {
      loading = false;
    });
  }

  Future<File> pickImage(ImageSource source,
      {CameraDevice preferredCameraDevice = CameraDevice.rear}) async {
    PickedFile imagePickedFile = await ImagePicker().getImage(
        source: source,
        preferredCameraDevice: preferredCameraDevice,
        imageQuality: 50,
        maxHeight: 1280,
        maxWidth: 960);
    if (imagePickedFile != null) {
      if (await File(imagePickedFile.path).length() >= 2097152) {
        // _snackbarService.showCustomSnackBar(
        //     duration: Duration(seconds: 5),
        //     message: "The File may not be greater than 2 MB.");
      } else
        return File(imagePickedFile.path);
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face detection with Smile'),
      ),
      body: Center(
        child: loading
            ? Text('Press The floating Action Button for load image!')
            : FittedBox(
                child: SizedBox(
                  width: image.width.toDouble(),
                  height: image.height.toDouble(),
                  child: FacePaint(
                    painter: SmilePainter(image, faces),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickAndProcessImage,
        child: Icon(Icons.image),
      ),
    );
  }
}
