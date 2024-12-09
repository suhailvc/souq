import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/order_repo.dart';
import 'package:atobuy_vendor_flutter/data/request_model/order_filer_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/order_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_filter_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/parsing.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_list/widgets/bottomsheet/order_more_options_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_list/widgets/bottomsheet/order_sort_by_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OrderListController extends GetxController {
  OrderListController({
    required this.globalController,
    required this.orderRepo,
    required this.sharedPreferenceHelper,
  });
  final OrderRepo orderRepo;
  final GlobalController globalController;
  final SharedPreferenceHelper sharedPreferenceHelper;
  final TextEditingController searchOrderByName = TextEditingController();

  PriceRangeData? priceRangeData;
  double minPrice = 0.0;
  double maxPrice = 1.0;
  RangeValues rangeValues = RangeValues(0.0, 1.0);

  OrderListRequestModel requestModel = OrderListRequestModel();
  List<PaymentModel> paymentModeList = <PaymentModel>[];
  String searchText = '';
  int itemCounts = 0;

  PagingController<int, OrderDetailsModel> orderListController =
      PagingController<int, OrderDetailsModel>(
          firstPageKey: 1, invisibleItemsThreshold: 1);
  @override
  void onInit() {
    super.onInit();
    resetData();
  }

  void resetData() {
    priceRangeData = null;
    minPrice = 0.0;
    maxPrice = 1.0;
    if (globalController.priceRangeData == null ||
        globalController.categoryList.isEmpty) {
      globalController.getProductFilter();
    }
    if (globalController.paymentModeList.isEmpty) {
      globalController.getPaymentMethods();
    }
    resetFilter();
    setFilterData();
    setPageControllerListener();
  }

  void setPageControllerListener() {
    orderListController.addPageRequestListener((final int pageKey) {
      getOrderList(page: pageKey);
    });
  }

  Future<void> refreshOrderList() async {
    orderListController.refresh();
  }

  Map<String, dynamic> getFilterAndSortParams({required final int page}) {
    return <String, dynamic>{
      'is_vendor': true,
      'page': page,
      if (sharedPreferenceHelper.selectedStoreId != null)
        'store': sharedPreferenceHelper.selectedStoreId,
      if ((requestModel.orderId ?? '').trim().isNotEmpty)
        'order_id': '${requestModel.orderId!.trim()}',
      'ordering': requestModel.sortSelectedValue.orderValue,
      if (requestModel.selectedPaymentStatus != null)
        'payment_mode': '${requestModel.selectedPaymentStatus?.key}',
      if (requestModel.selectedOrderStatus != null)
        'status': '${requestModel.selectedOrderStatus?.value}',
      if (requestModel.minPrice != null)
        'total_min': '${requestModel.minPrice}',
      if (requestModel.maxPrice != null)
        'total_max': '${requestModel.maxPrice}',
      if (requestModel.filterFromDate != null)
        'from_order_date': '${requestModel.filterFromDate.formatYYYYMMDD()}',
      if (requestModel.filterToDate != null)
        'to_order_date': '${requestModel.filterToDate.formatYYYYMMDD()}',
      if (searchText.trim().isNotEmpty) 'search': searchText.trim()
    };
  }

  void setFilterData() {
    priceRangeData = globalController.priceRangeData;
    minPrice = Parsing.doubleFrom(priceRangeData?.totalMinPrice ?? '0.0');
    maxPrice = Parsing.doubleFrom(priceRangeData?.totalMaxPrice ?? '0.0');
    rangeValues = RangeValues(minPrice, maxPrice);
    update();
  }

  void resetFilter() {
    priceRangeData = globalController.priceRangeData;
    paymentModeList = globalController.paymentModeList;
    rangeValues = RangeValues(minPrice, maxPrice);
    final SortOptions sort = requestModel.sortSelectedValue;
    requestModel = OrderListRequestModel(sortSelectedValue: sort);
    rangeValues = rangeValues;
    update();
  }

  void onTapApplyFilter(final OrderListRequestModel request) {
    final SortOptions sort = requestModel.sortSelectedValue;
    requestModel = request;
    requestModel.sortSelectedValue = sort;

    if (requestModel.minPrice == null) {
      showCustomSnackBar(
          title: 'Error', message: 'Min price cannot be blank.'.tr);
      return;
    }
    if (Parsing.doubleFrom((requestModel.minPrice ?? '0')) >=
        Parsing.doubleFrom(requestModel.maxPrice ?? '0')) {
      showCustomSnackBar(
          title: 'Error',
          message:
              'Min value should not be greater than or equal to the max value'
                  .tr);
      return;
    }
    if (requestModel.maxPrice == null) {
      showCustomSnackBar(
          title: 'Error', message: 'Max price cannot be blank.'.tr);
      return;
    }
    setPriceValue(RangeValues(Parsing.doubleFrom(requestModel.minPrice ?? '0'),
        Parsing.doubleFrom(requestModel.maxPrice ?? '0')));
    refreshOrderList();
  }

  void setPriceValue(final RangeValues value) {
    rangeValues = value;
    requestModel.minPrice = rangeValues.start;
    requestModel.maxPrice = rangeValues.end;
    update();
  }

  void sortOrderList(final SortOptions selectedOption) {
    requestModel.sortSelectedValue = selectedOption;
    update();
  }

  Future<void> getOrderList({required final int page}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      itemCounts = 0;
      update();
      await orderRepo
          .getOrderList(
        params: getFilterAndSortParams(page: page),
      )
          .then((final OrderListModel value) {
        itemCounts = value.count ?? 0;
        if (value.next != null) {
          final int nextPage = page + 1;
          orderListController.appendPage(
              value.results ?? <OrderDetailsModel>[], nextPage);
        } else {
          orderListController
              .appendLastPage(value.results ?? <OrderDetailsModel>[]);
        }
        update();
      });
    } catch (e) {
      orderListController.error = e;
    }
  }

  void onSelectSortType(final SortOptions sortBy) {
    requestModel.sortSelectedValue = sortBy;
    update();
    refreshOrderList();
  }

  void onChangeSearchOrderByNameField({required final String value}) {
    searchOrderByName.text = value;
    update();
  }

  void onClearSearchText() {
    onChangeSearchOrderByNameField(value: '');
    searchText = '';
    update();
    refreshOrderList();
  }

  void onTapMore(final OrderDetailsModel order) {
    Get.bottomSheet(
      OrderMoreOptionsBottomSheet(
        onTapDownloadInvoice: () {
          globalController.downloadInvoice(
              order.invoiceUrl ?? '', order.orderId ?? '');
        },
      ),
      barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
    );
  }

  void onTapSortBy() {
    FocusScope.of(Get.context!).unfocus();
    Get.bottomSheet(
      OrderSortByBottomSheet(
        sortSelectedValue: requestModel.sortSelectedValue,
        onApplySort: (final SortOptions option) {
          onSelectSortType(option);
        },
        onResetSortResult: (final SortOptions option) {
          onSelectSortType(SortOptions.newestFirst);
        },
      ),
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
    );
  }

  void onSubmitSearchText(final String value) {
    FocusScope.of(Get.context!).unfocus();
    searchText = value;
    onChangeSearchText(value);
    refreshOrderList();
  }

  void onChangeSearchText(final String value) {
    searchOrderByName.text = value;
    update();
  }
}
