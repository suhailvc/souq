import 'package:atobuy_vendor_flutter/controller/order/purchase_history/purchase_history_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/request_model/order_filer_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseHistoryFilterController extends GetxController {
  PurchaseHistoryFilterController({required this.listController});

  final PurchaseHistoryListController listController;
  TextEditingController txtOrderId = TextEditingController();
  TextEditingController txtMinPrice = TextEditingController();
  TextEditingController txtMaxPrice = TextEditingController();
  PaymentModel? selectedPaymentStatus;
  DateTime? filterFromDate;
  DateTime? filterToDate;
  OrderStatus? selectedOrderStatus;
  RangeValues rangeValues = RangeValues(0.0, 1.0);
  List<OrderStatus> orderStatusList = OrderStatus.values;
  List<PaymentModel> paymentStatusList = <PaymentModel>[];

  @override
  void onInit() {
    super.onInit();
    setFilterData();
  }

  void setFilterData() {
    final OrderListRequestModel requestModel = listController.requestModel;
    paymentStatusList = listController.paymentStatusList;
    txtOrderId.text = requestModel.orderId ?? '';
    txtMinPrice.text = requestModel.getMinValue(listController.rangeValues);
    txtMaxPrice.text = requestModel.getMaxValue(listController.rangeValues);
    selectedPaymentStatus = requestModel.selectedPaymentStatus;
    selectedOrderStatus = requestModel.selectedOrderStatus;
    filterFromDate = requestModel.filterFromDate;
    filterToDate = requestModel.filterToDate;
    rangeValues = listController.rangeValues;
  }

  void setPaymentMode(final PaymentModel paymentStatusModel) {
    if (selectedPaymentStatus != null &&
        selectedPaymentStatus == paymentStatusModel) {
      selectedPaymentStatus = null;
    } else if (selectedPaymentStatus != null &&
        selectedPaymentStatus != paymentStatusModel) {
      selectedPaymentStatus = paymentStatusModel;
    } else {
      selectedPaymentStatus = paymentStatusModel;
    }
    update();
  }

  void setOrderStatus(final OrderStatus orderStatusModel) {
    if (selectedOrderStatus != null &&
        selectedOrderStatus == orderStatusModel) {
      selectedOrderStatus = null;
    } else if (selectedOrderStatus != null &&
        selectedOrderStatus != orderStatusModel) {
      selectedOrderStatus = orderStatusModel;
    } else {
      selectedOrderStatus = orderStatusModel;
    }
    update();
  }

  OrderListRequestModel getRequestModel() {
    return OrderListRequestModel(
      minPrice: txtMinPrice.text.toDouble(),
      maxPrice: txtMaxPrice.text.toDouble(),
      selectedOrderStatus: selectedOrderStatus,
      selectedPaymentStatus: selectedPaymentStatus,
      filterFromDate: filterFromDate,
      filterToDate: filterToDate,
      orderId: txtOrderId.text,
    );
  }

  void onChangeRange(final RangeValues value) {
    rangeValues = value;
    txtMinPrice.text = rangeValues.start.toStringAsFixed(2);
    txtMaxPrice.text = rangeValues.end.toStringAsFixed(2);
    update();
  }

  void onChangeFromDate(final DateTime fromDate) {
    filterFromDate = fromDate;
    if (filterToDate != null) {
      if (filterToDate!.isBefore(filterFromDate!)) {
        filterToDate = null;
      }
    }
    update();
  }

  void onChangeToDate(final DateTime toDate) {
    filterToDate = toDate;
    update();
  }

  void onChangeMaxPriceRange(final String value) {
    final RangeValues? range = Utility.onChangeMaxPriceRange(
      value: value,
      filterViewRange: rangeValues,
    );
    setPriceValueToRangeSlider(range);
  }

  void onChangeMinPriceRange(final String value) {
    final RangeValues? range = Utility.onChangeMinPriceRange(
      value: value,
      filterViewRange: rangeValues,
      listViewRange: listController.rangeValues,
    );
    setPriceValueToRangeSlider(range);
  }

  void setPriceValueToRangeSlider(final RangeValues? value) {
    if (value != null) {
      rangeValues = value;
      update();
    }
  }
}
