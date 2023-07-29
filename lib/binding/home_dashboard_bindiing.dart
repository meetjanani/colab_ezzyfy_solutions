import 'package:colab_ezzyfy_solutions/controller/Auth/login_controller.dart';
import 'package:colab_ezzyfy_solutions/controller/home_dashboard_controller.dart';
import 'package:get/get.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/supabase_setup_controller.dart';


class HomeDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeDashboardController());
    Get.lazyPut(() => FirebaseAuthController(Get.find()));
    Get.lazyPut(() => FirebaseStorageController());
    Get.lazyPut(() => SupabaseSetupController());
  }

}