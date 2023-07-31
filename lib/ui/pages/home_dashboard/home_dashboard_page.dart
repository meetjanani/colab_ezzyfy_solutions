import 'package:colab_ezzyfy_solutions/controller/home_dashboard_controller.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      onTap: (){
                        Get.toNamed(AppRoute.createProject);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: text(
                          'Logout', Colors.black, 20, FontWeight.w700),
                      onTap: (){
                        controller.firebaseAuthController.signOutUser(navigateUser: true);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
