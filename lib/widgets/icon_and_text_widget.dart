import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/utils/dimensions.dart';
import 'package:ecommerce_app_food_delievery/widgets/small_text.dart';

// ignore: must_be_immutable
class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  Color iconColor;

  IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,size: Dimensions.iconSize24,),
        SizedBox(width: 5,),
       SmallText(text: text,)

      ],
    );
  }
}
