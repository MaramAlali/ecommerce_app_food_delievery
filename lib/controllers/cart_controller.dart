import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/data/repository/cart_product_repo.dart';
import 'package:ecommerce_app_food_delievery/models/products_model.dart';
import 'package:get/get.dart';
import '../models/cart_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  List<CartModel> storageitems = [];

  /*
  onlt for storage items
  */

  void addItems(ProductModel product, int quantity) {
    var totalQuantity = 0;

    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if (totalQuantity < 0) {
        _items.remove(product.id!);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      }
      else {
        Get.snackbar("عدد العناصر", "يجب أن تضيف طلب واحد على الأقل",
            backgroundColor: AppColors.mainColor,

            colorText: Colors.white,

            icon: Icon((Icons.add_alert)));
      }
    }

    cartRepo.addToCartList(getItems);

    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id!)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }


  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageitems;
  }

  set setCart(List<CartModel> items) {
    storageitems = items;
    for (int i = 0; i < storageitems.length; i++) {
      _items.putIfAbsent(storageitems[i].product!.id!, () => storageitems[i]);
    }
  }

  void AddToHistory(){
    cartRepo.addToCartHistoryList();
    clear();

  }

  void clear(){
    _items={};
    update();
  }

  List<CartModel> getCartHistory(){
    return cartRepo.getCartHistory();
  }

  set setItems(Map<int,CartModel> setItems){
    _items={};
    _items=setItems;
  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory()
  {
    cartRepo.clearCartHistory();
    update();
  }

  void removeCartSharedPreferences()
  {
    cartRepo.removeCartSharedPreferences();
    update();
  }

}
