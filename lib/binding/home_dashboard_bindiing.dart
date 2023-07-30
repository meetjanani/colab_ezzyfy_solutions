import 'package:colab_ezzyfy_solutions/controller/home_dashboard_controller.dart';
import 'package:get/get.dart';
import 'base_binding.dart';


class HomeDashboardBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut(() => HomeDashboardController());
  }

}