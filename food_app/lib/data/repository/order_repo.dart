import 'package:food_app/models/place_order_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';

class OrderRepo{
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

 Future<Response> placeOrder(PlaceOrderBody placeOrder)async{
   return await apiClient.getData(AppConstants.PLACE_ORDER_URI, json: placeOrder.toJson());

 }
  Future<Response> getOrderList()async{
    return await apiClient.getData(AppConstants.ORDER_LIST_URI);

  }
}