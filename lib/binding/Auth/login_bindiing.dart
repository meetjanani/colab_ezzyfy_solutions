import 'package:colab_ezzyfy_solutions/controller/Auth/login_controller.dart';
import 'package:get/get.dart';

import '../../controller/Auth/firebase_controller.dart';
import '../../controller/Auth/register_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => FirebaseController());
  }

}