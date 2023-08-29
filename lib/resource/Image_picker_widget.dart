import 'dart:io';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePickerWidget {


  Future<List<File>> pickImageFromGallery(BuildContext context, {bool allowMultipleImages = true}) async {
    List<File> fileTemp = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultipleImages,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'jpeg',
      ],
    );
    if (result != null) {
      fileTemp =
      result.paths.map((path) => File(path ?? '')).toList();
      return fileTemp;
      /*for (int i = 0; i < fileTemp.length; i++) {
        int sizeInBytes = fileTemp[i].lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb < 30) {
        } else {
          Get.showErrorSnackbar('File size is more then 30 MB');
        }
      }*/
    } else {
      // User canceled the picker
      return fileTemp;
    }
  }

}