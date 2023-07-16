
import 'package:colab_ezzyfy_solutions/resource/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


Widget imageWidget(String image) {
  return  Image.asset(image);
}



Widget text(String text,Color color,double fontsize,FontWeight fontWeight){
  return Text(text,
    style: GoogleFonts.raleway(
      textStyle: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: fontWeight,
      ),
    ),
  );
}

Widget textMore(String text,Color color,double fontsize,FontWeight fontWeight,int maxLines){
  return Text(text,
    style: GoogleFonts.raleway(
      textStyle: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: fontWeight,

      ),
    ),
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
  );
}

Widget greenButton(String text, Function fun,){
  return GestureDetector(
    onTap: () async {
      fun();
    },
    child: Container(
      height: 55,
      width: Get.width/1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: greenButtonColor
      ),
      child: Center(
          child: Text(text,
              style: const TextStyle(fontSize: 22,color: Colors.white,fontFamily: 'futur',fontWeight: FontWeight.bold))),
    ),
  );
}

Widget whiteButton(String text, Function fun,double height, double width){
  return GestureDetector(
    onTap: () async {
      fun();
    },
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      child: Center(
          child: Text(text,
              style: const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.normal))
      ),
    ),
  );
}

Widget normalButton(String text, Function fun){
  return GestureDetector(
    onTap: () async {
      fun();
    },
    child: Container(
      height: 55,
      width: Get.width/1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
       color: Colors.white,
        border: Border.all(color: greenButtonColor)
      ),
      child: Center(
          child: Text(text,
              style: const TextStyle(fontSize: 18,color: Colors.black,fontFamily: 'futur',fontWeight: FontWeight.w700))),
    ),
  );
}

Widget kPrimaryButton(String text, Function fun) {
  return GestureDetector(
    onTap: () async {
      fun();
      // controller.updateLocation();
    },
    child: Container(
      height: 45,
      width: Get.width/1.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [greenButtonColor, greenButtonColor]),
      ),
      child: Center(
          child: Text(text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white,fontFamily: 'futur'))),
    ),
  );
}
