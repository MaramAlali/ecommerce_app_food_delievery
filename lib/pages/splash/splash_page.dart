import 'dart:async';

import 'package:ecommerce_app_food_delievery/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popoular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  Future<void>_loadResources()async {
    await Get.find<PopoularProductController>().getPopoularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    await Get.find<CartController>();
  }

  @override
  void initState() {


    // TODO: implement initState
    Get.find<AuthController>().updateToken();
    controller= AnimationController(vsync: this,duration:const Duration(seconds: 5))..forward();
    animation=CurvedAnimation(parent: controller, curve:Curves.fastOutSlowIn );
    
    Timer(Duration(seconds: 7), () {
        Get.offNamed(RoutesHelper.getInitial());
    });
    _loadResources();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        ScaleTransition(
            scale: animation,
            child: Center(child: Image.asset("assets/image/icon2.png",width:Dimensions.splashImg,)),
        ),

        ScaleTransition(
          scale: animation,
          child: Center(child: Image.asset("assets/image/icon1.jpg",width:Dimensions.splashImg,))),
      ],)
    );
  }
}
