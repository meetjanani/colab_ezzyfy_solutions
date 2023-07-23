import 'package:colab_ezzyfy_solutions/controller/Auth/register_controller.dart';
import 'package:get/get.dart';

import '../firebase/firebase_controller.dart';


class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => FirebaseController());
  }

}