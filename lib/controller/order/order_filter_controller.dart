import 'package:atobuy_vendor_flutter/controller/order/order_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/request_model/order_filer_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderFilterController extends GetxController {
  OrderFilterController({required this.listController});

  final OrderListController listController;

  TextEditingController txtOrderId = TextEditingController();
  TextEditingController txtMinPrice = TextEditingController();
  TextEditingController txtMaxPrice = TextEditingController();
  PaymentModel? selectedPaymentStatus;
  DateTime? filterFromDate;
  DateTime? filterToDate;
  OrderStatus? selectedOrderStatus;
  RangeValues rangeValues = RangeValues(0.0, 1.0);
  List<PaymentModel> paymentStatusList = <PaymentModel>[];

  @override
  void onInit() {
    super.onInit();
    setFilterData();
  }

  void setFilterData() {
    final OrderListRequestModel requestModel = listController.requestModel;
    paymentStatusList = listController.paymentModeList;
    txtOrderId.text = requestModel.orderId ?? '';
    txtMinPrice.text = requestModel.minPrice != null
        ? requestModel.minPrice!.toStringAsFixed(2)
        : listController.rangeValues.start.toStringAsFixed(2);
    txtMaxPrice.text = requestModel.maxPrice != null
        ? requestModel.maxPrice!.toStringAsFixed(2)
        : listController.rangeValues.end.toStringAsFixed(2);
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
    } else {
      filterToDate = fromDate;
    }
    update();
  }

  void onChangeToDate(final DateTime toDate) {
    filterToDate = toDate;
    if (filterFromDate == null) {
      filterFromDate = toDate;
    }
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
