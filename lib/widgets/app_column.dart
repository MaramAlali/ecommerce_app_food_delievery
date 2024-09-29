import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/small_text.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font20,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            SmallText(text: " التَعَلِيقَات",size: 18-5,),
            SizedBox(
              width: 20,
            ),
            SmallText(text: "1287",size: 18-5,),
            SizedBox(
              width: 20,
            ),
            SmallText(text: "4.5",size: 18-5,),
            SizedBox(
              width: 20,
            ),
            Wrap(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: Color(0xfff1d01a),
                  size: 15,
                );
              }),
            ),




          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
      ],
    );
  }
}
