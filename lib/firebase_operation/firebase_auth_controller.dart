import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/resource/firebase_database_schema.dart';
import 'package:colab_ezzyfy_solutions/shared/get_storage_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../route/route.dart';
import '../ui/pages/Auth/otp_bottomsheet.dart';

class FirebaseAuthController extends GetxController {
  static FirebaseAuthController get to => Get.find();

  var isLoginRequest = true;
  var userRegisterData = null;

  void fbLogin(String phoneNumber) async {
    checkUserIsRegisteredOrNot(phoneNumber).then((isRegister) {
      if (isRegister) {
        signOutUser().then((value) => firebaseAuthCheck(phoneNumber));
      } else {
        Get.offNamed(AppRoute.register);
      }
    });
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
          navigateToOTPScreen(
              verificationId: verificationId, phoneNumber: phoneNumber);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void navigateToOTPScreen(
      {required String verificationId, required String phoneNumber}) {
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
              phoneNumber: phoneNumber,
            ),
          );
        });
  }

  Future<void> verifyOtpForLoginUser(
      String verificationId, String otp, String phoneNumber) async {
    try {
      showProgress();
      String smsCode = otp;
      PhoneAuthCredential credential = await PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((authResult) async {
        var getStorage = GetStorageRepository(Get.find());
        getStorage.write('UserCredential', authResult);
        getStorage.write('isAuthSignIn', true); // for use to Auto loading
        await getUserFromPhoneNumber(phoneNumber);
        hideProgressBar();
        Get.offNamed(AppRoute.home);
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

  Future<void> getUserFromPhoneNumber(String phoneNumber) async {
    final data = await Supabase.instance.client
        .from('users')
        .select('*').eq('mobileNumber', phoneNumber).limit(1);
    GetStorageRepository(Get.find())
        .write('supabaseUser', data);

    CollectionReference users = FirebaseFirestore.instance
        .collection(FirebaseDatabaseSchema.usersTable);
    users
        .where(FirebaseDatabaseSchema.mobileNumberCol, isEqualTo: phoneNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        GetStorageRepository(Get.find())
            .write('loggedInUser', querySnapshot.docs.first);
      } else {
        Get.showErrorSnackbar('User is Fail to identify');
      }
    });
  }

  void fbRegister() async {
    showProgress();
    var mobileNumber = userRegisterData[FirebaseDatabaseSchema.mobileNumberCol];
    checkUserIsRegisteredOrNot(mobileNumber).then((isRegister) async {
      if (isRegister) {
        Get.showErrorSnackbar('User is already exists');
        fbLogin(mobileNumber);
      } else {
        // insert
        final data = await Supabase.instance.client
            .from('users')
            .insert([userRegisterData]).select();
        if(data != null) {
          Get.showSuccessSnackbar('New user successfully created.');
          hideProgressBar();
        }
        CollectionReference users = FirebaseFirestore.instance
            .collection(FirebaseDatabaseSchema.usersTable);
        users.add(userRegisterData).then((value) {
          fbLogin(mobileNumber);
        }).catchError(
            (error) => Get.showSuccessSnackbar('Failed to add user: $error'));
      }
    });
    isLoginRequest = false;
  }

  Future<bool> checkUserIsRegisteredOrNot(String phoneNumber) async {
    showProgress();
    CollectionReference users = FirebaseFirestore.instance
        .collection(FirebaseDatabaseSchema.usersTable);
    return await users
        .where(FirebaseDatabaseSchema.mobileNumberCol, isEqualTo: phoneNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Login user
        return true;
      } else {
        // Create New user
        return false;
      }
    });
  }

  Future<void> signOutUser() async {
    FirebaseAuth.instance.signOut();
  }
}
