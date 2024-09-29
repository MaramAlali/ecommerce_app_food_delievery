import 'package:ecommerce_app_food_delievery/pages/auth/sign_in_page.dart';
import 'package:ecommerce_app_food_delievery/pages/food/popoular_food_details.dart';
import 'package:ecommerce_app_food_delievery/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import '../pages/cart/cart_page.dart';
import '../pages/food/recommended_food_detail.dart';
import '../pages/home/home_page.dart';

class RoutesHelper {
  static const String splashPage= "/splash-page";
  static const String initialRoute = "/";
  static const String popoularFood = "/popoular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signInPage = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";
  static const String payment = "/payment";
  static const String orderSuccess = "/order-successful";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initialRoute';

  static String getPopoularFood(int pageId,String page) => '$popoularFood?pageId=$pageId&page=$page';

  static String getRecommendedFood(int pageId,String page) => '$recommendedFood?pageId=$pageId&page=$page';

  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signInPage';
  static String getAddressPage() => '$addAddress';
  static String getpickAddressPage() => '$pickAddressMap';
  static String getPaymentPage(String id,int userID) => '$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage(String orderID,String status) => '$orderSuccess?id=$orderID&status=$status';


  static List<GetPage> routes = [
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: initialRoute, page: () => HomePage()),
    GetPage(
        name: popoularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page= Get.parameters['page'];
          return PopularFoodDetail(pageId:int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page= Get.parameters['page'];
          return RecommendedFoodDetail(pageId:int.parse(pageId!),page:page!);},
        transition: Transition.fadeIn),

    GetPage(name: cartPage, page: (){
      return CartPage();
    },transition: Transition.fadeIn),
    GetPage(name: signInPage, page: (){
      return SignInPage();
    },transition: Transition.fadeIn),
  
   
  ];
}
