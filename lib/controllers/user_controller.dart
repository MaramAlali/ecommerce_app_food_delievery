import 'package:ecommerce_app_food_delievery/models/user_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../data/repository/userRepo.dart';
import '../models/response_model.dart';
import 'dart:io';
class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo
  });
  bool _isLoading=false;
  bool get isLoading =>_isLoading;

  //late UserModel _userModel;
   UserModel? _userModel;
   UserModel? get userModel=>_userModel;
   File? _image;
   File? get image=>_image;

  Future<ResponseModel>getUserInfo() async{

    Response response= await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if(response.statusCode==200){
      _userModel=UserModel.fromJson(response.body);
      _isLoading=true;
      responseModel = ResponseModel(true, "successfully");
    }
    else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }


  final picker=ImagePicker();

  Future  getGalleryImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
    else {
    }
  }
  }