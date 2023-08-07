import 'package:colab_ezzyfy_solutions/controller/add_user_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/constant.dart';
import 'package:colab_ezzyfy_solutions/resource/image.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/colab_catched_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/create_project_response_model.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  AddUserController controller = AddUserController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.projectResponseModel =
        Get.arguments as CreateProjectResponseModel;
    Future.delayed(const Duration(seconds: 2)).then((value) {
      controller.fetAllSystemUsers();
      // hideProgressBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Obx (
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      image:
                      DecorationImage(image: AssetImage(bg), fit: BoxFit.fill),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.blue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 44,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: Get.width / 12,
                              width: Get.width / 12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(Get.width / 12),
                              ),
                              child: Center(
                                child: Icon(Icons.arrow_back_ios_new),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 4,
                          ),
                          text('Add User', Colors.white, 18, FontWeight.w500),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: inputField2(hintText: 'Search User....'),
                            ),
                            Icon(Icons.search),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          itemCount: controller.allSystemUsers.value.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var thisUser = controller.allSystemUsers.value[index];
                            var isUserAdded = controller.projectAssignedUserList.value.where((element) => element.id == thisUser.id).length > 0;
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: ColabCatchedImageWidget(
                                          imageUrl: controller.allSystemUsers
                                              .value[index].profilePictureUrl,
                                          height: 50,
                                          width: 50),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  text(controller.allSystemUsers.value[index].name,
                                      Colors.black, 16, FontWeight.w500),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      controller.addOrRemoveUserFromProject(controller.allSystemUsers.value[index].id);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border:
                                          Border.all(color: textVioletColor),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.add_circle_outline_sharp,
                                              color: textVioletColor,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            text(isUserAdded ? 'Remove': 'Add', textVioletColor, 14,
                                                FontWeight.w500),
                                            SizedBox(
                                              width: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      greenButton('Invite New user', () {}),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}

inputField2({
  ValueChanged<String>? onChanged,
  TextEditingController? controller,
  double? height,
  double? width,
  int? maxLength,
  TextInputType? keyboardType,
  String? hintText,
  String? labelText,
  int maxLines = 1,
  bool obscureText = false,
  InkWell? inkWell,
  FormFieldValidator<String>? validation,
  bool? editable,
  bool readonly = false,
  Widget? prefix,
  Icon? icon,
}) =>
    Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 2,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
          child: Row(
            children: [
              SizedBox(child: icon),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: TextFormField(
                  readOnly: readonly,
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  // style: TextStyle(color: loginBox),
                  maxLines: maxLines,
                  onChanged: onChanged,
                  enabled: editable,
                  decoration: InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    filled: true,
                    // focusedBorder: OutlineInputBorder(
                    //   borderSide:  BorderSide(color: bluebuttonColor),
                    //   borderRadius: BorderRadius.circular(15.0),
                    // ),
                    // focusedErrorBorder: OutlineInputBorder(
                    //   borderSide:  BorderSide(color: bluebuttonColor),
                    //   borderRadius: BorderRadius.circular(15.0),
                    // ),
                    // disabledBorder: OutlineInputBorder(
                    //   borderSide:  BorderSide(color: bluebuttonColor),
                    //   borderRadius: BorderRadius.circular(15.0),
                    // ),
                    // enabledBorder:OutlineInputBorder(
                    //   borderSide:  BorderSide(color: bluebuttonColor),
                    //   borderRadius: BorderRadius.circular(15.0),
                    // ),
                    // errorBorder: OutlineInputBorder(
                    //   borderSide:  BorderSide(color: bluebuttonColor),
                    //   borderRadius: BorderRadius.circular(15.0),
                    // ),
                    fillColor: Colors.white,
                    hintText: hintText,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: inkWell,
                    ),
                    prefix: prefix,

                    // prefixIconColor: Colors.grey
                  ),
                  validator: validation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
