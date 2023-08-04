import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../model/project_create_model.dart';
import '../../../resource/constant.dart';
import '../../../resource/image.dart';
import '../../widget/all_widget.dart';

class ProjectRowItem extends StatelessWidget {
 final ProjectCreateModel projectCreateModel;
 ProjectRowItem(this.projectCreateModel);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(ex)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width/2.5,
                          child: textMore(
                              projectCreateModel.name,
                              Colors.black,
                              14,
                              FontWeight.w600,3),
                        ),

                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(5),
                              border: Border.all(
                                  color: textVioletColor),
                              color: Colors.white),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              text('Add', textVioletColor,
                                  10, FontWeight.w500),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.camera_alt,
                                color: textVioletColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
