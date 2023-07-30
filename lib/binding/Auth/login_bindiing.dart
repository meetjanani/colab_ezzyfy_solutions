import 'package:colab_ezzyfy_solutions/binding/base_binding.dart';
import 'package:colab_ezzyfy_solutions/controller/Auth/login_controller.dart';
import 'package:get/get.dart';

import '../../controller/Auth/register_controller.dart';


class LoginBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
  }

}