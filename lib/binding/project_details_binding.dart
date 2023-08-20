import 'package:colab_ezzyfy_solutions/binding/base_binding.dart';
import 'package:colab_ezzyfy_solutions/controller/home_dashboard_controller.dart';
import 'package:get/get.dart';

import '../controller/project_details_controller.dart';

class ProjectDetailsBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut(() => ProjectDetailsController(Get.find()));
    Get.lazyPut(() => HomeDashboardController());
  }
}
