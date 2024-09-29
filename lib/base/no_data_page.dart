import 'package:ecommerce_app_food_delievery/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgpath;
  const NoDataPage({Key? key,required this.text,this.imgpath="assets/image/cart.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(


      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: Dimensions.height20*2.5 ,
          width: Dimensions.width20*10 ,),
        Image.asset(
          imgpath,
          height: MediaQuery.of(context).size.height*0.2,
          width: MediaQuery.of(context).size.height*0.2,
        ),
    Container(
    height: Dimensions.height20*2.5 ,
    width: Dimensions.width20*10 ,),
        Container(

          child: Center(
            child: BigText(
              text:  "لَمْ يَتَمْ شِرَاءِ أَيُ طَلَبٍ مُسْبَقَاً",
              color: Colors.black,
              size: 30,

            ),
          ),
        ),

      ],
    );
  }
}
