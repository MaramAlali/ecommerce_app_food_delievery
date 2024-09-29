import 'package:ecommerce_app_food_delievery/helper/notification_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/routes/route_helper.dart';
import 'package:ecommerce_app_food_delievery/utils/colors.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'controllers/cart_controller.dart';
import 'controllers/popoular_product_controller.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart'as dep;

Future<void> _fireBaseMessagingBackGroundHandler(RemoteMessage message)async{
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

Future<void>  main() async{
  //setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();
 // Map<String,Map<String,String>>_languages=await dep.init();
 // Map<String,Map<String,String>>_languages=await dep.init();
  try{
    if(GetPlatform.isMobile){
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(_fireBaseMessagingBackGroundHandler);
    }

  }catch(e){
    if(kDebugMode){
      print(e.toString());
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
     return GetBuilder<PopoularProductController>(builder: (_){
        return GetBuilder<RecommendedProductController>(builder: (_){
          return GetBuilder<CartController>(builder: (_){
             return GetMaterialApp(
               localizationsDelegates: [
                 GlobalCupertinoLocalizations.delegate,
                 GlobalMaterialLocalizations.delegate,
                 GlobalWidgetsLocalizations.delegate,
               ],
               supportedLocales: [
                 Locale('ar', 'AE')
               ],
               locale: Locale("ar", "AE"),
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              initialRoute: RoutesHelper.getSplashPage(),
             getPages: RoutesHelper.routes,
             theme: ThemeData(primaryColor: AppColors.mainColor,fontFamily: 'Amiri'),

             // home:SignUpPage(),
            );
          });
        });
      });

  }


}

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// <uses-permission android:name="android.permisssion.INTERNET"></uses-permission>
// <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"></uses-permission>
// }