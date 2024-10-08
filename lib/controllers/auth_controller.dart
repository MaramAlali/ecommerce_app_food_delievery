import 'package:ecommerce_app_food_delievery/data/repository/auth_repo.dart';
import 'package:ecommerce_app_food_delievery/models/response_model.dart';
import 'package:ecommerce_app_food_delievery/models/sign_up_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
final AuthRepo authRepo;
AuthController({
  required this.authRepo
});
bool _isLoading=false;
bool get isLoading =>_isLoading;

Future<ResponseModel>registeration(SignUpBody signUpBody) async{
  _isLoading=true;
  update();
 Response response= await authRepo.registeration(signUpBody);
 late ResponseModel responseModel;
 if(response.statusCode==200){
  authRepo.saveUserToken(response.body['token']);
  responseModel = ResponseModel(true, response.body['token']);
 }
 else{
   responseModel = ResponseModel(false, response.statusText!);
 }
 _isLoading=false;
 update();
 return responseModel;
}
Future<ResponseModel>login(String email,String password) async{
  _isLoading=true;
  update();
  Response response= await authRepo.login(email,password);
  late ResponseModel responseModel;

  if(response.statusCode==200){

    authRepo.saveUserToken(response.body['token']);
    responseModel = ResponseModel(true, response.body['token']);
  }
  else{
    responseModel = ResponseModel(false, response.statusText!);
  }
  _isLoading=false;
  update();
  return responseModel;
}

bool UserLoggedIn(){
  return  authRepo.UserLoggedIn();
}

void saveuserNumberAndPassword(String number,String password) {
  authRepo.saveuserNumberAndPassword(number, password);

}

bool clearSharedData(){
  authRepo.clearSharedData();
  return true;
}

Future<void> updateToken()async{
  await authRepo.updateToken();


}


}