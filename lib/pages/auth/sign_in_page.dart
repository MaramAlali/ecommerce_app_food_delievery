import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/controllers/auth_controller.dart';
import 'package:ecommerce_app_food_delievery/pages/auth/sign_up_page.dart';
import 'package:ecommerce_app_food_delievery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordControlller = TextEditingController();

    void _login(AuthController authController){

      String email=emailController.text.trim();
      String password=passwordControlller.text.trim();



      if(email.isEmpty){
        showCustomSnackBar("ادخل البريد الإلكتروني",title: "البريد الإلكتروني");

      }

      else if(password.isEmpty){
        showCustomSnackBar("ادخل كلمة المرور",title: "كلمة المرور");
      }
      else if(password.length<6){
        showCustomSnackBar("يجب ألا تقل كلمة المرور عن ستة محارف",title: "كلمة المرور");

      }
      else{
        authController.login(  email,password).then((status){
          if(status.isSuccess){

            Get.toNamed(RoutesHelper.getInitial());
            Get.snackbar(
                "تسجيل الدخول","تم تسجيل الدخول بنجاح",
                backgroundColor: AppColors.mainColor,
                icon: Icon(Icons.add_alert));
          }else{
            showCustomSnackBar(status.message);
          }
        });

      }

    }
    return GetBuilder<AuthController>(
      builder: (_authController) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: !_authController.isLoading?SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.height30,
                ),
                //app logo
                Container(
                  height: Dimensions.screenHeight * 0.25,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      backgroundImage: AssetImage("assets/image/im.png"),
                    ),
                  ),
                ),
                //Hello text
                Padding(
                  padding:  EdgeInsets.only(right: Dimensions.width20),
                  child: Column(
                    children: [
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "أَهلاً بِكَ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: Dimensions.font26-10,fontWeight: FontWeight.bold,fontFamily: 'Amiri')),
                          ),
                        ],
                      ),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "تَسجِيلُ الدَخُولِ إلى حِسَابِكَ",
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: Dimensions.font20,fontFamily: 'Amiri')),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height30,),


                //Email field
                AppTextField(
                  icon: Icons.email,
                  controller: emailController,
                  hintText: "البَرِيدُ الإلِكَتَرُونِي",
                  keyboardType: TextInputType.emailAddress,

                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                //Password field
                AppTextField(
                  icon: Icons.password,
                  controller: passwordControlller,
                  hintText: "كَلِمَةُ المَرَورِ",
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),

                // sign up button
                SizedBox(
                  height: Dimensions.height20 * 2,
                ),
                GestureDetector(
                  onTap: (){
                    _login(_authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth / 3,
                    height: Dimensions.screenHeight / 15,

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color:Colors.black),
                    child: Center(
                        child: BigText(
                          text: " تَسجِيلُ الدَخُولِ",
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: Dimensions.font16,
                        )),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height45,
                ),
                //new account create link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "هل تَملِكُ حِسَاب؟",
                          style: TextStyle(
                              color: Colors.grey[500], fontSize: Dimensions.font16,fontFamily: 'Amiri')),
                    ),
                    SizedBox(width: Dimensions.width10/2,),
                    RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () => Get.to((SignUpPage())),
                          text: "إِنشَاء حِسَاب",
                          style: TextStyle(
                              color: Colors.black, fontSize: Dimensions.font16,fontWeight: FontWeight.bold,fontFamily: 'Amiri'),),
                    ),
                  ],
                ),

                //Wrap widget

              ],
            ),
          ):CustomLoader(),
        );
      }
    );
  }
}
