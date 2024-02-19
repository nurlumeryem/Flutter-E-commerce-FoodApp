import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/models/products_model.dart';
import 'package:food_app/pages/food/popular_food_detail.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_column.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FoodPageBody extends StatefulWidget{
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.8);
  var _currPageValue=0.0;
  double _scaleFactor=0.8;
  double _height =Dimensions.pageViewContainer;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue= pageController.page!;
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
      GetBuilder<PopularProductController>(builder: (popularProducts){
        return popularProducts.isLoaded?Container(
          height: Dimensions.pageView,
          child: GestureDetector(
         
            child: PageView.builder(
                controller: pageController,
                itemCount:popularProducts.popularProductList.length,
                itemBuilder:(context,position){
                  return _buildPageItem(position,popularProducts.popularProductList! as ProductModel);
                }),
          ),
        ):CircularProgressIndicator(
          color : AppColors.mainColor,
        );
      }),
    // dots
    GetBuilder<PopularProductController>(builder: (popularProducts){
      return  DotsIndicator(
        dotsCount: popularProducts.popularProductList.isEmpty? 1 : popularProducts.popularProductList.length,
        position: _currPageValue.toInt(),
        decorator: DotsDecorator(
          activeColor: Colors.orange,
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      );
    }),
        //Popular text
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Gıda Eşleştirmesi"),
              )
            ],
          ),
        ),
        // recommended food
        //list of food and images
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
        return recommendedProduct.isLoaded?  ListView.builder(
        physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: recommendedProduct.recommendedProductList.length,
          itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
            },
            child: Container(
            margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.height10),
            child: Row(
            children: [
            //image section
            Container(
            width: Dimensions.ListViewImgSize,
            height: Dimensions.ListViewImgSize,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            color: Colors.white38,
            image: DecorationImage(
            fit: BoxFit.cover,
            image:  NetworkImage(
            AppConstants.BASE_URL+ AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
            )
            )
            )
            ),
            // text container
            Expanded(
            child: Container(
            height: Dimensions.ListViewTextContSize,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.radius20),
            bottomRight: Radius.circular(Dimensions.radius20),
            ),
            color: Colors.white,
            ),
            child: Padding(
            padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            BigText(text: recommendedProduct.recommendedProductList[index].name!),
            SizedBox(height: Dimensions.height10),
            SmallText(text: "Yöresel Lezzetler"),
            SizedBox(height: Dimensions.height10),
            const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            IconAndTextWidget(icon: Icons.circle_sharp,
            text: "Normal",
            iconColor:AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.location_on,
            text: "1.3km",
            iconColor:AppColors.mainColor),
            IconAndTextWidget(icon: Icons.access_time_rounded,
            text: "30-45 dk",
            iconColor:AppColors.iconColor2),
            ],
            ),
            ],
            ),
            ),
            ),
            )
            ],
            ),
            ),
          );
          }):CircularProgressIndicator(
          color: AppColors.mainColor,
        );
        })
    ],
    );
  }
  //bir sayfa geçiş efekti için kullandım
  Widget _buildPageItem( int index, ProductModel popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index==_currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix= Matrix4.diagonal3Values(1,currScale,1)..setTranslationRaw(0, currTrans, 0);

    }else if(index==_currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2; //1/10*220= 22
      matrix= Matrix4.diagonal3Values(1,currScale,1);
      matrix= Matrix4.diagonal3Values(1,currScale,1)..setTranslationRaw(0, currTrans, 0);

    } else if(index==_currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix= Matrix4.diagonal3Values(1,currScale,1);
      matrix= Matrix4.diagonal3Values(1,currScale,1)..setTranslationRaw(0, currTrans, 0);


    }else{
      var currScale = 0.8;
      matrix= Matrix4.diagonal3Values(1,currScale,1)..setTranslationRaw(0, _height*(1-currScale)/2,1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
        GestureDetector(
          onTap: (){

            Get.toNamed(RouteHelper.getPopularFood(index, "home"));
          },
          child: Container(
          height: Dimensions.pageViewContainer,
          margin: EdgeInsets.only(left:Dimensions.width10, right:Dimensions.width10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                     AppConstants.BASE_URL+ AppConstants.UPLOAD_URL+popularProduct.img!
                  )
              )
          ),

      ),
        ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
               height: Dimensions.pageTextContainer,
              margin: EdgeInsets.only(left:Dimensions.width30, right:Dimensions.width30,bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5,0)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(5,0)
                    ),
                  ]
                      ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15 ,left: 15,right: 15),
                child: AppColumn(text: popularProduct.name!),
              ),
                  )
              ),]),
    );
  }
}
