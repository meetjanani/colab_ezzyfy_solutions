import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource/image.dart';
import 'all_widget.dart';
import 'colab_catched_image_widget.dart';

class CommonToolbar extends StatefulWidget {
  final String? toolbarTitle;

  const CommonToolbar({
    super.key,
    this.toolbarTitle = 'Colab',
  });

  @override
  State<CommonToolbar> createState() => _CommonToolbarState();
}

class _CommonToolbarState extends State<CommonToolbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(bg), fit: BoxFit.fill),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 48,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  Get.back(result: true);
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Get.width / 12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 22,
                    ),
                  ),
                ),
              ),
              Expanded(child: Center(child: text(widget.toolbarTitle ?? '', Colors.white, 18, FontWeight.w500))),
              SizedBox(
                width: 56,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
