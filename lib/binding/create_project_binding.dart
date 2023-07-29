import 'package:colab_ezzyfy_solutions/controller/create_project_controller.dart';
import 'package:get/get.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/supabase_setup_controller.dart';
import '../shared/get_storage_repository.dart';

class CreateProjectBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => CreateProjectController(Get.find()));
    Get.lazyPut(() => FirebaseStorageController());
    Get.lazyPut(() => FirebaseAuthController(Get.find()));
    Get.lazyPut(() => SupabaseSetupController());
    Get.lazyPut(() => GetStorageRepository(Get.find()));
  }

}