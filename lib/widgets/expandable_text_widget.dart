import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/utils/dimensions.dart';
import 'package:ecommerce_app_food_delievery/widgets/small_text.dart';

import '../utils/colors.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
   ExpandableTextWidget({Key? key,required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText=true;
  double textHeight=0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.text.length>textHeight){

      firstHalf=widget.text.substring(0,textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else {
    firstHalf=widget.text;
    secondHalf="";
    }


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(text: firstHalf,overFlow: TextOverflow.visible,):Column(
        children: [
          SmallText(color:AppColors.paraColor,size:Dimensions.font16,text: hiddenText?(firstHalf):(firstHalf+secondHalf),overFlow: TextOverflow.visible,),
          InkWell(onTap: (){
            setState(() {
              hiddenText=!hiddenText;
            });
          },child: Row(children: [
            hiddenText?SmallText(size:Dimensions.font16,text: "عَرَضُ المَزِيدِ",color: AppColors.mainColor,):SmallText(size:Dimensions.font16,text: "عَرَض أَقَل",color: AppColors.mainColor,),
            Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,)
          ],),)
        ],
      )
    );
  }
}
