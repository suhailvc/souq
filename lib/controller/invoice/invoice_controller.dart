import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/invoice_repo.dart';
import 'package:atobuy_vendor_flutter/data/request_model/order_filer_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/inventory/inventory_sort_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/invoice/invoice_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/invoice/invoice_list/invoice_filter_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/invoice/invoice_list/widgets/bottomsheets/invoice_sort_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvoiceController extends GetxController {
  InvoiceController(
      {required this.invoiceRepo,
      required this.globalController,
      required this.sharedPref});
  final InvoiceRepo invoiceRepo;
  final GlobalController globalController;
  final SharedPreferenceHelper sharedPref;

  TextEditingController txtSearchInvoice = TextEditingController();
  PagingController<int, Invoice> invoiceListController =
      PagingController<int, Invoice>(
          firstPageKey: 1, invisibleItemsThreshold: 1);

  Invoice? selectedInvoice;
  OrderListRequestModel requestModel = OrderListRequestModel();
  List<PaymentModel> paymentModeList = <PaymentModel>[];
  List<SortModel> arrSortBy = <SortModel>[
    SortModel(
      title: SortOptions.newestFirst.message.tr,
      value: SortOptions.newestFirst.inventoryValue,
      isSelected: true,
    ),
    SortModel(
      title: SortOptions.oldestFirst.message.tr,
      value: SortOptions.oldestFirst.inventoryValue,
      isSelected: false,
    ),
  ];
  int itemCounts = 0;

  @override
  void onInit() {
    super.onInit();
    setPageControllerListener();
    getPaymentModes();
  }

  Future<void> getPaymentModes() async {
    if (globalController.paymentModeList.isEmpty) {
      await globalController.getPaymentMethods();
    }
    paymentModeList = globalController.paymentModeList;
  }

  void setPageControllerListener() {
    invoiceListController.addPageRequestListener((final int pageKey) {
      getInvoiceList(page: pageKey);
    });
  }

  Future<void> refreshInvoiceList() async {
    invoiceListController.refresh();
  }

  void onTapInvoice(final Invoice invoice) {
    FocusScope.of(Get.context!).unfocus();
    selectedInvoice = invoice;
    update();
    Get.toNamed(RouteHelper.invoiceDetails);
  }

  void onTapApplyFilter(final OrderListRequestModel request) {
    final SortOptions sort = requestModel.sortSelectedValue;
    requestModel = request;
    requestModel.sortSelectedValue = sort;

    refreshInvoiceList();
  }

  void resetFilter() {
    final SortOptions sort = requestModel.sortSelectedValue;
    requestModel = OrderListRequestModel(sortSelectedValue: sort);
    update();
  }

  void onTapSortBy() {
    Get.bottomSheet(
      InvoiceSortByBottomSheet(
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

  void onSelectSortType(final SortOptions sortBy) {
    requestModel.sortSelectedValue = sortBy;
    refreshInvoiceList();
    update();
  }

  void submitSearchText({required final String orderId}) {
    txtSearchInvoice.text = orderId;
    requestModel.orderId = orderId;
    update();
    refreshInvoiceList();
  }

  void changeSearchText({required final String orderId}) {
    txtSearchInvoice.text = orderId;
    update();
  }

  Map<String, dynamic> getFilterAndSortParams({required final int page}) {
    return <String, dynamic>{
      'page': page,
      'is_vendor': true,
      if (sharedPref.selectedStoreId != null)
        'store': sharedPref.selectedStoreId,
      if ((requestModel.orderId ?? '').trim().isNotEmpty)
        'search': '${requestModel.orderId!.trim()}',
      'ordering': requestModel.sortSelectedValue.orderValue,
      if (requestModel.selectedPaymentStatus != null)
        'payment_mode': '${requestModel.selectedPaymentStatus?.key}',
      if (requestModel.selectedOrderStatus != null)
        'status': '${requestModel.selectedOrderStatus?.value}',
      if (requestModel.filterFromDate != null)
        'from_invoice_date': '${requestModel.filterFromDate?.formatYYYYMMDD()}',
      if (requestModel.filterToDate != null)
        'to_invoice_date': '${requestModel.filterToDate.formatYYYYMMDD()}',
    };
  }

  Future<void> getInvoiceList({required final int page}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      itemCounts = 0;
      update();
      final Map<String, dynamic> queryParams =
          getFilterAndSortParams(page: page);

      final InvoiceListModel data =
          await invoiceRepo.getInvoiceList(queryParams: queryParams);
      itemCounts = data.count ?? 0;
      if (data.next != null) {
        final int nextPage = page + 1;
        invoiceListController.appendPage(data.results ?? <Invoice>[], nextPage);
      } else {
        invoiceListController.appendLastPage(data.results ?? <Invoice>[]);
      }
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onTapFilter() {
    Get.bottomSheet(
      Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: InvoiceFilterScreen()),
    );
  }
}
