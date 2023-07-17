import 'package:colab_ezzyfy_solutions/controller/splash_controller.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SlideTransition(
          position: controller.offsetAnimation,
          child: Stack(


            children: [


              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: Get.width/5,),
                    text('Colab', Colors.black, 20, FontWeight.w700),
                    SizedBox(height: 20,),
                  ],
                ),
              )

            ],
          ),
        ),
      ));
}
