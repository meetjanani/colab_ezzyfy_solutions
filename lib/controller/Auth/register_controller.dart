import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool passwordVisibal = RxBool(false);
  RxBool passwordVisibal2 = RxBool(false);
  RxBool isSelect1 = RxBool(false);

  void registerUser() {
    var mobileNumber = "14142525363";
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentReference counterRef = users.doc(mobileNumber);
    users
        .where('phoneNumber', isEqualTo: mobileNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        users.add({
          'name': 'user One', // John Doe
          'phoneNumber': mobileNumber, // Stokes and Sons
        }).then((value) {
          value.update({'value': mobileNumber}).then((value) {
            print("User Added");
          });
        }).catchError((error) => print("Failed to add user: $error"));
      } else {
        print("User is already exists");
      }
    });
  }
}
