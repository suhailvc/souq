import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:get/get.dart';

class WalletBalanceModel {
  WalletBalanceModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'];
  }

  WalletBalanceModel({this.id, this.balance});
  int? id;
  String? balance;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['balance'] = balance;
    return data;
  }

  String getWalletBalance() {
    final String? strBalance = this.balance.toDouble()?.toStringAsFixed(2);
    return '${strBalance ?? 0.00} ${Get.find<GlobalController>().priceRangeData?.currencySymbol ?? AppConstants.defaultCurrency}';
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
