import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:get/get.dart';

class OrderStatsModel {
  OrderStatsModel({
    this.deliveredOrdersCount,
    this.processingOrdersCount,
    this.pendingOrdersCount,
    this.rejectedOrdersCount,
    this.totalOrders,
    this.totalSales,
    this.onlineOrderPayment,
    this.codOrderPayment,
  });

  OrderStatsModel.fromJson(final Map<String, dynamic> json) {
    deliveredOrdersCount = json['delivered_orders_count'];
    processingOrdersCount = json['processing_orders_count'];
    pendingOrdersCount = json['pending_orders_count'];
    outForDeliveryOrdersCount = json['out_for_delivery_orders_count'];
    rejectedOrdersCount = json['rejected_orders_count'];

    totalOrders = json['total_orders'];
    totalSales = json['total_sales'];
    onlineOrderPayment = json['online_orders'];
    codOrderPayment = json['cod_orders'];
  }
  int? deliveredOrdersCount;
  int? processingOrdersCount;
  int? pendingOrdersCount;
  int? rejectedOrdersCount;
  int? outForDeliveryOrdersCount;
  int? totalOrders;
  double? totalSales;
  double? onlineOrderPayment;
  double? codOrderPayment;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'delivered_orders_count': deliveredOrdersCount,
        'processing_orders_count': processingOrdersCount,
        'pending_orders_count': pendingOrdersCount,
        'rejected_orders_count': rejectedOrdersCount,
        'out_for_delivery_orders_count': outForDeliveryOrdersCount,
        'total_orders': totalOrders,
        'total_sales': totalSales,
        'online_orders': onlineOrderPayment,
        'cod_orders': codOrderPayment,
      };

  String _getCurrency() {
    return '${Get.find<GlobalController>().priceRangeData?.currencySymbol ?? AppConstants.defaultCurrency}';
  }

  String getTotalSalesPrice() {
    return '${(totalSales ?? 0.0).toStringAsFixed(2)} ${_getCurrency()}';
  }

  String getTotalOnlinePayments() {
    return '${(onlineOrderPayment ?? 0.0).toStringAsFixed(2)} ${_getCurrency()}';
  }

  String getTotalCODPayments() {
    return '${(codOrderPayment ?? 0.0).toStringAsFixed(2)} ${_getCurrency()}';
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
