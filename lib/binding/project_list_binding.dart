import 'package:colab_ezzyfy_solutions/binding/base_binding.dart';
import 'package:colab_ezzyfy_solutions/controller/project_list_controller.dart';
import 'package:get/get.dart';
class ProjectListBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut(() => ProjectListController());
  }

}