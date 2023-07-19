import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colab_ezzyfy_solutions/controller/Auth/firebase_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route/route.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  String countryCode = '+91';
  FirebaseController firebaseController = FirebaseController.to;

  RxBool passwordVisibal = RxBool(false);

  void signIn() {
    firebaseController.isLoginRequest = true;
    firebaseController.fbLogin(countryCode  + mobileNumber.text.toString());
  }

  void firebasePhoneSignIn() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '9510443624',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // await FirebaseAuth.instance.signInWithCredential(credential);
        print("verificationCompleted");
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        // navigate to next screen
        verifyOtp(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void firebaseAuthCheck() {
    FirebaseAuth.instance
        // .authStateChanges()
        .idTokenChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        firebasePhoneSignIn();
      } else {
        print('User is signed in!');
      }
    });
  }

  void firestoreDatabase() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('users');
  }

  Future<void> verifyOtp(String verificationId) async {
    // code for calling from OTP Screen to login.
    /*
    * var value = Get.arguments;
    if (value != null) {
      controller.verifyOtp(value);
    }
    * */
    try {
      String smsCode = '000000';
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      // Sign the user in (or link) with the credential
      FirebaseAuth.instance.signInWithCredential(credential).then((value){
        print("LOGIN ${value?.user?.phoneNumber}");
      });
    } catch (e) {
      if (e is FirebaseAuthException &&
          e.code == 'invalid-verification-code') {
        print("codeSent exception");
        print("${e.code} ${e.message}");
      } else {
        print("codeSent else");
      }
    }
  }
}
