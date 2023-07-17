import 'package:colab_ezzyfy_solutions/resource/session_string.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
import 'package:colab_ezzyfy_solutions/shared/get_storage_repository.dart';
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
    //   bool _whereLogin =  _getStorageRepository.hasData(isLoginSession);
    await Future.delayed(const Duration(seconds: 2), () {});
    // //  Get.toNamed(AppRoute.onBoard);
    //   bool _isLogin =
    //   _getStorageRepository.hasData(isLoginSession);
    //   bool _isRegister =
    //   _getStorageRepository.hasData(isRegisterSession);
    //   bool _isNumberAdd =
    //   _getStorageRepository.hasData(isNumberAddSession);
    //   bool _isOnBoarding =
    //   _getStorageRepository.hasData(onBoarding);
    //   if (_isLogin == false && _isOnBoarding == true) {
    //     Get.offNamed(AppRoute.login);
    //   }else if (_isLogin == true && _isOnBoarding == true) {
    //     Get.offNamed(AppRoute.home);
    //   }  else if(_isRegister == true){
    //     Get.offNamed(AppRoute.login);
    //   }else{
    //     Get.offNamed(AppRoute.login);
    //   }
    // Get.offNamed(_whereLogin ? AppRoute.home : AppRoute.login);


    Get.toNamed(AppRoute.login);
    // var userData = _getStorageRepository.getUserData();
    // if(userData?.token?.isNotEmpty == true) {
    //   Get.toNamed(AppRoute.home);
    // } else {
    //   Get.offNamed(AppRoute.login);
    // }
  }
}
