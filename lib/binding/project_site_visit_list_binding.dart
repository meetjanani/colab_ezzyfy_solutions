import 'package:colab_ezzyfy_solutions/binding/base_binding.dart';
import 'package:get/get.dart';

import '../controller/project_site_visit_controller.dart';

class ProjectSiteVisitListBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut(() => ProjectSiteVisitController(Get.find()));
  }
}
