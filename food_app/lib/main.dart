import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_app/helper/notification_helper.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:get/get.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
 Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await dep.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder :(_){
    return GetBuilder<RecommendedProductController>(builder: (_){
      return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
        // home: SingInPage(),
       initialRoute: RouteHelper.getSplashPage(),
       getPages: RouteHelper.routes,
     );
    });
   });
  }}
