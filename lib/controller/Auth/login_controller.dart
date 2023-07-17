import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginController extends GetxController{


  static LoginController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool passwordVisibal = RxBool(false);
}