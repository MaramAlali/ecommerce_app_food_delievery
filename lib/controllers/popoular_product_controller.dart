import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/controllers/cart_controller.dart';
import 'package:ecommerce_app_food_delievery/data/repository/popoular_product_repo.dart';
import 'package:ecommerce_app_food_delievery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/cart_model.dart';
import '../models/products_model.dart';

class PopoularProductController extends GetxController {
  final PopoularProductRepo popoularProductRepo;

  PopoularProductController({required this.popoularProductRepo});

  List<dynamic> _popoularProductList = [];

  List<dynamic> get popoularProductList => _popoularProductList;
  late CartController _cart;

  int _quantity = 0;

  int get quantity => _quantity;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _cartItems=0;
  int get cartItems=>_cartItems+_quantity;

  Future<void> getPopoularProductList() async {
    //Response response=await popoularProductRepo.getPopoularProductList();
    var response = await http.get(
        Uri.parse("http://10.9.0.233:8000/api/v1/products/popular"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _popoularProductList = [];
      popoularProductList.addAll(Product
          .fromJson(data)
          .products);


      _isLoaded = true;
      update();
      return data;
    }
    else {
      throw Exception("Error");
    }
  }


  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    }

    else {
     
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_cartItems+quantity) < 0) {
      Get.snackbar("عدد العناصر", "لا يمكن أن يكون أقل من طلب واحد على الأقل ",backgroundColor: AppColors.mainColor,colorText: Colors.white,icon: Icon((Icons.add_alert)));
      if(_cartItems>0){
        _quantity=-_cartItems;
        return _quantity;
      }
      return 0;
    }
    else {
      return quantity;
    }
  }

  void initProduct(ProductModel product,CartController cart){
    _quantity=0;
    _cartItems=0;
    _cart=cart;
    var exist=false;
    exist=_cart.existInCart(product);
    if(exist){
     _cartItems=_cart.getQuantity(product);
    }
  }

  void addItems(ProductModel product ){

      _cart.addItems(product, _quantity);
      _quantity=0;
      _cartItems=_cart.getQuantity(product);

      _cart.items.forEach((key, value) {
      });

    update();


  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}