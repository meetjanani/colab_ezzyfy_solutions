import 'package:colab_ezzyfy_solutions/controller/Auth/login_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/constant.dart';
import 'package:colab_ezzyfy_solutions/resource/extensions.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
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
                height: Get.height/3.8,width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  color: Colors.blue
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.width/10,),
                    text('Colab', Colors.white, 35, FontWeight.w500),
                    SizedBox(height: 20,),
                    text('Welcome Back', Colors.white, 25, FontWeight.bold),
                    SizedBox(height: 20,),
                    text('Stay SIGN IN in with your account\nto make searching', Colors.white, 18, FontWeight.w500),
                    SizedBox(height: 20,),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    inputField(
                        hintText: 'Enter Mobile Number'
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                          () => inputField(
                          obscureText:  !controller.passwordVisibal.value,
                          controller: controller.password,
                          validation: (value) {
                            if (value?.isEmpty == true) {
                              return "Please enter Password";
                            }
                          },
                          inkWell: InkWell(
                            child: Icon(
                              controller.passwordVisibal == true
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onTap: () {
                              controller.passwordVisibal.value =
                              (!controller.passwordVisibal.value);
                            },
                          ),
                          hintText: 'Password'
                        //inkWell: Icon(Icons.remove_red_eye),

                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          // controller.clearFields();

                        },
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: text('Forget Password?', Colors.black, 15,
                                  FontWeight.w700),
                            ))),
                    SizedBox(
                      height: 30,
                    ),
                    greenButton('Sign In', (){

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
                               Get.toNamed(AppRoute.register);
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
