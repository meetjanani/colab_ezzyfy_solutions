import 'package:colab_ezzyfy_solutions/controller/Auth/firebase_controller.dart';
import 'package:colab_ezzyfy_solutions/controller/Auth/register_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/constant.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpPage extends StatefulWidget {
  OtpPage({required this.verificationId, Key? key}) : super(key: key);
  final String verificationId;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  RegisterController controller = RegisterController.to;
  FirebaseController firebaseController = FirebaseController.to;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: Get.width,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.white,
            ),
            //height: 50,

            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SizedBox(height: 10,),

                  const SizedBox(height: 10),
                  text('Enter Verification Code', Colors.black, 22,
                      FontWeight.w800),
                  const SizedBox(height: 10),
                  text('Enter 4 digits code that you received on your email. ',
                      Colors.grey, 15, FontWeight.w700),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: OTPTextField(
                      length: 6,
                      controller: controller.otpController,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 50,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      otpFieldStyle: OtpFieldStyle(
                          borderColor: Colors.grey,
                          disabledBorderColor: Colors.grey,
                          enabledBorderColor: Colors.grey,
                          focusBorderColor: Colors.grey),
                      onCompleted: (pin) {
                        print("Completed: " + pin);
                        controller.pin.value = pin.toString();

                        // if(controller.type != '1'){
                        //   controller.verifyOTP(controller.data.id,pin);
                        // }else{
                        //   controller.vefifyForgotPassOtp(controller.userID, pin);
                        // }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  greenButton('Confirm', () {
                    // verify OTP function
                    firebaseController.verifyOtpForLoginUser(widget.verificationId,controller.pin.value);
                  }),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text('Don\'t receive OTP ? ', Colors.black, 15,
                          FontWeight.w700),
                      InkWell(
                          onTap: () {
                            Get.toNamed(AppRoute.login);
                          },
                          child: text(
                              'Resend', pinkButtonColor, 15, FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: Get.width / 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
