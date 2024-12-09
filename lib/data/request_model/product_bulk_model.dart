import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:get/instance_manager.dart';

class ProductSizeModel {
  ProductSizeModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    unit = json['size'];
    price = json['price'] != null ? json['price'].toString() : null;
  }

  ProductSizeModel({required this.unit, required this.price});

  int? id;
  String? unit;
  String? price;

  String getAmount() {
    return '${price ?? '0.0'} ${Get.find<GlobalController>().priceRangeData?.currencySymbol ?? AppConstants.defaultCurrency} ';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['parent'] = this.id;
    }
    data['size'] = this.unit;
    data['price'] = this.price;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
