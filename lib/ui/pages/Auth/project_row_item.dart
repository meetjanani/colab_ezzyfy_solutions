import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../resource/constant.dart';
import '../../widget/all_widget.dart';

class ProjectRowItem extends StatelessWidget {
  const ProjectRowItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text('Sky Height', Colors.black, 14, FontWeight.w600),
        SizedBox(width: Get.width/4.5,),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: textVioletColor),
              color: Colors.white
          ),
          child: Row(
            children: [
              SizedBox(width: 5,),
              text('Add', textVioletColor, 10, FontWeight.w500),
              SizedBox(width: 5,),
              Icon(Icons.camera_alt, color: textVioletColor,size: 20,),
              SizedBox(width: 5,),
            ],
          ),
        )
      ],
    );
  }
}
