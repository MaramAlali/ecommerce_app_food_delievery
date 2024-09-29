import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/controllers/popoular_product_controller.dart';
import 'package:ecommerce_app_food_delievery/controllers/recommended_product_controller.dart';
import 'package:ecommerce_app_food_delievery/utils/dimensions.dart';
import 'package:ecommerce_app_food_delievery/widgets/app_icon.dart';
import 'package:ecommerce_app_food_delievery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app_food_delievery/routes/route_helper.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/app_constants.dart';


class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId,required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
    Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopoularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
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
                  child:  AppIcon(icon: Icons.clear_rounded,iconColor: const Color.fromARGB(255, 206, 143, 48),backgroundColor: Colors.black,iconSize: 40,size: 50),
                ),
                GetBuilder<PopoularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {

                      Get.toNamed(RoutesHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined,iconColor: const Color.fromARGB(255, 206, 143, 48),backgroundColor: Colors.black,iconSize: 40,size: 50,),
                        Get.find<PopoularProductController>().totalItems >= 1
                            ?  Positioned(
                          right: 0,
                          top: 0,
                          child: AppIcon(
                            icon: Icons.circle,
                            size: 25,
                            iconColor: Colors.transparent,
                            backgroundColor:const Color.fromARGB(255, 206, 143, 48), ),
                        )
                            : Container(),
                        Get.find<PopoularProductController>().totalItems >= 1 ? Positioned(
                          right: 2,
                          top: 3,
                          child: BigText(
                            text: Get.find<PopoularProductController>().totalItems.toString(),
                            size: 16,
                            color: Color.fromARGB(252, 243, 236, 236),
                          ),
                        )
                            : Container()
                      ],
                    ),
                  );
                })
              ],
            ),

            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 0),
                decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular((Dimensions.radius30*2)),
                      topRight: Radius.circular((Dimensions.radius30*2)),
                    )),

                child: Center(

                    child:Column(
                      children: [
                        SizedBox(
                          height: Dimensions.height45/10,
                        ),
                        BigText(size: Dimensions.font26-10, text: product.name!)],)

                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.black,
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),

        ],
      ),
      bottomNavigationBar:
      GetBuilder<PopoularProductController>(builder: (controller) {
        return Column(

          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Dimensions.height45,
            ),
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5,
                right: Dimensions.width20 * 2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          iconColor:const Color.fromARGB(255, 206, 143, 48) ,
                          backgroundColor: Colors.black,
                          icon: Icons.remove)),
                  BigText(
                    text:"ل. ت"+ "  ${product.price! } * ${controller.cartItems}",
                    color: const Color(0xFF332d2b),
                    size: Dimensions.font20,
                  ),
                  GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          iconColor: const Color.fromARGB(255, 206, 143, 48),
                          backgroundColor: Colors.black,
                          icon: Icons.add))
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(

                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                        ),),
                  GestureDetector(
                    onTap: () {
                      controller.addItems(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                          left: Dimensions.width20*3.1,
                          right: Dimensions.width20*3.1),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Dimensions.radius30),
                        color:Colors.black,
                      ),
                      child: BigText(
                          text: " إِضَافَة إلى السَلَة ِ:"" ${product.price! *controller.cartItems} ",
                          color:const Color.fromARGB(255, 206, 143, 48),size: 22,),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
