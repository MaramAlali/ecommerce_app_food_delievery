import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  IconData icon;
  TextEditingController controller;
  String hintText;
  bool obscureText;
  bool maxLines;
  TextInputType keyboardType;
  AppTextField({Key? key,required this.icon,required this.controller,required this.hintText,  this.obscureText=false,this.keyboardType=TextInputType.name,this.maxLines=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left:Dimensions.height20,right: Dimensions.height20),

        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            boxShadow:[BoxShadow(
              blurRadius: 4,
              spreadRadius: 3,
              offset: Offset(1,1),
              color: Colors.grey.withOpacity(0.2),
            )]),
        child: TextField(
          maxLines: maxLines?3:1,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          obscuringCharacter: "*",
          decoration:  InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: AppColors.mainColor),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                borderSide: BorderSide(width: 1.0,color: Colors.white)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                borderSide: BorderSide(width: 1.0,color: Colors.white)
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
            ),
          ),
        )
    );
  }
}
