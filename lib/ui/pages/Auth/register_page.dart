import 'package:colab_ezzyfy_solutions/controller/Auth/register_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/constant.dart';
import 'package:colab_ezzyfy_solutions/resource/extensions.dart';
import 'package:colab_ezzyfy_solutions/resource/image.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resource/database_schema.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.countryCodeController.text = '+91';
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 246.dynamicHeight(),
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
                    Text(DatabaseSchema.projectCollabName,
                      style: GoogleFonts.ibmPlexMono(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 54,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    text('Welcome', Colors.white, 24, FontWeight.w800),
                    SizedBox(
                      height: 20,
                    ),
                    text(
                        'Glad to see yoy !', Colors.white, 14, FontWeight.w500),
                    text('Create your account and join us', Colors.white, 18,
                        FontWeight.w500),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      inputField(
                          hintText: 'Enter Name',
                          controller: controller.nameController,
                          keyboardType: TextInputType.name,
                          validation: (value) {
                            return value?.nameValidation();
                          }),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:Get.width * 0.25,
                            child: Flexible(child:   inputField(
                              editable: false,
                                hintText: '+91',
                                labelText: '+91',
                                controller: controller.mobileNumberController,
                                keyboardType: TextInputType.number,
                                validation: (value) {
                                  return value?.validateMobile();
                                }), ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(child:   inputField(
                              hintText: 'Enter Mobile Number',
                              controller: controller.mobileNumberController,
                              keyboardType: TextInputType.number,
                              validation: (value) {
                                return value?.validateMobile();
                              }), ),


                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      inputField(
                          hintText: 'Enter Email Address',
                          controller: controller.emailAddressController,
                          keyboardType: TextInputType.emailAddress,
                          validation: (value) {
                            return value?.validateEmail();
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    activeColor: darkVioletColor,
                                    value: controller.isSelect1.value,
                                    focusColor: Colors.white,
                                    checkColor: Colors.white,
                                    onChanged: (value) {
                                      controller.isSelect1.value = value!;
                                    },
                                  ),
                                  SizedBox(
                                    width: 0,
                                  ),
                                  text('I have read and agree to the', Colors.grey, 14, FontWeight.w400),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Get.to(LinkWebView(),arguments: "https://suriwallet.com/terms-and-conditions/");
                                    },
                                    child: Text(
                                      ' Terms & Condition ',
                                      style: GoogleFonts.nunitoSans(
                                          textStyle: TextStyle(
                                              decoration: TextDecoration.underline,
                                              color: darkVioletColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800)
                                      ),
                                    ),
                                  ),
                                  text('and', Colors.grey, 14, FontWeight.w400),
                                  InkWell(
                                    onTap: () {
                                      //Get.to(LinkWebView(),arguments: "https://suriwallet.com/privacy/");
                                    },
                                    child: Text(
                                      ' Privacy Policy',
                                      style: GoogleFonts.nunitoSans(
                                          textStyle: TextStyle(
                                              decoration: TextDecoration.underline,
                                              color: darkVioletColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      greenButton('Sign Up', () {
                        controller.registerUser();
                        /**/
                      }),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text('Already Have an Account? ', Colors.black, 14,
                              FontWeight.w400),
                          InkWell(
                              onTap: () {
                                Get.offNamed(AppRoute.login);
                              },
                              child: text('Sign In', bluePrimaryButtonColor, 15,
                                  FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
