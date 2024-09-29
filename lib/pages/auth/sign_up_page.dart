import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/base/custom_loader.dart';
import 'package:ecommerce_app_food_delievery/base/show_custom_snackbar.dart';
import 'package:ecommerce_app_food_delievery/controllers/auth_controller.dart';
import 'package:ecommerce_app_food_delievery/models/sign_up_body_model.dart';
import 'package:ecommerce_app_food_delievery/pages/auth/sign_in_page.dart';
import 'package:ecommerce_app_food_delievery/routes/route_helper.dart';
import 'package:ecommerce_app_food_delievery/utils/colors.dart';
import 'package:ecommerce_app_food_delievery/utils/dimensions.dart';
import 'package:ecommerce_app_food_delievery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../widgets/app_text_field.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage> {
  String? myToken='';

  @override
  void initState() {
    // TODO: implement initState
   // requestPermission();
    getToken();
    //initInfo();

    super.initState();
  }
  void getToken()async{
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        myToken=token;
      });
      //saveToken(token!);
    });
  }

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordControlller = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    // var signUpImages = [
    //   "t.png",
    //   "f.png",
    //   "g.png",
    // ];



    void _registeration(AuthController authController){
      getToken();
      String? myNewToken=myToken.toString();
      String name=nameController.text.trim();
      String email=emailController.text.trim();
      String password=passwordControlller.text.trim();
      String phone=phoneController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("ادخل الاسم",title: "الاسم");

      }else if(phone.isEmpty){
        showCustomSnackBar("ادخل رقم الهاتف",title: "رقم الهاتف");

      }else if(email.isEmpty){
        showCustomSnackBar("ادخل البريد الإلكتروني",title: "البريد الإلكتروني");

      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("تم إدخال البريد الإلكتروني بشكل خاطىء",title: "عنوان بريد إلكتروني خاطىء");

      }
      else if(password.isEmpty){
        showCustomSnackBar("ادخل كلمة المرور",title: "كلمة المرور");
      }
      else if(password.length<6){
        showCustomSnackBar("يجب ألا تقل كلمة المرور عن ستة محارف",title: "كلمة المرور");

      }
      else{
        SignUpBody signUpBody= SignUpBody(
          email: email,
          password: password,
          phone:phone,
          name: name,
          token: myNewToken,
        );
        authController.registeration(signUpBody).then((status){
          if(status.isSuccess){
            Get.offNamed(RoutesHelper.getInitial());
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



    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (_authController) {
          return !_authController.isLoading?SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.height30,
                ),
                //app logo
                SizedBox(
                  height: Dimensions.screenHeight * 0.25,
                  child: const Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      backgroundImage: AssetImage("assets/image/icon.png"),
                    ),
                  ),
                ),
                //Email field
                AppTextField(
                  icon: Icons.email,
                  controller: emailController,
                  hintText: "البَرَيد الإلِكتّرَوني",
                  keyboardType: TextInputType.emailAddress,

                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                //Password field
                AppTextField(
                  icon: Icons.password,
                  controller: passwordControlller,
                  hintText: "كَلِمَةُ المَرور",
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                //Name field
                AppTextField(
                  icon: Icons.person,
                  controller: nameController,
                  hintText: "الاَسَم",
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                //Phone field
                AppTextField(
                  icon: Icons.phone,
                  controller: phoneController,
                  hintText: " رَقَمُ الهَاتِف",
                  keyboardType: TextInputType.phone,

                ),
                // sign up button
                SizedBox(
                  height: Dimensions.height20 * 2,
                ),
                GestureDetector(
                  onTap: (){
                    _registeration(_authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth / 2,
                    height: Dimensions.screenHeight / 13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color:Colors.black),
                    child: Center(
                        child: BigText(
                      text: "تَسجِيلُ الدَخُول",

                      color: Colors.white,
                      size: Dimensions.font20+5,
                    )),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                //already account link
                RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () => Get.to(()=>SignInPage(),transition: Transition.fade),
                      text: "  لَدَيكَ حِسَاب مُسبَقَاً؟",
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Dimensions.font20-5)),
                ),
                SizedBox(
                  height: Dimensions.height30,
                ),
                //sign up using following
                // RichText(
                //   text: TextSpan(
                //       text: "سجل الدخول باستخدام طرق أخرى",
                //       style: TextStyle(
                //           color: Colors.grey[500], fontSize: Dimensions.font16)),
                // ),
                // //Wrap widget

                // Wrap(
                //   children: List.generate(
                //     3,
                //     (index) => Padding(
                //       padding: const EdgeInsets.all(3.0),
                //       child: InkWell(
                //         onTap: (){
                //           //print(signUpImages[index]+"tappped this image");
                //         },
                //         child: CircleAvatar(
                //           radius: Dimensions.radius30,
                //           backgroundImage: AssetImage("assets/image/"+signUpImages[index]
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ):CustomLoader();
        }
      ),
    );


  }
}
