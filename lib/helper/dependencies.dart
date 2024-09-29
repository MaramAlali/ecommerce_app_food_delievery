import 'package:ecommerce_app_food_delievery/data/repository/order_repo.dart';
import 'package:ecommerce_app_food_delievery/controllers/popoular_product_controller.dart';
import 'package:ecommerce_app_food_delievery/data/repository/popoular_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/order_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../controllers/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/cart_product_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../data/repository/userRepo.dart';
import '../utils/app_constants.dart';
/////Future< Map<String,Map<String,String>>> init() async
Future< void> init() async{

    //shared_preferences
    final sharedPreferences=await SharedPreferences.getInstance();

    Get.lazyPut(()=>sharedPreferences);
    //api client
    Get.lazyPut(()=>ApiClient(appBaseUrl:AppConstants.BASE_URL,sharedPreferences: Get.find()));
    //repos
    Get.lazyPut(() => PopoularProductRepo(apiClient: Get.find()));
    Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

    Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
    Get.lazyPut(() => AuthRepo(apiClient: Get.find(),sharedPreferences:Get.find()));
    Get.lazyPut(() => UserRepo(apiClient: Get.find()));
    Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

    //controllers
    Get.lazyPut(() =>AuthController( authRepo: Get.find()));
    Get.lazyPut(() =>UserController( userRepo: Get.find()));

    Get.lazyPut(() => PopoularProductController( popoularProductRepo: Get.find()));
    Get.lazyPut(() => RecommendedProductController( recommendedProductRepo: Get.find()));
    Get.lazyPut(() =>CartController( cartRepo: Get.find()));
    Get.lazyPut(() =>OrderController( orderRepo: Get.find()));


    


}