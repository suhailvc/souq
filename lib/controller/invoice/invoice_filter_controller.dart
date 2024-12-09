import 'package:atobuy_vendor_flutter/controller/invoice/invoice_controller.dart';
import 'package:atobuy_vendor_flutter/data/request_model/order_filer_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceFilterController extends GetxController {
  TextEditingController txtOrderId = TextEditingController();
  PaymentModel? selectedPaymentStatus;
  DateTime? filterFromDate;
  DateTime? filterToDate;
  OrderStatus? selectedOrderStatus;
  List<PaymentModel> paymentStatusList = <PaymentModel>[];

  @override
  void onInit() {
    super.onInit();
    setFilterData(listController: Get.find<InvoiceController>());
  }

  void setFilterData({required final InvoiceController listController}) {
    final OrderListRequestModel requestModel = listController.requestModel;
    paymentStatusList = listController.paymentModeList;
    txtOrderId.text = requestModel.orderId ?? '';
    selectedPaymentStatus = requestModel.selectedPaymentStatus;
    selectedOrderStatus = requestModel.selectedOrderStatus;
    filterFromDate = requestModel.filterFromDate;
    filterToDate = requestModel.filterToDate;
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
      selectedOrderStatus: selectedOrderStatus,
      selectedPaymentStatus: selectedPaymentStatus,
      filterFromDate: filterFromDate,
      filterToDate: filterToDate,
      orderId: txtOrderId.text,
    );
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
}
