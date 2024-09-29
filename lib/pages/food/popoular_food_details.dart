import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/controllers/cart_controller.dart';
import 'package:ecommerce_app_food_delievery/controllers/popoular_product_controller.dart';
import '../../utils/app_constants.dart';
import 'package:ecommerce_app_food_delievery/utils/dimensions.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail(
      {super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
    Get.find<PopoularProductController>().popoularProductList[pageId];
    Get.find<PopoularProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOAD_URL +
                            product.img!))),
              )),
          //icon widgets
          Positioned(
              top: Dimensions.height20+10,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(
                    onTap: () {
                      if (page == "cartpage") {
                        Get.toNamed(RoutesHelper.getCartPage());
                      }
                      else{
                        Get.toNamed(RoutesHelper.getInitial());
                      }
                    },

                    child: AppIcon(icon: Icons.arrow_back_ios_rounded,iconColor: const Color.fromARGB(255, 206, 143, 48),backgroundColor: Colors.black,iconSize: 30,size: 50,),),
                  GetBuilder<PopoularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RoutesHelper.getCartPage());
                      },
                      child: Stack(
                        children: [

                          AppIcon(icon: Icons.shopping_cart_outlined,iconColor: const Color.fromARGB(255, 206, 143, 48),backgroundColor: Colors.black,iconSize: 35,size: 50,),

                          controller.totalItems >= 1 ? Positioned(
                            right: 0,
                            top:2,
                            child: AppIcon(
                                icon: Icons.circle,
                                size: 23,
                                iconColor: Colors.transparent,
                                backgroundColor:const Color.fromARGB(255, 206, 143, 48)),
                          ): Container(),
                          Get.find<PopoularProductController>().totalItems >= 1
                              ? Positioned(
                            right: 5,
                            top: 4,
                            child: BigText(
                              text: Get.find<PopoularProductController>()
                                  .totalItems
                                  .toString(),
                              size: 15,
                              color: Colors.white,
                            ),
                          )
                              : Container()
                        ],
                      ),
                    );
                  })
                ],
              )),
          //introduction of food
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize ,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20),
                    ),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      BigText(text: product.name!,  size: 25),

                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      BigText(
                          text: "عَرَض التَفَاصِيل",
                          size: 18,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ExpandableTextWidget(
                              text:
                              "-- رَقَمُ الطَلَب: " +product.id!.toString()+ "\n"+ "- السِعَر: "+product.price!.toString()+
                              "\n"+"- العَنوَان: "+product.location!+ "\n"+"- التقييّم: "+product.stars!.toString()+
                                  "\n"+"- الوَصف: "+product.description!


                          ),
                        ),
                      ),
                    ],

              ))
          )],
      ),
      bottomNavigationBar: GetBuilder<PopoularProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(

                    top: Dimensions.height10-2,
                    bottom: Dimensions.height10-2,),

                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: AppIcon(
                              iconColor: const Color.fromARGB(255, 206, 143, 48),
                              backgroundColor: const   Color.fromARGB(
                                  255, 0, 0, 0),
                              icon: Icons.remove)),
                      SizedBox(
                        width: Dimensions.width10/2,
                      ),
                      BigText(text: popularProduct.cartItems.toString(),size: 20,),
                      SizedBox(
                        width: Dimensions.width10/2 ,
                      ),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: AppIcon(
                              iconSize: Dimensions.iconSize16,
                              iconColor: const Color.fromARGB(255, 206, 143, 48),
                              backgroundColor: const  Color.fromARGB(
                                  255, 0, 0, 0),
                              icon: Icons.add)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItems(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10,
                        bottom: Dimensions.height10,
                        left: Dimensions.width10,
                        right: Dimensions.width10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.black,
                    ),
                    child: BigText(text:" إِضَافَة إلى السَلَة ${product.price!*popularProduct.cartItems}  ",size: 20,
                      color: const Color.fromARGB(255, 206, 143, 48),

                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
