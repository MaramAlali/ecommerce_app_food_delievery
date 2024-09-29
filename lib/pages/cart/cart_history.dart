import 'dart:convert';
import 'package:ecommerce_app_food_delievery/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/base/no_data_page.dart';
import 'package:ecommerce_app_food_delievery/controllers/cart_controller.dart';
import 'package:ecommerce_app_food_delievery/models/cart_model.dart';
import 'package:ecommerce_app_food_delievery/routes/route_helper.dart';
import 'package:ecommerce_app_food_delievery/utils/app_constants.dart';
import 'package:ecommerce_app_food_delievery/utils/dimensions.dart';
import 'package:ecommerce_app_food_delievery/widgets/big_text.dart';
import 'package:ecommerce_app_food_delievery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/colors.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistory = Get.find<CartController>().getCartHistory().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistory.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistory[i].time)) {
        cartItemsPerOrder.update(getCartHistory[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistory[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }
    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderTimeToList();
    var listCounter = 0;

    Widget timeWidget(int index){
      var outPutDate=DateTime.now().toString();
      if(index<getCartHistory.length) {

        DateTime parseDate = DateFormat("yyyy-mm-dd HH:mm:ss").parse(
            getCartHistory[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outPutFormat = DateFormat("MM/dd/yyyy hh:mm a");
         outPutDate = outPutFormat.format(inputDate);
      }
      return BigText(text:outPutDate);
    }

    return Scaffold(
      appBar: const CustomAppBar(title: "مُراجَعَةُ الطَلَبَات",),
      body: Column(
        children: [
          GetBuilder<CartController>(builder: (cartController){
            return cartController.getCartHistory().length>0?Expanded(
              child: Container(

                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      top: Dimensions.height20,
                      right: Dimensions.width20,
                      ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for (int i = 0; i < cartItemsPerOrder.length; i++)
                          Container(
                            height: Dimensions.height30*4,
                            margin: EdgeInsets.only(bottom: Dimensions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                timeWidget(listCounter),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(itemsPerOrder[i],
                                                (index) {
                                              if (listCounter <
                                                  getCartHistory.length) {
                                                listCounter++;

                                              }
                                              return index <= 2
                                                  ? Container(
                                                height: Dimensions.height30*2,
                                                width: Dimensions.height30*2,
                                                margin: EdgeInsets.only(
                                                    right:
                                                    Dimensions.width10 / 2),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12.0),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistory[listCounter-1].img!)
                                                ),


                                              ))
                                                  : Container();
                                            })),
                                    Container(
                                      height:Dimensions.height30+35,
                                      child: Column(

                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,

                                        children: [
                                          BigText(

                                            text:"${itemsPerOrder[i]}orders",

                                            color: AppColors.titleColor,
                                          ),


                                          GestureDetector(
                                            onTap: (){
                                              var ordertime=cartOrderTimeToList();
                                              Map<int,CartModel> moreorders={};
                                              for(int z=0;z<getCartHistory.length;z++){
                                                if(getCartHistory[z].time==ordertime[i]){
                                                  moreorders.putIfAbsent(getCartHistory[z].id!, () {
                                                    return CartModel.fromJson(jsonDecode(jsonEncode(getCartHistory[z])));
                                                  });
                                                }
                                              }
                                              Get.find<CartController>().setItems=moreorders;
                                              Get.find<CartController>().addToCartList();
                                              Get.toNamed(RoutesHelper.getCartPage());

                                            },

                                            child: Container(

                                              padding: EdgeInsets.symmetric(

                                                  horizontal:
                                                  Dimensions.width15-5 ,
                                                  vertical:
                                                  Dimensions.height15-5 ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                    Dimensions.radius15 ),
                                                border: Border.all(
                                                    width: 0.1,
                                                    color: AppColors.mainColor),
                                              ),
                                              child: SmallText(
                                                text: "عَرَضُ المَزِيدِ",
                                                color:  Color.fromARGB(255, 206, 143, 48),

                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],

                            ),

                          )

                      ],
                    ),
                  )),
            ):Container(
                height: MediaQuery.of(context).size.height/1.5,
                child: NoDataPage(text: "لَمْ يَتَمْ شِرَاءِ أَيُ طَلَبٍ مُسْبَقَاً"));
          }),
        ],
      ),
    );
  }
}
