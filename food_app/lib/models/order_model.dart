import 'address_model.dart';

class OrderModel {
  late int id;
  late int userId;
  double? orderAmount;
  String? orderStatus;
  String? paymentStatus;
  double? totalTaxAmount;
  String? orderNote;
  String? createdAt;
  String? updatedAt;
  double? deliveryCharge;
  String? scheduleAt;
  String? otp;
  String? pending;
  String? accepted;
  String? confirmed;
  String? processing;
  String? handover;
  String? pickedUp;
  String? canceled;
  String? refundRequested;
  String? refunded;
  int? scheduled;
  String? failed;
  int? detailsCount;

  AddressModel? deliveryAddress;

  OrderModel({
    required this.id,
    required this.userId,
    this.orderAmount,
    this.orderStatus,
    this.paymentStatus,
    this.totalTaxAmount,
    this.orderNote,
    this.createdAt,
    this.updatedAt,
    this.deliveryCharge,
    this.scheduleAt,
    this.otp,
    this.pending,
    this.accepted,
    this.confirmed,
    this.processing,
    this.handover,
    this.pickedUp,
    this.canceled,
    this.refundRequested,
    this.refunded,
    this.scheduled,
    this.failed,
    this.detailsCount,
    this.deliveryAddress,
  });

  // Named constructor for creating an instance from JSON data
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'],
      orderAmount: json['orderAmount']?.toDouble(),
      orderStatus: json['orderStatus'],
      paymentStatus: json['paymentStatus'],
      totalTaxAmount: json['totalTaxAmount']?.toDouble(),
      orderNote: json['orderNote'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deliveryCharge: json['deliveryCharge']?.toDouble(),
      scheduleAt: json['scheduleAt'],
      otp: json['otp'],
      pending: json['pending'],
      accepted: json['accepted'],
      confirmed: json['confirmed'],
      processing: json['processing'],
      handover: json['handover'],
      pickedUp: json['pickedUp'],
      canceled: json['canceled'],
      refundRequested: json['refundRequested'],
      refunded: json['refunded'],
      scheduled: json['scheduled'],
      failed: json['failed'],
      detailsCount: json['detailsCount'],
      // Deserialize the nested AddressModel if present in JSON
      deliveryAddress: json['deliveryAddress'] != null
          ? AddressModel.fromJson(json['deliveryAddress'])
          : null,
    );
  }

  // Method to convert an instance to JSON data
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data= new Map<String,dynamic>();
    data['dataId'] = this.id;
    data['dataUserId'] = userId;
    data['dataOrderAmount'] = orderAmount;
    data['dataOrderStatus'] = orderStatus;
    data['dataPaymentStatus'] = paymentStatus;
    data['dataTotalTaxAmount'] = totalTaxAmount;
    data['dataOrderNote'] = orderNote;
    data['dataCreatedAt'] = createdAt;
    data['dataUpdatedAt'] = updatedAt;
    data['dataDeliveryCharge'] = deliveryCharge;
    data['dataScheduleAt'] = scheduleAt;
    data['dataOtp'] = otp;
    data['dataPending'] = pending;
    data['dataAccepted'] = accepted;
    data['dataConfirmed'] = confirmed;
    data['dataProcessing'] = processing;
    data['dataHandover'] = handover;
    data['dataPickedUp'] = pickedUp;
    data['dataCanceled'] = canceled;
    data['dataRefundRequested'] = refundRequested;
    data['dataRefunded'] = refunded;
    data['dataScheduled'] = scheduled;
    data['dataFailed'] = failed;
    data['dataDetailsCount'] = detailsCount;
    if(this.deliveryAddress != null){
    data['dataDeliveryAddress'] = deliveryAddress?.toJson();
  }
    return data;
    }
  }

