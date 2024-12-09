import 'package:atobuy_vendor_flutter/data/repository/home_repo.dart';
import 'package:atobuy_vendor_flutter/data/request_model/order_stats_req_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/home/order_stats_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomeController extends GetxController implements GetxService {
  HomeController({
    required this.homeRepo,
    required this.sharedPreferenceHelper,
  });

  final HomeRepo homeRepo;
  final SharedPreferenceHelper sharedPreferenceHelper;
  OrderStatsReqModel filterModel = OrderStatsReqModel();

  OrderStatsModel? orderStatistics;

  @override
  void onInit() {
    super.onInit();
    filterModel.startDate = DateTime.now();
    filterModel.endDate = DateTime.now();
    filterModel.strSelectedDate = filterModel.startDate.dateTimeVariable() ??
        filterModel.startDate.formatDDMMMYYYY();
  }

  void initialise() {
    if (Get.arguments != null) {
      if (Get.arguments['isLogin'] != null) {
        onInit();
      }
    }
    getOrderStatistics();
    filterModel.manageSelectedDates(
        startDate: filterModel.startDate, endDate: filterModel.endDate);
  }

  void onSelectDate({required final DateRangePickerSelectionChangedArgs args}) {
    if (args.value is PickerDateRange) {
      filterModel.startDate = args.value.startDate;
      filterModel.endDate = args.value.endDate ?? args.value.startDate;

      filterModel.manageSelectedDates(
          startDate: args.value.startDate,
          endDate: args.value.endDate ?? args.value.startDate);
      getOrderStatistics();
      update();
    }
  }

  Future<void> getOrderStatistics() async {
    if (!await ConnectionUtils.isNetworkConnected()) {
      showCustomSnackBar(message: MessageConstant.networkError.tr);
      return;
    }
    try {
      final Map<String, dynamic> params = <String, dynamic>{
        'start_date': filterModel.startDate.formatYYYYMMDD(),
        'end_date': filterModel.endDate.formatYYYYMMDD(),
        if (sharedPreferenceHelper.selectedStoreId != null)
          'store': sharedPreferenceHelper.selectedStoreId,
      };
      orderStatistics = await homeRepo.getOrderStatistics(params: params);
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String defaultPrice() {
    return '0.00 ${AppConstants.defaultCurrency}';
  }
}
