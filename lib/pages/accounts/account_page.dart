import 'package:ecommerce_app_food_delievery/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_food_delievery/base/custom_loader.dart';
import 'package:ecommerce_app_food_delievery/controllers/cart_controller.dart';
import 'package:ecommerce_app_food_delievery/controllers/user_controller.dart';
import 'package:ecommerce_app_food_delievery/routes/route_helper.dart';
import 'package:ecommerce_app_food_delievery/utils/dimensions.dart';
import 'package:ecommerce_app_food_delievery/widgets/app_icon.dart';
import 'package:ecommerce_app_food_delievery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/auth_controller.dart';
import 'account_widget.dart';
import 'dart:io';
class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    File? _image;
    bool _isUserLoginnIn=Get.find<AuthController>().UserLoggedIn();
    if(_isUserLoginnIn){
      Get.find<UserController>().getUserInfo();
    }


    final picker=ImagePicker();

    Future  getGalleryImage() async {
      final pickedFile = await picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);
        setState(() {
          if (pickedFile != null) {
            _image = File(pickedFile.path);
          }
          else {
          }
        });

    }


    return Scaffold(

      appBar:const CustomAppBar(title: "الحِسَاب الشَخصِي",),
      body: GetBuilder<UserController>(
          builder: (userController) {
            return _isUserLoginnIn?(userController.isLoading?Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: Dimensions.height20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: Stack(
                      children: [

                        _image!=null?Image.file( _image!.absolute,): GestureDetector(
                          onTap:(){
                            setState(() {
                              userController.getGalleryImage();
                            });

                          },
                          child: AppIcon(
                            icon: Icons.person,
                            size: 100,
                            iconColor:Colors.white,
                            backgroundColor:const Color.fromARGB(255, 206, 143, 48) ,
                            iconSize: 70,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child:   GestureDetector(
                            onTap: (){

                              userController.getGalleryImage();


                            },
                            child: AppIcon(
                            icon: Icons.camera_alt_outlined,
                            size: 40,
                            iconColor: const Color.fromARGB(255, 206, 143, 48),
                            backgroundColor: Colors.white,
                            iconSize: 20,
                        ),
                          ),)
                      ],

                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        //person
                        SizedBox(height: Dimensions.height20,),
                        AccountWidget(appIcon: AppIcon(
                          icon: Icons.person,
                          size: Dimensions.height10*5,
                          iconColor: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 206, 143, 48) ,
                          iconSize: Dimensions.height10*5/2,
                        ),
                          bigText: BigText(text: userController.userModel!.name,),
                        ),
                        //phone
                        SizedBox(height: Dimensions.height20,),
                        AccountWidget(appIcon: AppIcon(
                          icon: Icons.phone,
                          size: Dimensions.height10*5,
                          iconColor:Colors.white,
                          backgroundColor: const Color.fromARGB(255, 206, 143, 48) ,
                          iconSize: Dimensions.height10*5/2,
                        ),
                          bigText: BigText(text: userController.userModel!.phone,),
                        ),
                        //email
                        SizedBox(height: Dimensions.height20,),
                        AccountWidget(appIcon: AppIcon(
                          icon: Icons.email,
                          size: Dimensions.height10*5,
                          iconColor:Colors.white,
                          backgroundColor:const Color.fromARGB(255, 206, 143, 48),
                          iconSize: Dimensions.height10*5/2,
                        ),
                          bigText: BigText(text: userController.userModel!.email,),
                        ),
                        //address
                        SizedBox(height: Dimensions.height20,),
                        GetBuilder<UserController>(
                          builder: (locationController) {
                            if(_isUserLoginnIn){
                              return GestureDetector(
                                onTap: (){
                                  Get.toNamed(RoutesHelper.getAddressPage());
                                },
                                child: AccountWidget(appIcon: AppIcon(
                                  icon: Icons.location_on,
                                  size: Dimensions.height10*5,
                                  iconColor:Colors.white,
                                  backgroundColor: const Color.fromARGB(255, 206, 143, 48),
                                  iconSize: Dimensions.height10*5/2,
                                ),
                                  bigText: BigText(text: "ادخِلْ العَنوان الخَاص بِكَ",),
                                ),
                              );
                            }else{
                              return GestureDetector(
                                onTap: (){
                                  Get.toNamed(RoutesHelper.getAddressPage());
                                },
                          
                              );
                            }


          } ),
                        //messgaes
                        // SizedBox(height: Dimensions.height20,),
                        // AccountWidget(appIcon: AppIcon(
                        //   icon: Icons.message,
                        //   size: Dimensions.height10*5,
                        //   iconColor: Colors.white,
                        //   backgroundColor: Colors.red,
                        //   iconSize: Dimensions.height10*5/2,
                        // ),
                        //   bigText: BigText(text: "Messages",),
                        // ),
                        SizedBox(height: Dimensions.height20,),
                        GestureDetector(
                          onTap: (){
                            if(Get.find<AuthController>().UserLoggedIn()) {
                              Get.find<AuthController>().clearSharedData();
                              Get.find<CartController>().clear;
                              Get.find<CartController>().clearCartHistory();

                              Get.offNamed(RoutesHelper.getSignInPage());
                            }

                          },
                          child: AccountWidget(appIcon: AppIcon(
                            icon: Icons.logout,
                            size: Dimensions.height10*5,
                            iconColor:Colors.white,
                            backgroundColor: const Color.fromARGB(255, 206, 143, 48),
                            iconSize: Dimensions.height10*5/2,
                          ),
                            bigText: BigText(text: "تَسجِيل الخَرُوج",),
                          ),
                        ),
                      ],),
                    ),
                  )

                ],
              ),
            ):
            CustomLoader())
                :Container(child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                  width: double.maxFinite,
                  height: Dimensions.height20 * 12,
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          fit: BoxFit.contain,

                          image: AssetImage(
                              "assets/image/im.png"
                          )
                      )
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesHelper.getSignInPage());
                  },
                  child: Container(


                    height: Dimensions.height20*2.5 ,
                    width: Dimensions.width20*10 ,
                    margin: EdgeInsets.only(left: Dimensions.width20*5,
                        right: Dimensions.width20*5,
                        top: Dimensions.width20*5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(Dimensions.radius20),

                    ),
                    child: Center(
                      child: BigText(
                        text: "تَسجِيل الدَخُول",
                        color: Colors.white,
                        size: 20,

                      ),
                    ),
                  ),
                )
              ],
            ),),);
          }
      ),
    );
  }
}