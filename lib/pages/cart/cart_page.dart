import 'package:ecommerce_app_food_delievery/base/show_custom_snackbar.dart';
import 'package:ecommerce_app_food_delievery/controllers/order_controller.dart';
import 'package:ecommerce_app_food_delievery/controllers/user_controller.dart';
import 'package:ecommerce_app_food_delievery/pages/order/delivery_options.dart';
import 'package:ecommerce_app_food_delievery/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/controllers/auth_controller.dart';
import 'package:ecommerce_app_food_delievery/controllers/cart_controller.dart';
import 'package:ecommerce_app_food_delievery/controllers/recommended_product_controller.dart';
import 'package:ecommerce_app_food_delievery/utils/colors.dart';
import 'package:get/get.dart';

import '../../base/common_text_button.dart';
import '../../base/no_data_page.dart';
import '../../controllers/popoular_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../order/payment_option_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _noteController=TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height30+2,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RoutesHelper.initialRoute);
                    },
                    child: AppIcon(
                      icon: Icons.home_rounded,
                      iconSize: 30,
                      size: 50,
                      iconColor:Color.fromARGB(255, 206, 143, 48),
                      backgroundColor: Colors.black,

                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width20 ,
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Color.fromARGB(255, 206, 143, 48),
                    backgroundColor: Colors.black,
                    iconSize: 30,
                    size: 50,
                  ),

                ],

              )),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                        builder: (cartController) {
                          var _cartList = cartController.getItems;
                          return ListView.builder(
                              itemCount: _cartList.length,
                              itemBuilder: (_, index) {
                                return Container(
                                  margin:
                                  EdgeInsets.only(top: Dimensions.height15),
                                  height: 100,
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var popoularIndex = Get.find<
                                              PopoularProductController>()
                                              .popoularProductList
                                              .indexOf(
                                              _cartList[index].product);
                                          if (popoularIndex >= 0) {
                                            Get.toNamed(
                                                RoutesHelper.getPopoularFood(
                                                    popoularIndex, "cartpage"));
                                          } else {
                                            var recommendedIndex = Get.find<
                                                RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(
                                                _cartList[index].product);
                                            if (recommendedIndex < 0) {
                                              Get.snackbar(
                                                "سَجِلُ الطَلَبَات",
                                                "مُرَاجَعَةُ الطَلَبِ غَيرُ مُتَوَفِرَةُ فِي سَجِلِ الطَلَبَات",
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white,
                                                icon: Icon(Icons.add_alert),
                                              );
                                            } else {
                                              Get.toNamed(RoutesHelper
                                                  .getRecommendedFood(
                                                  recommendedIndex,
                                                  "cartpage"));
                                            }
                                          }
                                        },


                                        child: Container(
                                          width: Dimensions.height20 * 5,
                                          height: Dimensions.height20 * 5,
                                          margin: EdgeInsets.only(
                                              top: Dimensions.height10
                                          ),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(AppConstants
                                                    .BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    cartController
                                                        .getItems[index].img!),
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                Dimensions.radius20,
                                              ),
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      Expanded(
                                          child: Container(
                                            height: Dimensions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                  text: cartController
                                                      .getItems[index].name!,
                                                  color: Colors.black54,
                                                ),

                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text:
                                                      "\ ${cartController.getItems[index].price.toString()}ل.ت",
                                                      color: Colors.black,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: Dimensions.height10-5,
                                                          bottom:
                                                          Dimensions.height10-5,
                                                          left: Dimensions.width10,
                                                          right:
                                                          Dimensions.width10),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius20),
                                                          color: Colors.white),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartController
                                                                  .addItems(
                                                                  _cartList[
                                                                  index]
                                                                      .product!,
                                                                  -1);
                                                            },
                                                            child: Icon(
                                                              Icons.remove,
                                                              color: AppColors
                                                                  .signColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                            Dimensions.width10 /
                                                                2,
                                                          ),
                                                          BigText(
                                                              text: _cartList[index]
                                                                  .quantity
                                                                  .toString()),
                                                          //popoularProduct.cartItems.toString()),
                                                          SizedBox(
                                                            width:
                                                            Dimensions.width10 /
                                                                2,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartController
                                                                  .addItems(
                                                                  _cartList[
                                                                  index]
                                                                      .product!,
                                                                  1);
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                              color: AppColors
                                                                  .signColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                );
                              });
                        }),
                  ),
                ))
                : NoDataPage(
              text: "سَلَتُكَ فَارِغَة ",
              imgpath: "assets/image/cart.png",
            );
          })
        ],
      ),
      bottomNavigationBar:
      GetBuilder<OrderController>(
          builder: (orderController) {
            _noteController.text=orderController.foodNote;
            return GetBuilder<CartController>(builder: (cartController) {
              return InkWell(
                onTap: () {},
                child: Container(
                    height: Dimensions.bottomHeightBar + 30,
                    width: double.maxFinite,
                    padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height15,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(

                        topRight: Radius.circular(Dimensions.radius20 * 2),
                        topLeft: Radius.circular(Dimensions.radius20 * 2),
                        bottomRight: Radius.circular(Dimensions.radius20 * 2),
                        bottomLeft: Radius.circular(Dimensions.radius20 * 2),
                      ),
                    ),
                    child: cartController.getItems.length > 0
                        ? Column(
                      children: [
                        InkWell(
                            onTap: () => showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (_) {
                                  return Column(
                                    children: [
                                      Expanded(
                                          child: SingleChildScrollView(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          Dimensions.radius15),
                                                      topRight: Radius.circular(
                                                          Dimensions.radius15))),
                                              child: Column(

                                                children: [
                                                  Container(
                                                    height: 450,
                                                    padding:EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        PaymentOptionButton(
                                                          title: "الدَفَعُ عِندَ الاِستِلاَم",

                                                          subTitle:
                                                          "يُمكِنُكَ الدَفَعُ عِندَ اِستِلاَمِ الطَلَب",
                                                          icon: Icons.money,
                                                          index: 0,

                                                        ),
                                                        SizedBox(
                                                          height:
                                                          Dimensions.height10 /
                                                              2,
                                                        ),
                                                        PaymentOptionButton(
                                                          title: "الدَفَعُ إلِكَترُونِيَاً",

                                                          subTitle:

                                                          "يُمكِنُكَ الدَفَعُ إِلكَترُونِيَاً عَنْ طَرِيقِ البَاي بَال",
                                                          icon: Icons.paypal_outlined,
                                                          index: 1,
                                                        ),
                                                        SizedBox(
                                                          height:
                                                          Dimensions.height20,

                                                        ),
                                                        Text( "خِيَارَاتُ الدَفَع",style: TextStyle(fontSize: Dimensions.font20,fontWeight: FontWeight.bold),),
                                                        const DeliveryOptions(value: "delivery", title:  "تَوصِيل إلى المَنزِل",

                                                            amount:0.3, isFree: false),
                                                        SizedBox(
                                                          height:
                                                          Dimensions.height20,
                                                        ),
                                                        const DeliveryOptions(value: "take away", title: "تَوصِيَة", amount:10.0, isFree: true),

                                                        SizedBox(
                                                          height:
                                                          Dimensions.height10/2,

                                                        ),
                                                        Text( "مُلاَحَظَات إِضَافِيَة",style: TextStyle(fontSize: Dimensions.font20,fontWeight: FontWeight.bold),),
                                                        SizedBox(
                                                          height:
                                                          Dimensions.height10/2,
                                                        ),
                                                        AppTextField(icon: Icons.notes, controller: _noteController, hintText: "أَضِفْ مٌلاَحَظَاتِكَ حَولَ الطَلَب",maxLines: false,),
                                                      ],
                                                    ),

                                                  ),

                                                ],

                                              ),
                                            ),
                                          )),
                                    ],
                                  );
                                }).whenComplete(() => orderController.setFoodNote(_noteController.text.trim())),
                            child: const SizedBox(
                            width: 160,
                              child: CommonTextButton(

                                text: "خِيَارَات الدَفَع",
                              ),
                            )),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: Dimensions.height10-3,
                                  bottom: Dimensions.height10-3,
                                  left: Dimensions.width20-6,
                                  right: Dimensions.width20-6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.black),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  BigText(
                                      text:
                                      "\ ${cartController.totalAmount.toString()}ل.ت",color: Colors.white,),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (Get.find<AuthController>().UserLoggedIn()) {
                                  Get.find<AuthController>().updateToken();
                                
                            
                                   
                                    //print("my type is "+placeOrder.toJson()['order_note']);
                                  
                                  }
                                  cartController.AddToHistory();
                               },
                              child: const CommonTextButton(
                                text: "تَأكِيد الطَلَب",
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                        : Container()),
              );
            });
          }
      ),
    );
  }

  void _callback(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreferences();

      Get.find<CartController>().AddToHistory();
      if(Get.find<OrderController>().paymentIndex==0){
        Get.offNamed(RoutesHelper.getOrderSuccessPage(orderID, "success"));
      }else{
        Get.offNamed(RoutesHelper.getPaymentPage(
            orderID, Get.find<UserController>().userModel!.id!));
      }


    } else {
      showCustomSnackBar(message);
    }
  }
}
