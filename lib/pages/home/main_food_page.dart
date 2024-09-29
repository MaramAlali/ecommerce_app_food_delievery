import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/utils/dimensions.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/popoular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import 'food_page_body.dart';
class MainFoodpage extends StatefulWidget {
  const MainFoodpage({super.key});
  @override
  State<MainFoodpage> createState() => _MainFoodpageState();
}

class _MainFoodpageState extends State<MainFoodpage> {
  Future<void>_loadResource()
  async {
    await Get.find<PopoularProductController>().getPopoularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(


        onRefresh: _loadResource,


        child:  Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Container(
                width: Dimensions.height45,
                height: Dimensions.height45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  color:const Color.fromARGB(255, 206, 143, 48) ,
                ),
                child: Icon(Icons.search, color:Colors.black  ,size: Dimensions.iconSize24),
              ),
            ),

            GestureDetector(
              onTap: () {
                Get.toNamed(RoutesHelper.getCartPage());
              },
              child:
              Center(
                child: Container(
                  width: Dimensions.height45,
                  height: Dimensions.height45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color:const Color.fromARGB(255, 206, 143, 48) ,
                  ),
                  child: Icon(Icons.shopping_cart_outlined, color:Colors.black  ,size: Dimensions.iconSize24),
                ),
              ),


            )],

        )),
            const Expanded(child: SingleChildScrollView(
              child: FoodPageBody(),
            )),
          ],
        ),);
  }
}
