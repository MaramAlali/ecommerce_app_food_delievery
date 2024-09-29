import 'package:ecommerce_app_food_delievery/data/api/api_client.dart';
import 'package:ecommerce_app_food_delievery/utils/app_constants.dart';
import 'package:get/get.dart';

class UserRepo{
  ApiClient apiClient;
  UserRepo({required this.apiClient});

   Future<Response>getUserInfo()async {
    return await apiClient.getData(AppConstants.USER_INFO_URI);

  }

}