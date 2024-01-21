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
  late List<XFile> selectedVideos;
  late bool isCamera = false;
  late bool isGallery = false;
  late bool isVideo = false;

  Future<List<File>> pickImage(BuildContext context,
      {bool allowMultipleImages = false}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Row(
                children: [
                  const Expanded(child: Text("Select Attachment")),
                  InkWell(
                    child: const Icon(Icons.clear),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: const Text("Gallery"),
                      onTap: () async {
                        isGallery = true;
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
                        isCamera = true;
                        Get.back();

                        // print("camera---");
                        // print(file.toString());
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: const Text("Pick multiple photos"),
                      onTap: () async {
                        isGallery = true;
                        allowMultipleImages = true;
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
                  ],
                ),
              ));
        }).then((value) async {
      if (isCamera) {
        selectedImages = (await _pickImageFromCamera(context));
      } else if (isGallery) {
        selectedImages =
            (await _pickImageFromGallery(context, allowMultipleImages: allowMultipleImages));
      } else {
        // click on Close icon to dismiss dialog
      }
      if (selectedImages.firstOrNull?.path != null && allowMultipleImages == false) {
        var result =
            await FlutterPhotoEditor().editImage(selectedImages.first.path);
        if (result == false) {
          return [];
        }
      }
      return selectedImages;
    });
  }

  Future<List<XFile>> pickVideo(BuildContext context,
      {bool allowMultipleImages = false}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Row(
                children: [
                  const Expanded(child: Text("Select Video Attachment")),
                  InkWell(
                    child: const Icon(Icons.clear),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: const Text("Video from gallery"),
                      onTap: () async {
                        isVideo = true;
                        Get.back();
                      },
                    ),
                  ],
                ),
              ));
        }).then((value) async {
      if (isVideo) {
        selectedVideos = (await _pickVideoFromGallery(context));
      } else {
        // click on Close icon to dismiss dialog
      }
      return selectedVideos;
    });
  }

  Future<List<File>> _pickImageFromGallery(BuildContext context,
      {bool allowMultipleImages = false}) async {
    List<File> fileTemp = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultipleImages, // allowMultipleImages
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'jpeg',
      ],
    );
    if (result != null) {
      fileTemp = result.paths.map((path) => File(path ?? '')).toList();

      if(allowMultipleImages == false) {
        for (int i = 0; i < fileTemp.length; i++) {
          int sizeInBytes = fileTemp[i].lengthSync();
          double sizeInMb = sizeInBytes / (1024 * 1024);
          if (sizeInMb < 30) {
          } else {
            Get.showErrorSnackbar('File size is more then 30 MB');
            fileTemp.removeAt(i);
          }
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

  Future<List<XFile>> _pickVideoFromGallery(BuildContext context) async {
    List<XFile> file = [];
    var picture = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
      maxDuration: Duration(minutes: 3)
    );
    file.add(XFile(picture!.path, mimeType: picture!.mimeType, name: picture!.name,
    length: await picture!.length(), bytes: await picture!.readAsBytes(),
    lastModified: await picture!.lastModified()));
    return file;
  }

}
