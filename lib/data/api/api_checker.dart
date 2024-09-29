
import 'package:ecommerce_app_food_delievery/base/show_custom_snackbar.dart';
import 'package:ecommerce_app_food_delievery/routes/route_helper.dart';
import 'package:get/get.dart';
class ApiChecker{
  static void checkApi(Response response){
    if(response.statusCode==401){
      Get.toNamed(RoutesHelper.getSignInPage());
    }else{
      showCustomSnackBar(response.statusCode.toString());
    }
  }
}