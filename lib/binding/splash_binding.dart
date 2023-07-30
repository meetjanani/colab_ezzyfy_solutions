import 'package:colab_ezzyfy_solutions/binding/base_binding.dart';
import 'package:colab_ezzyfy_solutions/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut(() => SplashController(Get.find()));

  }
}
