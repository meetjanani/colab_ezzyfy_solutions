import 'package:colab_ezzyfy_solutions/controller/add_user_controller.dart';
import 'package:get/get.dart';


class AddUserBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AddUserController());
  }

}