import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_column.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../cart/cart_page.dart';
import '../home/main_food_page.dart';

class PopularFoodDetail extends StatelessWidget{
  int pageId;
  final String page;
  PopularFoodDetail({Key? key, required  this.pageId, required this.page});
  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
               width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image:NetworkImage(
                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                      )
                ),
          ))
          ),
          // icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                  if(page=="cartpage"){
                    Get.toNamed(RouteHelper.getCartPage());
                  }else{
                    Get.toNamed(RouteHelper.getInitial());
                  }
                    },
                    child:
                    AppIcon(icon: Icons.arrow_back_ios)),

                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems>=1)
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                       controller.totalItems>=1?
                        Positioned(
                          right:0, top:0,
                            child: AppIcon(icon: Icons.circle,size: 20,
                              iconColor: Colors.transparent, backgroundColor: AppColors.mainColor,),

                        ):
                        Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right:3, top:3,
                          child: BigText(
                            text: Get.find<PopularProductController>().totalItems.toString(),
                            size: 12, color: Colors.white,
                          ),
                        ):
                        Container(),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          // introduction of food
          Positioned(
            left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize-15,
              child: Container(

                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Hakkında"),
                    SizedBox(height: Dimensions.height20,),
                  Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: product.description!,)))
                  ],
                )

          )),
          // expandable text widget
        ],

      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: 120,
          padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20*2),
                topRight:Radius.circular(Dimensions.radius20*2),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height20, left: Dimensions.width20, right:Dimensions.width20, ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.remove, color: AppColors.singColor,)),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.singColor,)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height20, left: Dimensions.width20, right:Dimensions.width20, ),
                  child: GestureDetector(
                      child: BigText(text: "\${product.price! | Add to cart" , color: Colors.white,)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              )
            ],
          )
        );
      },),
    );
  }
}
