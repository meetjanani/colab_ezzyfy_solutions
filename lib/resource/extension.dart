import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension VoidExtensions on void {
  showProgress() {
    Get.dialog(Container(
        alignment: FractionalOffset.center,
        child: const CircularProgressIndicator(strokeWidth: 1)));
  }

  void hideProgressBar() {
    Get.back();
  }

  showErrorSnackbar(String? message) {
    Get.snackbar("There was a problem", message!,
        colorText: Colors.black, backgroundColor: Colors.white);
  }

  showSuccessSnackbar(String? message) {
    Get.snackbar("Success", message!,
        colorText: Colors.black);
  }

  showSnackbar(String? title,String? message) {
    Get.snackbar(title!, message!,
        colorText: Colors.black, backgroundColor: Colors.white);
  }
}
