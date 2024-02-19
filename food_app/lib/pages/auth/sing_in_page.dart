import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/pages/auth/sing_up_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/colors.dart';

class SingInPage extends StatelessWidget{
  const SingInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    void _login(AuthController authController){

      String email= emailController.text.trim();
      String password= passwordController.text.trim();

      if(email.isEmpty){
        showCustomSnackBar("Type in your email", title: "Email address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in your email address", title: " Valid Email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "password");
      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six charecters", title: "Password");
      }else{
        showCustomSnackBar("All went well", title: "Perfect");

        authController.login(email, password).then((status){
          if(status.isSuccess){
           Get.toNamed(RouteHelper.getInitial());
           // Get.toNamed(RouteHelper.getCartPage());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder:(authController){
        return !authController.isLoading? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              // app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/image/logo part 1.png"
                    ),
                  ),
                ),
              ),
              //welcome
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font16*3+Dimensions.font20/2,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          //fontWeight: FontWeight.bold
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              //email
              AppTextField(textController: emailController,
                  hintText: "Email",
                  icon: Icons.email,),
              SizedBox(height: Dimensions.height20,),
              //password
              AppTextField(textController: passwordController,
                  hintText: "Password",
                  icon: Icons.password_sharp, isObscure: true),
              SizedBox(
                height: Dimensions.height10,),
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(

                      text: TextSpan(

                          text: "Sing into your account",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: Dimensions.font20,
                          )
                      )),
                  SizedBox(width: Dimensions.width20,)
                ],
              ),
              SizedBox(height: Dimensions.height20*3,),
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(text: "Sing in",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(
                  text: TextSpan(
                      text: "Dont an account?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.font20,
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SingUpPage(),transition: Transition.fade),
                            text: " Create",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20,
                            )),
                      ]
                  )),


            ],
          )):CustomLoader();
      },)
    );
  }
}
