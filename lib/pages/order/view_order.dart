import 'package:ecommerce_app_food_delievery/controllers/order_controller.dart';
import 'package:ecommerce_app_food_delievery/models/order_model.dart';
import 'package:ecommerce_app_food_delievery/utils/dimensions.dart';
import 'package:ecommerce_app_food_delievery/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../base/custom_loader.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;

  const ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (orderController.isLoading == false) {
          List<OrderModel> orderList=[];
          // if(orderController.currentOrderList.isEmpty){
          //   return Center(child: Text("You have not placed any order yet"));
          // }
          if (orderController.currentOrderList.isNotEmpty) {
            orderList = isCurrent
                ? orderController.currentOrderList.reversed.toList()
                : orderController.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10 / 2,
                  vertical: Dimensions.height10 / 2),
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "رَقَمُ الطَلَب:",
                                      style: robotoRegular.copyWith(
                                          fontSize: Dimensions.font12
                                      ),),
                                    SizedBox(
                                      width: Dimensions.width10 / 2,
                                    ),
                                    Text(
                                        "#${orderList[index].id.toString()}"),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.mainColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20 / 4)),
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.width10/2),

                                            child: Text(
                                              '${orderList[index].orderStatus}',
                                              style: robotoMedium.copyWith(
                                                  color: Theme.of(context).cardColor,fontSize: Dimensions.font12
                                              ),
                                            ),

                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(RoutesHelper.getAddressPage());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2,vertical: Dimensions.width10/2),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            Dimensions.radius20 / 4,),
                                          border: Border.all(width: 1,color: AppColors.mainColor),
                                        ),
                                        child: Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.height10 / 2),
                                            child: Row(
                                              children: [
                                                Text("تتبُع الطَلَب",style: robotoMedium.copyWith(
                                                    fontSize: Dimensions.font12,
                                                    color: AppColors.mainColor),
                                                ),
                                                Icon(Icons.history_edu_rounded,color: AppColors.mainColor,),
                                                SizedBox(width: Dimensions.width10/2,),

                                              ],
                                            )),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          );
        } else {
          return const CustomLoader();
        }
      }),
    );
  }
}
