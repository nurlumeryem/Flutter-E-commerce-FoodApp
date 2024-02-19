import 'package:flutter/material.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/utils/styles.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class PaymentOptionButton extends StatelessWidget{
  final IconData icon;
  final String title;
  final String subTitle;
  final int index;
  const PaymentOptionButton({super.key, required this.icon, required this.title, required this.subTitle, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder:(orderController){
      bool _selected = orderController.paymentIndex==index;
      return InkWell(
        onTap: ()=>orderController.setPaymentIndex(index),
        child: Container(
          padding: EdgeInsets.only(bottom: Dimensions.height10/2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20/3),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,blurRadius: 5,spreadRadius: 5
                )
              ]
          ),
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color: _selected?AppColors.mainColor:Theme.of(context).disabledColor,
            ),
            title: Text(
              title,
              style: robotoMedium.copyWith(fontSize:  Dimensions.font20),
            ),
            subtitle: Text(
              subTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: robotoRegular.copyWith(
                color: Theme.of(context).disabledColor,
                fontSize: Dimensions.font16,
              ),
            ),
            trailing: _selected? Icon(Icons.check_circle, color: Theme.of(context).primaryColor,):null,
          ),
        ),
      );
    });
  }
}
