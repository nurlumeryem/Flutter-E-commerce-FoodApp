 import 'package:flutter/material.dart';
import 'package:food_app/base/custom_button.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget{
  final String orderID;
  final int status;
  OrderSuccessPage({super.key, required this.orderID, required this.status});

   @override
   Widget build(BuildContext context) {
     if(status==0){
       Future.delayed(Duration(seconds: 1),(){

       });
     }
     return Scaffold(

       body: Center(
         child: SizedBox(width: Dimensions.screenWidth,child:
             Column(mainAxisAlignment: MainAxisAlignment.center, children: [
               Icon(Icons.check_circle_outline),
             SizedBox(
             height: Dimensions.height45),
             Text(
             status == 1 ? 'SUCCESSFULLY' : ' FAİLED',
               style: TextStyle(fontSize: Dimensions.font20),
             ),
               SizedBox(height: Dimensions.height20),
               Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.height20,
               vertical: Dimensions.height20),
               child: Text(
                 status == 1 ? 'Successful order' : 'Failed order',
                 style: TextStyle(fontSize: Dimensions.font20,
                 color: Theme.of(context).disabledColor),
                 textAlign: TextAlign.center,
               ),
               ),
               SizedBox(height: 35,),
               Padding(padding: EdgeInsets.all(Dimensions.height20),
               child: CustomButton(buttonText: 'Back to Home', onPressed: ()=> Get.offAllNamed(RouteHelper.getInitial())),
               )

             ],)

         ),
       ),

     );
   }
 }
