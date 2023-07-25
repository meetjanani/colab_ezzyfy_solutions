import 'package:colab_ezzyfy_solutions/controller/home_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../firebase_operation/supabase_setup_controller.dart';
import '../../widget/all_widget.dart';

class HomeDashboardPage extends GetView<HomeDashboardController> {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.width / 5,
                    ),
                    InkWell(
                      child: text(
                          'Create Project', Colors.black, 20, FontWeight.w700),
                      onTap: SupabaseSetupController().getData,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
