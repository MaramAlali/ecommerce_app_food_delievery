import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../data/repository/recommended_product_repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList =>_recommendedProductList;

  bool _isLoaded=false;
  bool get isLoaded=>_isLoaded;

  Future<dynamic> getRecommendedProductList()async{
    // Response response=await recommendedProductRepo.getRecommendedProductList();
    var response=await http.get(Uri.parse("http://10.9.0.233:8000/api/v1/products/recommended"));

    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      //
      //print("Got products");
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(data).products);
      _isLoaded=true;
      update();
      return data;

    }
    else{
      throw Exception("Error");
    }

  }
}