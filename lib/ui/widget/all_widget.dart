
import 'package:colab_ezzyfy_solutions/resource/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


Widget imageWidget(String image) {
  return  Image.asset(image);
}



Widget text(String text,Color color,double fontsize,FontWeight fontWeight,){
  return Text(text,
    style: GoogleFonts.inter(
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
    style: GoogleFonts.inter(
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
        color: pinkButtonColor,
        boxShadow: [
          BoxShadow(
            color: buttonShadowColor.withOpacity(0.4), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 2, // Blur radius
            offset: Offset(0, 1), // Offset in the x and y directions
          ),
        ]
      ),
      child: Center(
          child: Text(text,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),)),
    ),
  );
}

Widget blueButton(String text, Function fun,double height, double width){
  return GestureDetector(
    onTap: () async {
      fun();
    },
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: pinkButtonColor
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
          color: Colors.grey.shade50
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
        border: Border.all(color: pinkButtonColor)
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
            colors: [pinkButtonColor, pinkButtonColor]),
      ),
      child: Center(
          child: Text(text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white,fontFamily: 'futur'))),
    ),
  );
}
