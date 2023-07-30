import 'package:colab_ezzyfy_solutions/binding/base_binding.dart';
import 'package:colab_ezzyfy_solutions/controller/Auth/register_controller.dart';
import 'package:get/get.dart';

import '../../controller/Auth/login_controller.dart';


class RegisterBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
  }

}