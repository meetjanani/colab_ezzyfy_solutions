import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker {
  late File file;
  Future<File> showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title:const Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child:const Text("Gallery"),
                      onTap: () async {
                        file = (await _openGallery(context))!;
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child:const Text("Camera"),
                      onTap: () async {
                        file = (await _openCamera(context))!;
                        // print("camera---");
                        // print(file.toString());
                      },
                    )
                  ],
                ),
              ));
        }).then((value) {
      return file;

    });
  }

  final picker = ImagePicker();
  Future<File?> _openGallery(BuildContext context) async {
    // var picture = await ImagePicker.platform.pickImage(source: ImageSource.gallery, imageQuality: 50);
    XFile? picture =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 20);


    // f1=
    // this.setState(() {
    //   imageFile = picture;
    //   uploadImage();
    // });
    Navigator.of(context).pop();
    File file = File(picture!.path);

    return file;
  }

  Future<File?> _openCamera(BuildContext context) async {
    var picture = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );

    Navigator.of(context).pop();


    File file = File(picture!.path);
    return file;
  }
}