import 'package:ecommerce_app_food_delievery/data/api/api_client.dart';
import 'package:ecommerce_app_food_delievery/models/place_order_model.dart';
import 'package:ecommerce_app_food_delievery/utils/app_constants.dart';
import 'package:get/get.dart';
class OrderRepo{
  final ApiClient apiClient;
  OrderRepo({
    required this.apiClient,
});

 Future<Response> placeOrder(PlaceOrderBody placeOrder)async{
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI,placeOrder.toJson());
  }

  Future<Response> getOrderList()async{
    return await apiClient.getData(AppConstants.ORDER_LIST_URI,);
  }
}