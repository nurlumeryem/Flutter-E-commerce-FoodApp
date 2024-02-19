import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/styles.dart';

class  ViewOrder extends StatelessWidget{
  final bool isCurrent;
  const  ViewOrder({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController)
    {
      if (orderController.isLoading == false) {
        late List<OrderModel> orderList;
        if (orderController.currentOrderList.isNotEmpty) {
          orderList =
          isCurrent ? orderController.currentOrderList.reversed.toList() :
          orderController.historyOrderList.reversed.toList();
        }
      return SizedBox(
        width: Dimensions.screenWidth,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:  Dimensions.width10/2, vertical: Dimensions.height10/2),
          child: ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context,index){
                return InkWell(
                    onTap: ()=> null,
                    child: Column(
                      children: [
                        Container(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Row(
                               children: [
                                 Text("#order id ", style: robotoRegular.copyWith(
                                   fontSize: Dimensions.font16
                                 )),
                                 SizedBox(width: Dimensions.width10/2,),
                                 Text('#${orderList[index].id.toString()}'),
                               ],
                             ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 Container(
                                   decoration: BoxDecoration(
                                     color: AppColors.mainColor,
                                     borderRadius: BorderRadius.circular(Dimensions.radius20/3)
                                   ),
                                   padding: EdgeInsets.symmetric(horizontal:  Dimensions.width10,
                                   vertical: Dimensions.width10/2
                                   ),
                                   child: Container(
                                     margin: EdgeInsets.all(Dimensions.height10/2),
                                     child:  Text('${orderList[index].orderStatus}',
                                     style: robotoMedium.copyWith(
                                        fontSize: Dimensions.font16,
                                        color:  Theme.of(context).cardColor
                                        ),
                                     ),
                                   )
                                 ),
                                  SizedBox(height: Dimensions.height10,),
                                  InkWell(
                                    onTap: ()=> null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(Dimensions.radius20/3),
                                        border: Border.all(width: 1,color: Theme.of(context).primaryColor),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset("assets/image/logo.png",height: 15,width: 15,
                                          color: Theme.of(context).primaryColor,
                                          ),
                                          SizedBox(width:  Dimensions.width10/2,),
                                          Text(
                                            "track order",
                                            style:  robotoMedium.copyWith(
                                              fontSize:  Dimensions.font16,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          )
                                        ],
                                      )
                                    ),

                                  )
                                ],
                              )
                            ],
                          ),

                        ),
                        SizedBox(height: Dimensions.height10,)
                      ],
                    )
                );
              }),
        )
      );
    }else {
        return CustomLoader();
      }
      }),
    );
  }
}
