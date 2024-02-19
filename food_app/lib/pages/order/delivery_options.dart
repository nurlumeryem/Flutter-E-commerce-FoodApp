import 'package:flutter/material.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/utils/styles.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DeliveryOptions extends StatelessWidget{
  final String value;
  final String title;
  final double amount;
  final bool isFree;

  const DeliveryOptions({super.key, required this.value, required this.title, required this.amount, required this.isFree});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder:(orderController){
     return Row(
        children: [
          Radio(value: value,
              activeColor: Theme.of(context).primaryColor,
              groupValue: orderController.orderType,
              onChanged:(String ? value) =>orderController.setDeliveryType(value!),

          ),
          SizedBox(width: Dimensions.width10/2,),
          Text(title, style: robotoRegular,),
          SizedBox(width: Dimensions.width10/2,),
          Text(
            '(${(value== 'take away' || isFree)?'free':'\$${amount/10}'})',
            style: robotoMedium,
          )
        ],
      );

    });
  }
}
