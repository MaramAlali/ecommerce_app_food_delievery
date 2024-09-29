import 'package:flutter/material.dart';
// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  Color? color;
  String text;
  double size;
  double height;
  TextOverflow overFlow;


  SmallText(
      {Key? key,
        this.color= const Color(0xFFccc7c5),
        required this.text,
        this.size = 16,
        this.height=1,
        this.overFlow = TextOverflow.ellipsis,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: TextStyle(color: color,fontWeight: FontWeight.w700, fontSize: size,height: height),

    );
  }
}