import 'package:colab_ezzyfy_solutions/controller/Auth/login_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/constant.dart';
import 'package:colab_ezzyfy_solutions/resource/extensions.dart';
import 'package:colab_ezzyfy_solutions/resource/image.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/Auth/otp_bottomsheet.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height / 3.8,
                width: Get.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(bg), fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.blue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.width / 10,
                    ),
                    text('Colab', Colors.white, 35, FontWeight.w500),
                    SizedBox(
                      height: 20,
                    ),
                    text('Welcome Back', Colors.white, 25, FontWeight.bold),
                    SizedBox(
                      height: 20,
                    ),
                    text('Stay SIGN IN in with your account\nto make searching',
                        Colors.white, 18, FontWeight.w500),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: controller.formKey,
                      child: inputField(
                        hintText: 'Enter Mobile Number',
                        controller: controller.mobileNumber,
                        keyboardType: TextInputType.number,
                        validation: (value) {
                          return value?.validateMobile();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    greenButton('Sign In', () {
                      controller.signIn();
                    }),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        text('New Member? ', Colors.black, 14, FontWeight.w400),
                        InkWell(
                            onTap: () {
                              Get.offNamed(AppRoute.register);
                            },
                            child: text('Register Now', pinkButtonColor, 15,
                                FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
