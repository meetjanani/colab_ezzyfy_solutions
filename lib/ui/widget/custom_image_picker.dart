import 'dart:io';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_photo_editor/flutter_photo_editor.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker {
  late List<File> selectedImages;
  late bool isCameraOrGallery = true;

  Future<List<File>> pickImage(BuildContext context,
      {bool allowMultipleImages = true}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Row(
                children: [
                  const Expanded(child: Text("Select Attachment")),
                  InkWell(child: const Icon(Icons.clear),
                  onTap: (){
                    Get.back();
                    hideProgressBar();
                  },),
                ],
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: const Text("Gallery"),
                      onTap: () async {
                        isCameraOrGallery = false;
                        Get.back();
                        /*selectedImages = (await _pickImageFromGallery(context,
                            allowMultipleImages: true))!;
                        if (selectedImages.firstOrNull?.path != null) {
                          Get.back();
                          await FlutterPhotoEditor()
                              .editImage(selectedImages.first!.path);
                        }*/
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: const Text("Camera"),
                      onTap: () async {
                        isCameraOrGallery = true;
                        Get.back();


                        // print("camera---");
                        // print(file.toString());
                      },
                    )
                  ],
                ),
              ));
        }).then((value) async {
          if(isCameraOrGallery) {
            selectedImages = (await _pickImageFromCamera(context))!;
          } else {
            selectedImages = (await _pickImageFromGallery(context,
                allowMultipleImages: true))!;
          }
      if (selectedImages.firstOrNull?.path != null) {
        var result = await FlutterPhotoEditor()
            .editImage(selectedImages.first.path);
        if(result == false) {
          return [];
        }
      }
      return selectedImages;
    });
  }

  Future<List<File>> _pickImageFromGallery(BuildContext context,
      {bool allowMultipleImages = true}) async {
    List<File> fileTemp = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false, // allowMultipleImages
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'jpeg',
      ],
    );
    if (result != null) {
      fileTemp = result.paths.map((path) => File(path ?? '')).toList();

      for (int i = 0; i < fileTemp.length; i++) {
        int sizeInBytes = fileTemp[i].lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb < 30) {
        } else {
          Get.showErrorSnackbar('File size is more then 30 MB');
          fileTemp.removeAt(i);
        }
      }
      return fileTemp;
    } else {
      // User canceled the picker
      return fileTemp;
    }
  }

  Future<List<File>> _pickImageFromCamera(BuildContext context) async {
    List<File> file = [];
    var picture = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );
    file.add(File(picture!.path));
    return file;
  }
}
