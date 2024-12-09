import 'package:atobuy_vendor_flutter/controller/home_controller.dart';
import 'package:atobuy_vendor_flutter/controller/order/order_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/order_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/common/common_detail_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/driver_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/bottomsheet/complete_order_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/bottomsheet/success_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OrderDetailController extends GetxController {
  OrderDetailController({
    required this.orderRepo,
    required this.sharedPreferenceHelper,
  });
  final SharedPreferenceHelper sharedPreferenceHelper;
  final OrderRepo orderRepo;

  OrderDetailsModel? orderDetails;
  int selectedProductIndex = 0;
  String orderId = '';
  final TextEditingController txtSearchDriver = TextEditingController();
  final TextEditingController txtCancelReason = TextEditingController();

  String searchDriverText = '';

  PagingController<int, Driver> driverListController =
      PagingController<int, Driver>(
          firstPageKey: 1, invisibleItemsThreshold: 1);

  bool isDetailsLoading = true;

  @override
  void onInit() {
    super.onInit();
    manageArguments();
    setPageControllerListener();
  }

  void manageArguments() {
    if (Get.arguments != null) {
      if (Get.arguments['order_id'] != null) {
        orderId = Get.arguments['order_id'];
      }
    }
    if (orderId != '') {
      getOrderDetails(orderId: orderId);
    }
  }

  void setPageControllerListener() {
    driverListController.addPageRequestListener((final int pageKey) {
      getDriverList(page: pageKey);
    });
  }

  Future<void> refreshDriverList() async {
    driverListController.refresh();
  }

  Future<void> getOrderDetails({required final String orderId}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      final Map<String, dynamic> req = <String, dynamic>{
        'is_vendor': true,
        if (sharedPreferenceHelper.selectedStoreId != null)
          'store': sharedPreferenceHelper.selectedStoreId,
      };
      await orderRepo
          .getOrderDetails(
        orderId: orderId,
        param: req,
      )
          .then((final OrderDetailsModel value) {
        Loader.load(false);
        orderDetails = value;
        isDetailsLoading = false;
        update();
      });
    } catch (e) {
      Loader.load(false);
      isDetailsLoading = false;
      update();
    }
  }

  Future<void> getDriverList({required final int page}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      final Map<String, dynamic> queryParameter = <String, dynamic>{
        'page': page,
        if (searchDriverText.trim().isNotNullAndEmpty())
          'search': searchDriverText.trim(),
        'is_vendor': true
      };
      await orderRepo
          .getDriverList(queryParameter: queryParameter)
          .then((final DriverListModel value) {
        if (value.next != null) {
          final int nextPage = page + 1;
          driverListController.appendPage(
              value.results ?? <Driver>[], nextPage);
        } else {
          driverListController.appendLastPage(value.results ?? <Driver>[]);
        }
        update();
      });
    } catch (e) {
      driverListController.error = e;
    }
  }

  Future<void> assignDriver() async {
    final Driver? driver = driverListController.itemList
        ?.firstWhereOrNull((final Driver driver) => driver.isSelected == true);
    if (driver == null) {
      showCustomSnackBar(message: 'Please select driver'.tr);
      return;
    }
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      final Map<String, dynamic> request = <String, dynamic>{
        'driver_id': driver.id,
      };

      Loader.load(true);
      await orderRepo.commonOrderDetailsApi(
          orderId: orderId,
          body: request,
          apiType: OrderDetailsCommonAPIType.assignDriver,
          queryParams: <String, dynamic>{
            'is_vendor': true,
          }).then((final CommonDetailModel value) {
        showCustomSnackBar(isError: false, message: value.detail);
        _refreshDetailsDashboard();
        Loader.load(false);
      });
    } catch (e) {
      Loader.load(false);
    }
  }

  void onSelectDriver(final int index) {
    for (int i = 0;
        i < (driverListController.itemList ?? <Driver>[]).length;
        i++) {
      if (i == index) {
        driverListController.itemList![index].isSelected =
            !(driverListController.itemList![index].isSelected ?? false);
      } else {
        driverListController.itemList![i].isSelected = false;
      }
    }
    update();
  }

  void resetDriverSelection() {
    txtSearchDriver.text = '';
    refreshDriverList();
  }

  Future<bool> acceptRejectOrder({required final bool isAccept}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return false;
      }
      final Map<String, dynamic> request = <String, dynamic>{
        'order_status':
            isAccept ? OrderStatus.processing.name : OrderStatus.rejected.name,
        if (!isAccept) 'cancel_reason': txtCancelReason.text,
      };

      Loader.load(true);
      await orderRepo.commonOrderDetailsApi(
          orderId: orderId,
          body: request,
          apiType: OrderDetailsCommonAPIType.acceptRejectOrder,
          queryParams: <String, dynamic>{
            'is_vendor': true,
          }).then((final CommonDetailModel value) {
        showCustomSnackBar(isError: false, message: value.detail);
        _refreshDetailsDashboard();
        Loader.load(false);
      });
      return true;
    } catch (e) {
      Loader.load(false);
      return false;
    }
  }

  void onTapCompleteOrder() {
    Get.bottomSheet(
      CompleteOrderBottomSheet(
        onTapComplete: () {
          completeOrder();
        },
      ),
    );
  }

  Future<bool> completeOrder() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return false;
      }
      Loader.load(true);
      await orderRepo
          .completeOrder(orderId: orderId, queryParams: <String, dynamic>{
        'is_vendor': true,
      }).then((final CommonDetailModel value) {
        showCustomSnackBar(isError: false, message: value.detail);
        _refreshDetailsDashboard();
        Loader.load(false);
      });
      return true;
    } catch (e) {
      Loader.load(false);
      return false;
    }
  }

  void onTapConfirmRejectOrder() {
    if (txtCancelReason.text.isEmpty) {
      showCustomSnackBar(message: 'Please enter cancellation reason.'.tr);
      return;
    }
    acceptRejectOrder(isAccept: false).then((final bool isRejected) {
      if (isRejected) {
        SuccessBottomSheet.show(
          title: 'Order cancelled successfully.'.tr,
          onTapContinue: () {
            Get.back();
          },
        );
      } else {
        Get.back();
      }
    });
  }

  void onSubmitSearchDriver(final String value) {
    searchDriverText = value;
    onChangeSearchDriver(value);
    refreshDriverList();
  }

  void onChangeSearchDriver(final String value) {
    txtSearchDriver.text = value;
    update();
  }

  void _refreshDetailsDashboard() {
    if (orderId.isNotNullAndEmpty()) {
      getOrderDetails(orderId: orderId);
      Get.find<OrderListController>().refreshOrderList();
      Get.find<HomeController>().getOrderStatistics();
    }
  }
}
