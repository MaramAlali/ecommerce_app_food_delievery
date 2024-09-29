import 'package:ecommerce_app_food_delievery/data/api/api_client.dart';
import 'package:ecommerce_app_food_delievery/models/sign_up_body_model.dart';
import 'package:ecommerce_app_food_delievery/utils/app_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  registeration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTERATION_URI, signUpBody.toJson());

  }

  bool UserLoggedIn(){
    return  sharedPreferences.containsKey(AppConstants.TOKEN);
  }
  Future<String> getUserToken()async{
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }
  login(String email,String password)async{
    return await apiClient.postData(AppConstants.LOGIN_URI,{"email":email,"password":password});
  }
  Future<bool>saveUserToken(String token) async{
    apiClient.token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveuserNumberAndPassword(String number,String password) async{
    try{
       await sharedPreferences.setString(AppConstants.PHONE, number);
       await sharedPreferences.setString(AppConstants.PASSWORD , password);
    }catch(e){
      throw e;
    }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;

  }

  Future<Response?> updateToken()async{
    String? deviceToken;
    if(GetPlatform.isMobile){
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
      NotificationSettings settings=await FirebaseMessaging.instance.requestPermission(
        alert: true, announcement: false, badge: true,
        carPlay: false,
        criticalAlert: false,
        sound: true,
        provisional: false,
      );
      if(settings.authorizationStatus==AuthorizationStatus.authorized){
        deviceToken=await _saveDeviceToken();
      }
      else{
        deviceToken=await _saveDeviceToken();
      }
      return apiClient.postData(AppConstants.TOKEN_URI, {"_method":"put","cm_firebase_token":deviceToken});

    }
    return  null;

    }
  Future<String?>_saveDeviceToken()async{
    String? deviceToken="@";
    if(!GetPlatform.isWeb){
      try{
        FirebaseMessaging.instance.requestPermission();
        deviceToken=await FirebaseMessaging.instance.getToken();
      }catch(e){

      }
    }
    if(deviceToken!=null){
    }
    return deviceToken;
  }
}