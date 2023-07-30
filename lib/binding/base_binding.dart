import 'package:colab_ezzyfy_solutions/firebase_operation/firebase_auth_controller.dart';
import 'package:get/get.dart';

import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/supabase_setup_controller.dart';
import '../resource/database_schema.dart';
import '../shared/get_storage_repository.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseAuthController(Get.find()));
    Get.lazyPut(() => FirebaseStorageController());
    Get.lazyPut(() => SupabaseSetupController());
    Get.lazyPut(() => DatabaseSchema());
    Get.lazyPut(() => GetStorageRepository(Get.find()));
  }
}
