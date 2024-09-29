import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/widgets/big_text.dart';
import 'package:get/get.dart';
void showCustomSnackBar(String message,{bool isError=true,String title="Error"}){
  Get.snackbar(title, message,
    titleText:BigText(text: title,color: Colors.white,) ,
    messageText: Text(message,style: const TextStyle(
      color: Colors.white,
    ),
    ),

    colorText: Color.fromARGB(255, 206, 143, 48),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.black,
  );
}