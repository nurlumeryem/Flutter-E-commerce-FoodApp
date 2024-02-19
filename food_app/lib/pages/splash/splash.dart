import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:food_app/routes/route_helper.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  Future <void> _loadResource() async{
   await Get.find<PopularProductController>().getPopularProductList();
   await  Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();

    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );

    // Start the animation
    animationController.forward();

    // Set a timer to stop the animation after 3 seconds
    Timer(Duration(seconds: 3), () {
      // Stop the animation
      animationController.stop();

      // Navigate to the next screen
      Get.offNamed(RouteHelper.getInitial());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Center(
                child: Image.asset(
                  "assets/image/logo.png",
                  width: Dimensions.splashImg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
