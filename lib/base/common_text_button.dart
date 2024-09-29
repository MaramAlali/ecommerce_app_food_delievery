import 'package:flutter/material.dart';
import '../utils/dimensions.dart';
import '../widgets/big_text.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  const CommonTextButton({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: Dimensions.height10-3,
          bottom: Dimensions.height10-3,
          left: Dimensions.width30,
          right: Dimensions.width30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          color:  Colors.black,
        ),
        child: Center(

          child: BigText(
            size:20,
            text: text,
            color: Colors.white,
          ),
        ));
  }
}
