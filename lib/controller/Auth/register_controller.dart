import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegisterController extends GetxController{


  static RegisterController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool passwordVisibal = RxBool(false);
  RxBool passwordVisibal2 = RxBool(false);
  RxBool isSelect1 = RxBool(false);
}