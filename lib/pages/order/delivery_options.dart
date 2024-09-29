import 'package:ecommerce_app_food_delievery/controllers/order_controller.dart';
import 'package:ecommerce_app_food_delievery/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryOptions extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;

  const DeliveryOptions(
      {Key? key,
      required this.value,
      required this.title,
      required this.amount,
      required this.isFree})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      return Row(
        children: [
          Radio(
            onChanged: (String? value) =>orderController.setDeliveryType(value!),
            groupValue: orderController.orderType,
            value: value,
            activeColor: Theme.of(context).primaryColor,
          ),
          SizedBox(width: Dimensions.width10/2,),
          Text(title,style: TextStyle
            (fontSize: Dimensions.font16+6),),
          SizedBox(width: Dimensions.width10/2,),
          Text(
            '(${(value=='take away'|| isFree)?'free':'\$${amount/10}'})',style: TextStyle
            (fontSize: Dimensions.font16+6),),

        ],
      );
    });
  }
}
