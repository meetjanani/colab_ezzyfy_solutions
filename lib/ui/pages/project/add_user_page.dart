import 'package:colab_ezzyfy_solutions/controller/add_user_controller.dart';
import 'package:colab_ezzyfy_solutions/controller/project_details_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/constant.dart';
import 'package:colab_ezzyfy_solutions/resource/image.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/colab_catched_image_widget.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/colab_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/create_project_response_model.dart';
import '../../widget/common_toolbar.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  AddUserController controller = AddUserController.to;
  ProjectDetailsController projectDetailsController =
      ProjectDetailsController.to;

  @override
  void initState() {
    super.initState();
    controller.projectResponseModel =
        Get.arguments[0] as CreateProjectResponseModel;
    controller.isAdduserScreen = Get.arguments[1] as bool;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controller.fetAllSystemUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonToolbar(
                  toolbarTitle: controller.isAdduserScreen == true ? 'Add User to project' : 'Add User for site visit',
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: inputField2(
                                  hintText: 'Search User....',
                                  onChanged: (value) {
                                    controller.allSystemUsers
                                      ..clear()
                                      ..addAll(controller.searchSystemUser
                                          .where((element) => element.name
                                              .toLowerCase()
                                              .contains(value.toLowerCase())));
                                  }),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.search),
                          ],
                        ),
                      ),
                      ColabLoaderWidget(
                        loading: controller.loader.value,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.allSystemUsers.value.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var thisUser =
                                  controller.allSystemUsers.value[index];
                              var isUserAdded = controller
                                      .projectAssignedUserList.value
                                      .where((element) =>
                                          element.id == thisUser.id)
                                      .length >
                                  0;
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
                                          width: 50,
                                          boxFit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    text(
                                        controller
                                            .allSystemUsers.value[index].name,
                                        Colors.black,
                                        16,
                                        FontWeight.w500),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        if (isUserAdded) {
                                          showDialog(
                                            context: Get.context!,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                backgroundColor:
                                                    Colors.transparent,
                                                surfaceTintColor:
                                                    Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Image.asset(
                                                            alertErrorShowRemoveUserBody),
                                                        Positioned(
                                                          bottom: 0,
                                                          left: 0,
                                                          right: 0,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              InkWell(
                                                                child: Image.asset(
                                                                    alertErrorShowRemoveUserCancleButton),
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                              ),
                                                              InkWell(
                                                                child: Image.asset(
                                                                    alertErrorShowRemoveUserRemoveButton),
                                                                onTap: () {
                                                                  Get.back();
                                                                  controller.addOrRemoveUser(
                                                                      controller
                                                                          .allSystemUsers
                                                                          .value[
                                                                              index]
                                                                          .id);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          controller.addOrRemoveUser(
                                              controller.allSystemUsers
                                                  .value[index].id);
                                        }
                                      },
                                      child: Container(
                                        width: 67,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: isUserAdded
                                                    ? Colors.red
                                                    : textVioletColor),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              isUserAdded
                                                  ? SizedBox()
                                                  : Icon(
                                                      Icons
                                                          .add_circle_outline_sharp,
                                                      color: textVioletColor,
                                                      size: 20,
                                                    ),
                                              SizedBox(
                                                width: 1,
                                              ),
                                              text(
                                                  isUserAdded
                                                      ? 'Remove'
                                                      : 'Add',
                                                  isUserAdded
                                                      ? Colors.red
                                                      : textVioletColor,
                                                  14,
                                                  FontWeight.w500),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      // greenButton('Invite New user', () {}),
                    ],
                  ),
                ),
              ],
            )),
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
                      color: hintTextColor,
                    ),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: uploadImageDottedBorderColor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: uploadImageDottedBorderColor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: uploadImageDottedBorderColor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: uploadImageDottedBorderColor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: uploadImageDottedBorderColor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
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
