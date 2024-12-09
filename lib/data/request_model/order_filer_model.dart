import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:flutter/material.dart';

class OrderListRequestModel {
  OrderListRequestModel(
      {this.filterFromDate,
      this.filterToDate,
      this.selectedOrderStatus,
      this.selectedPaymentStatus,
      this.orderId,
      this.sortSelectedValue = SortOptions.newestFirst,
      this.maxPrice,
      this.minPrice});
  String? orderId;
  double? minPrice;
  double? maxPrice;
  OrderStatus? selectedOrderStatus;

  PaymentModel? selectedPaymentStatus;
  DateTime? filterFromDate;
  DateTime? filterToDate;
  SortOptions sortSelectedValue;

  String getMinValue(final RangeValues rangeValues) {
    return (minPrice != null ? minPrice! : rangeValues.start)
        .toStringAsFixed(2);
  }

  String getMaxValue(final RangeValues rangeValues) {
    return (maxPrice != null ? maxPrice! : rangeValues.end).toStringAsFixed(2);
  }
}

class ProductListReqModel {
  ProductListReqModel(
      {this.selectedCategory,
      this.selectedSubCategory,
      this.selectedProductApprovalStatus,
      this.selectedProductStatus,
      this.sortSelectedValue = SortOptions.newestFirst,
      this.maxPrice,
      this.minPrice});
  double? minPrice;
  double? maxPrice;
  Category? selectedCategory;
  Category? selectedSubCategory;
  SortOptions sortSelectedValue;
  ProductApprovalStatus? selectedProductApprovalStatus;
  ProductStatus? selectedProductStatus;

  String getMinValue(final RangeValues rangeValues) {
    return (minPrice != null ? minPrice! : rangeValues.start)
        .toStringAsFixed(2);
  }

  String getMaxValue(final RangeValues rangeValues) {
    return (maxPrice != null ? maxPrice! : rangeValues.end).toStringAsFixed(2);
  }
}
