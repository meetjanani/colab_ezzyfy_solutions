import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/resource/firebase_dayabase_schema.dart';
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
    firebasePhoneSignIn(phoneNumber);
    /*FirebaseAuth.instance
        // .authStateChanges()
        .idTokenChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        firebasePhoneSignIn(phoneNumber);
      } else {
        print('User is signed in!');
      }
    });*/
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
        if (!isLoginRequest) {
          fbRegister();
        } else {
          // TODO: MEET Firebase Route have to update
          Get.offNamed(AppRoute.splash);
        }
        Get.showSuccessSnackbar('Login successfully.');
      });
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'invalid-verification-code') {
        print("codeSent exception");
        Get.showErrorSnackbar('${e.code} - ${e.message}');
      } else {
        Get.showErrorSnackbar('Firebase error occured.');
      }
    }
  }

  void fbRegister() async {
    var mobileNumber = userRegisterData[FirebaseDatabaseSchema.phoneNumberCol];
    CollectionReference users = FirebaseFirestore.instance.collection(FirebaseDatabaseSchema.usersTable);
    users
        .where(FirebaseDatabaseSchema.phoneNumberCol, isEqualTo: mobileNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        users.doc(mobileNumber).set(userRegisterData).then((value) {
          Get.showSuccessSnackbar('New user successfully created.');
          // TODO: MEET Firebase Route have to update
          Get.offNamed(AppRoute.login);
        }).catchError((error) => Get.showSuccessSnackbar('Failed to add user: $error'));
      } else {
        Get.showErrorSnackbar('User is already exists');
      }
    });
  }

  Future<void> signOutUser() async {
    FirebaseAuth.instance.signOut();
  }
}
