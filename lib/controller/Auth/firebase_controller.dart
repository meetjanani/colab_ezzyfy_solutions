import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route/route.dart';
import '../../ui/pages/Auth/otp_bottomsheet.dart';

class FirebaseController extends GetxController {
  static FirebaseController get to => Get.find();

  var isLoginRequest = true;
  var userRegisterData = null;

  void fbLogin(String phoneNumber) async {
    await signOutUser();
    await firebaseAuthCheck(phoneNumber);
  }

  Future<void> firebaseAuthCheck(String phoneNumber) async {
    FirebaseAuth.instance
        // .authStateChanges()
        .idTokenChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        firebasePhoneSignIn(phoneNumber);
      } else {
        print('User is signed in!');
      }
    });
  }

  void firebasePhoneSignIn(String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("verificationCompleted");
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          // navigate to next screen
          navigateToOTPScreen(verificationId: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void navigateToOTPScreen({required String verificationId}) {
    // verifyOtpForLoginUser(verificationId, "000000");
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        )),
        context: Get.context!!,
        builder: (context) {
          return OtpPage(
            verificationId: verificationId,
          );
        });
  }

  Future<void> verifyOtpForLoginUser(String verificationId, String otp) async {
    try {
      String smsCode = otp;
      PhoneAuthCredential credential = await PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
            if(!isLoginRequest) {
              fbRegister();
            }
        print("LOGIN ${value?.user?.phoneNumber}");
      });
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'invalid-verification-code') {
        print("codeSent exception");
        print("${e.code} ${e.message}");
      } else {
        print("codeSent else");
      }
    }
  }

  void fbRegister() async {
    var mobileNumber = userRegisterData['phoneNumber'];
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .where("phoneNumber", isEqualTo: mobileNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        users.doc(mobileNumber).set(userRegisterData).then((value) {
          print("User Added");
          fbLogin(mobileNumber);
        }).catchError((error) => print("Failed to add user: $error"));
      } else {
        print("User is already exists");
      }
    });
  }

  Future<void> signOutUser() async {
    FirebaseAuth.instance.signOut();
  }
}
