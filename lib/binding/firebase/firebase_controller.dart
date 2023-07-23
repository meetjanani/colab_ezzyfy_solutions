import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/resource/firebase_database_schema.dart';
import 'package:colab_ezzyfy_solutions/shared/get_storage_repository.dart';
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
    await signOutUser().then((value) => firebaseAuthCheck(phoneNumber));
  }

  Future<void> firebaseAuthCheck(String phoneNumber) async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      GetStorageRepository(Get.find()).write('fbUser', currentUser);
    } else {
      firebasePhoneSignIn(phoneNumber);
    }
  }

  void firebasePhoneSignIn(String phoneNumber) async {
    try {
      showProgress();
      await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("verificationCompleted");
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          hideProgressBar();
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
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: OtpPage(
              verificationId: verificationId,
            ),
          );
        });
  }

  Future<void> verifyOtpForLoginUser(String verificationId, String otp) async {
    try {
      showProgress();
      String smsCode = otp;
      PhoneAuthCredential credential = await PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((authResult) {
        var getStorage = GetStorageRepository(Get.find());
        getStorage.write('UserCredential', authResult);
        getStorage.write('isAuthSignIn', true); // for use to Auto loading
        hideProgressBar();
        if (!isLoginRequest) {
          fbRegister();
        } else {
          Get.offNamed(AppRoute.home);
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
    showProgress();
    var mobileNumber = userRegisterData[FirebaseDatabaseSchema.phoneNumberCol];
    CollectionReference users = FirebaseFirestore.instance
        .collection(FirebaseDatabaseSchema.usersTable);
    users
        .where(FirebaseDatabaseSchema.phoneNumberCol, isEqualTo: mobileNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        users.doc(mobileNumber).set(userRegisterData).then((value) {
          Get.showSuccessSnackbar('New user successfully created.');
          hideProgressBar();
          Get.offNamed(AppRoute.login);
        }).catchError(
            (error) => Get.showSuccessSnackbar('Failed to add user: $error'));
      } else {
        Get.showErrorSnackbar('User is already exists');
      }
    });
  }

  Future<void> signOutUser() async {
    FirebaseAuth.instance.signOut();
  }
}
