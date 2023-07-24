import 'package:colab_ezzyfy_solutions/firebase_operation/firebase_auth_controller.dart';
import 'package:colab_ezzyfy_solutions/controller/splash_controller.dart';
import 'package:get/get.dart';

import '../resource/firebase_database_schema.dart';




class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(Get.find()));
    Get.lazyPut(() => FirebaseAuthController());
    Get.lazyPut(() => FirebaseDatabaseSchema());

  }
}
