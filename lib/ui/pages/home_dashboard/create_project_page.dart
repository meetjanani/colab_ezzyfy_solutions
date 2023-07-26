import 'package:colab_ezzyfy_solutions/controller/create_project_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/extensions.dart';
import 'package:colab_ezzyfy_solutions/resource/image.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProjectPage extends GetView<CreateProjectController> {
  const CreateProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height / 6,
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
                      height: Get.width / 12,
                    ),
                    text('Colab', Colors.white, 25, FontWeight.w500),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20,),
                        CircleAvatar(),
                        SizedBox(width: 10,),
                        text('Hello,', Colors.white, 14, FontWeight.normal),
                        SizedBox(width: 5,),
                        text('Ronaldo', Colors.white, 14, FontWeight.bold),
                      ],
                    )

                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,20),
                child: text('Create Project', Colors.grey.shade900, 20, FontWeight.normal),
              ),
              SizedBox(height: 10,),
              Padding(padding: const EdgeInsets.fromLTRB(20,0,20,20),
              child:  inputField(
                  hintText: 'Enter Project name'
              ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: DottedBorder(
                  color: Colors.grey.shade700,
                  borderType: BorderType.RRect,
                  dashPattern: [6,5],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Image.asset(upload),
                        SizedBox(height: 50,),
                        text('Upload Media', Colors.blue, 14, FontWeight.normal)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(padding: const EdgeInsets.fromLTRB(20,0,20,20),
                child:  inputField(
                    hintText: 'Enter mobile number'
                ),
              ),

              SizedBox(height: 10,),
              Padding(padding: const EdgeInsets.fromLTRB(20,0,20,20),
                child:  inputField(
                    hintText: 'Enter address'
                ),
              ),

              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: greenButton('Create Project', (){}),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
