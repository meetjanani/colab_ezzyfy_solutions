import 'package:colab_ezzyfy_solutions/controller/create_project_controller.dart';
import 'package:get/get.dart';

class CreateProjectBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => CreateProjectController());
  }

}