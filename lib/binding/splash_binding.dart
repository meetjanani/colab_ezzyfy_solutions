import 'package:colab_ezzyfy_solutions/controller/Auth/firebase_controller.dart';
import 'package:colab_ezzyfy_solutions/controller/splash_controller.dart';
import 'package:get/get.dart';

import '../resource/firebase_dayabase_schema.dart';




class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(Get.find()));
    Get.lazyPut(() => FirebaseController());
    Get.lazyPut(() => FirebaseDatabaseSchema());

  }
}
