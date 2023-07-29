import 'package:colab_ezzyfy_solutions/controller/Auth/register_controller.dart';
import 'package:get/get.dart';

import '../../firebase_operation/firebase_auth_controller.dart';


class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => FirebaseAuthController(Get.find()));
  }

}