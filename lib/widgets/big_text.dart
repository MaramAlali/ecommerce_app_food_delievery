import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/utils/dimensions.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  Color? color;
  String text;
  double size;
  TextOverflow overFlow;

  BigText(
      {Key? key,
      this.color=const Color(0xFF332d2b),
      required this.text,
      this.size = 0,

      this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(color: color,fontWeight: FontWeight.w400, fontSize: size==0?Dimensions.font20-4:size),

    );
  }
}
