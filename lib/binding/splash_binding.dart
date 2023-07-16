import 'package:colab_ezzyfy_solutions/controller/splash_controller.dart';
import 'package:get/get.dart';




class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(Get.find()));

  }
}
