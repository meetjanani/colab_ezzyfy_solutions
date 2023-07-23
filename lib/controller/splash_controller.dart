import 'package:colab_ezzyfy_solutions/controller/Auth/firebase_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/session_string.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
import 'package:colab_ezzyfy_solutions/shared/get_storage_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GetStorageRepository _getStorageRepository;
  SplashController(this._getStorageRepository);

  late AnimationController _controller;
  late Animation<Offset> offsetAnimation;

  @override
  void onInit() {
    super.onInit();
    _controller =
        AnimationController(duration: const Duration(seconds: 0), vsync: this);
    offsetAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 0.0)).animate(
            CurvedAnimation(parent: _controller, curve: Curves.decelerate));
  }

  @override
  void onReady() {
    super.onReady();
    _launchPage();
  }

  _launchPage() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (FirebaseAuth.instance.currentUser != null) {
      Get.toNamed(AppRoute.home);
    } else {
      Get.toNamed(AppRoute.login);
    }
  }
}
