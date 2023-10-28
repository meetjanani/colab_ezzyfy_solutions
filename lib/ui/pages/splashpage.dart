import 'package:colab_ezzyfy_solutions/controller/splash_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/image.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          logo_transparent, // logo_transparent
                        ),
                      ),
                    ),
                    //     finalRecord.quantity
                    text('Collab Ezzyfy Solutions', Colors.black, 20, FontWeight.w700),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
}
