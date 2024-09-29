
import 'package:ecommerce_app_food_delievery/models/place_order_model.dart';
import 'package:get/get.dart';

import '../data/repository/order_repo.dart';
import '../models/order_model.dart';

class OrderController extends   GetxController implements GetxService{
  OrderRepo orderRepo;
  OrderController({
    required this.orderRepo,
  });
  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;

  int _paymentIndex=0;
  int get paymentIndex=>_paymentIndex;

  String _orderType="delivery";
  String get orderType=>_orderType;


  String _foodNote="";
  String get foodNote=>_foodNote;



  List<OrderModel> get currentOrderList=>_currentOrderList;
  List<OrderModel> get historyOrderList=>_historyOrderList;


  Future<void> placeOrder(PlaceOrderBody placeOrder,Function callback)async{
    _isLoading=true;
    Response response=await orderRepo.placeOrder(placeOrder);
    print("place order resposnse");
    print(response.body);

    if(response.statusCode==200){
      _isLoading=false;

      String string=response.body['message'];
      String orderID=response.body['order_id'].toString();
      callback(true,string,orderID);
    }else{
      callback(false,response.statusText,'-1');
    }
  }

  Future<void> getOrderList()async{
    _isLoading=true;
    Response response=await orderRepo.getOrderList();
    if(response.statusCode==200){
      print(response.statusCode);
      _historyOrderList=[];
      _currentOrderList=[];
      response.body.forEach((order){
        OrderModel orderModel=OrderModel.fromJson(order);
        if(orderModel.orderStatus=='pending'||
            orderModel.orderStatus=='accepted'||
            orderModel.orderStatus=='processing'||
            orderModel.orderStatus=='handover'||
            orderModel.orderStatus=='picked_up')
        {
          _currentOrderList.add(orderModel);
        }
        else{
          _historyOrderList.add(orderModel);
        }
      });
    }
    else{
      _historyOrderList=[];
      _currentOrderList=[];
    }
    _isLoading=false;
    print("the length of pending order is "+_currentOrderList.length.toString());
    print("the length of history order is "+_historyOrderList.length.toString());

    update();

  }

  void setPaymentIndex(int index){
    _paymentIndex=index;
    update();
  }
  void setDeliveryType(String type){
    _orderType=type;
    update();

  }

  void setFoodNote(String note){
    _foodNote=note;
  }
}