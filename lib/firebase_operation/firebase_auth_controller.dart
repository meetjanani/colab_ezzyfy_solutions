import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/resource/database_schema.dart';
import 'package:colab_ezzyfy_solutions/shared/colab_shared_preference.dart';
import 'package:colab_ezzyfy_solutions/shared/get_storage_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/user_model_supabase.dart';
import '../resource/session_string.dart';
import '../route/route.dart';
import '../ui/pages/Auth/otp_bottomsheet.dart';

class FirebaseAuthController extends GetxController {
  final GetStorageRepository getStorageRepository;
  FirebaseAuthController(this.getStorageRepository);
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
      getStorageRepository.write('fbUser', currentUser);
    } else {
      firebasePhoneSignIn(phoneNumber);
    }
  }

  void firebasePhoneSignIn(String phoneNumber) async {
    try {
      showProgress();
     //  FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true,
    //  forceRecaptchaFlow: true);
      await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("verificationCompleted");
        },
        verificationFailed: (FirebaseAuthException e) {
          hideProgressBar();
          Get.showErrorSnackbar(e.message);
        },
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
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        )),
        context: Get.context!,
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
        getStorageRepository.write('UserCredential', authResult.user!.uid);
        getStorageRepository.write('isAuthSignIn', true); // for use to Auto loading
        await getUserFromPhoneNumber(phoneNumber);
      });
    } catch (e) {
      Get.back(); // dismiss progress bar
      if (e is FirebaseAuthException && e.code == 'invalid-verification-code') {
        print("codeSent exception");
        Get.showErrorSnackbar('${e.code} - ${e.message}');
      } else {
        Get.showErrorSnackbar('Firebase error occured.');
      }
    }
  }

  Future<void> getUserFromPhoneNumber(String phoneNumber) async {
    await Supabase.instance.client
        .from(DatabaseSchema.usersTable)
        .select('*')
        .eq(DatabaseSchema.userMobileNumber, phoneNumber)
        .limit(1)
        .then((data) {
      /*getStorageRepository.write(
          supabaseUserSessionStorage, UserModelSupabase.fromJson(data[0]).toJson());
      getStorageRepository.write(
          userIdSessionStorage, UserModelSupabase.fromJson(data[0]).id);*/
      setUserModel(UserModelSupabase.fromJson(data[0]));
      hideProgressBar();
      Get.offNamed(AppRoute.home);
      Get.showSuccessSnackbar('Login successfully.');
    });
  }

  void fbRegister() async {
    showProgress();
    var mobileNumber = userRegisterData[DatabaseSchema.userMobileNumber];
    checkUserIsRegisteredOrNot(mobileNumber).then((isRegister) async {
      if (isRegister) {
        Get.showErrorSnackbar('User is already exists');
        fbLogin(mobileNumber);
      } else {
        // insert into Supabase
        await Supabase.instance.client
            .from(DatabaseSchema.usersTable)
            .insert([userRegisterData]).select();
        Get.showSuccessSnackbar('New user successfully created.');
        hideProgressBar();
        fbLogin(mobileNumber);
        // insert into Firebase
        /*CollectionReference users =
            FirebaseFirestore.instance.collection(DatabaseSchema.usersTable);
        users.add(userRegisterData).then((value) {

        }).catchError(
            (error){
              Get.showSuccessSnackbar('Failed to add user: $error');
            });*/
      }
    });
    isLoginRequest = false;
  }

  Future<bool> checkUserIsRegisteredOrNot(String phoneNumber) async {
    try {
      showProgress();
      return await Supabase.instance.client
          .from(DatabaseSchema.usersTable)
          .select('*')
          .eq(DatabaseSchema.userMobileNumber, phoneNumber)
          .range(0, 1)
          .then((value) {
        hideProgressBar();
        return (value.length > 0);
      });
    } catch (e) {
      return await false;
    }
  }

  Future<void> signOutUser({navigateUser = false}) async {
    FirebaseAuth.instance.signOut();
    if (navigateUser) Get.offNamed(AppRoute.login);
  }

  Future<UserModelSupabase> getUserById(int userId) async {
    var response = await Supabase.instance.client
        .from(DatabaseSchema.usersTable)
        .select('*')
        .eq(DatabaseSchema.usersId, userId)
        .limit(1);
    setUserModel(UserModelSupabase.fromJson(response[0]));
    return UserModelSupabase.fromJson(response[0]);
  }
}
