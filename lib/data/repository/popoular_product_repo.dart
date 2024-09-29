import 'package:ecommerce_app_food_delievery/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class PopoularProductRepo extends GetxService{
  final ApiClient apiClient;

  PopoularProductRepo({required this.apiClient});

  Future<Response> getPopoularProductList()async{

   return await apiClient.getData(AppConstants.POPOULAR_PRODUCT_URI);

  }
}