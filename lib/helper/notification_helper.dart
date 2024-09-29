import 'package:ecommerce_app_food_delievery/controllers/auth_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationHelper{


  static Future<void>initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin)async{
    var androidInitialize= const AndroidInitializationSettings('ic_launcher');
    //var iOSInitialize= const IOSInitializationSettings();
    var initializationSettings=InitializationSettings(android: androidInitialize);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification:(String? payload){
      try{

        if(payload!=null&& payload.isNotEmpty){
          //Get.toNamed(RoutesHelper.getNotificationRoute());
        }else{

        }
      // ignore: empty_catches
      }catch(e){

      }
    });
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      NotificationHelper.showNotification(message,flutterLocalNotificationsPlugin);
      if (Get.find<AuthController>().UserLoggedIn()) {

      }
    });


      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{

        try{
          if(message.notification?.titleLocKey!=null){

          }
        // ignore: empty_catches
        }catch(e){

        }
      });

  }
  static Future<void>showNotification(RemoteMessage msg,FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation=BigTextStyleInformation(
        msg.notification!.body.toString(),htmlFormatBigText: true,
        contentTitle: msg.notification!.title.toString(),htmlFormatContentTitle: true);

    AndroidNotificationDetails androidPlatformChannelSpecifics=AndroidNotificationDetails(
      'dbfood', 'dbfood', importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,playSound: true,
    );
    NotificationDetails platformChannelSpecifics=NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, msg.notification?.title,msg.notification?.body,platformChannelSpecifics,);

  }
}