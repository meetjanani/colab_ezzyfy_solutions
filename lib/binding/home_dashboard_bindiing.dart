import 'package:colab_ezzyfy_solutions/controller/Auth/login_controller.dart';
import 'package:colab_ezzyfy_solutions/controller/home_dashboard_controller.dart';
import 'package:get/get.dart';

import 'firebase/firebase_controller.dart';


class HomeDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeDashboardController());
    Get.lazyPut(() => FirebaseController());
  }

}