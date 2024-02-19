import 'package:flutter/material.dart';
import 'package:food_app/base/custom_app_bar.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/account_widget.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget{
  const  AccountPage({Key? key}) : super(key :key);

  @override
  Widget build(BuildContext context) {
    //kullanıcı giriş yapmış mı kontrol edilir.
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      //Giriş yapılmışsa
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: CustomAppBar(title: "Profile"),

      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?
        (userController.isLoading?Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(top: Dimensions.height30),
          child: Column(
            children: [
              //profile icon
              AppIcon(icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconSize: Dimensions.height45+Dimensions.height30,
                iconColor: Colors.white,
                size:  Dimensions.height15*10,),
              SizedBox(height: Dimensions.height30,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //name
                      AccountWidget(appIcon:
                      AppIcon(icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.height15*5/2,
                        iconColor: Colors.white,
                        size:  Dimensions.height10*5,),

                          bigText: BigText(text: userController.userModel!.name)),
                      SizedBox(height: Dimensions.height20,),
                      //phone
                      AccountWidget(appIcon:
                      AppIcon(icon: Icons.phone,
                        backgroundColor: AppColors.yellowColor,
                        iconSize: Dimensions.height15*5/2,
                        iconColor: Colors.white,
                        size:  Dimensions.height10*5,),
                          bigText: BigText(text:  userController.userModel!.phone)),
                      SizedBox(height: Dimensions.height20,),
                      //email
                      AccountWidget(appIcon:
                      AppIcon(icon: Icons.email,
                        backgroundColor: AppColors.yellowColor,
                        iconSize: Dimensions.height15*5/2,
                        iconColor: Colors.white,
                        size:  Dimensions.height10*5,),
                          bigText: BigText(text:  userController.userModel!.email)),
                      SizedBox(height: Dimensions.height20,),
                      //address
                       GetBuilder<LocationController>(builder:(locatinController){
                         if(_userLoggedIn&&locatinController.addressList.isEmpty){
                           return GestureDetector(
                             onTap: (){
                               Get.offNamed(RouteHelper.getAddressPage());
                             },
                             child: AccountWidget(appIcon:
                             AppIcon(icon: Icons.location_on,
                               backgroundColor: AppColors.yellowColor,
                               iconSize: Dimensions.height15*5/2,
                               iconColor: Colors.white,
                               size:  Dimensions.height10*5,),
                                 bigText: BigText(text: "Fill in your address")),
                           );
                         }else{

                       return GestureDetector(
                        onTap: (){
                 Get.offNamed(RouteHelper.getAddressPage());
                         },
                        child: AccountWidget(appIcon:
                       AppIcon(icon: Icons.location_on,
                      backgroundColor: AppColors.yellowColor,
                      iconSize: Dimensions.height15*5/2,
                         iconColor: Colors.white,
                         size:  Dimensions.height10*5,),
                         bigText: BigText(text: "Your address")),
                          );
                         }
                       },),
                      SizedBox(height: Dimensions.height20,),
                      //message
                      AccountWidget(appIcon:
                      AppIcon(icon: Icons.message_outlined,
                        backgroundColor: Colors.redAccent,
                        iconSize: Dimensions.height15*5/2,
                        iconColor: Colors.white,
                        size:  Dimensions.height10*5,),
                          bigText: BigText(text: "Messages")),
                      SizedBox(height: Dimensions.height20,),
                      //Logout
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                           // Get.find<LocationController>().clearAddressList();
                            Get.offNamed(RouteHelper.getSingInPage());
                          }else{
                          Get.offNamed(RouteHelper.getSingInPage());
                          }

                        },child:     AccountWidget(appIcon:
                      AppIcon(icon: Icons.logout,
                        backgroundColor: Colors.redAccent,
                        iconSize: Dimensions.height15*5/2,
                        iconColor: Colors.white,
                        size:  Dimensions.height10*5,),
                          bigText: BigText(text: "Logout")),
                      ),
                      SizedBox(height: Dimensions.height20,),

                    ],
                  ),
                ),
              )
            ],
          ),
        ):CustomLoader()): Container(

            child:Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Container(
            width: double.maxFinite,
            height: Dimensions.height20*18,
            margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/logo.png")),
            )),
         GestureDetector(
           onTap: (){
            Get.toNamed(RouteHelper.getSingInPage());
           },
           child: Container(
               width: double.maxFinite,
               height: Dimensions.height20*5,
               margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
               decoration: BoxDecoration(
                 color: AppColors.mainColor,
                 borderRadius: BorderRadius.circular(Dimensions.radius20),
               ),
             child: Center(child: BigText(text: "Sign in" , color: Colors.white,size: Dimensions.font20*2,)),
           ),
         ),
       ])
        ));
      },)
    );
  }
}
