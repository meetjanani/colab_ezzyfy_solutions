import 'package:colab_ezzyfy_solutions/binding/base_binding.dart';
import 'package:colab_ezzyfy_solutions/controller/create_project_controller.dart';
import 'package:get/get.dart';
class CreateProjectBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut(() => CreateProjectController(Get.find()));
  }

}