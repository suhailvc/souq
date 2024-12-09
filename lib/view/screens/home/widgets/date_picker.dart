import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomeAccountDatePicker extends StatelessWidget {
  HomeAccountDatePicker(
      {super.key,
      required this.dateRangePickerView,
      required this.onSelectDate,
      this.startDate,
      this.endDate});
  final DateRangePickerView dateRangePickerView;
  final Function(DateRangePickerSelectionChangedArgs) onSelectDate;
  final DateTime? startDate;
  final DateTime? endDate;

  Rx<DateRangePickerSelectionChangedArgs?> selectedRange =
      Rx<DateRangePickerSelectionChangedArgs?>(null);
  Rx<DateRangePickerController> controller = DateRangePickerController().obs;

  @override
  Widget build(final BuildContext context) {
    controller.value.displayDate = startDate;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: SfDateRangePicker(
        maxDate: DateTime.now(),
        view: dateRangePickerView,
        showActionButtons: true,
        confirmText: 'OK'.tr,
        cancelText: 'CANCEL'.tr,
        controller: controller.value,
        initialSelectedRange: PickerDateRange(startDate, endDate),
        backgroundColor: AppColors.white,
        yearCellStyle: DateRangePickerYearCellStyle(
          textStyle:
              mullerW500.copyWith(color: AppColors.color1D1D1D, fontSize: 12),
        ),
        selectionTextStyle:
            mullerW500.copyWith(color: AppColors.white, fontSize: 12),
        selectionColor: AppColors.color3D8FB9,
        headerHeight: 50.0,
        headerStyle: DateRangePickerHeaderStyle(
          backgroundColor: AppColors.white,
          textAlign: TextAlign.center,
          textStyle:
              mullerW500.copyWith(color: AppColors.color1D1D1D, fontSize: 16),
        ),
        monthCellStyle: DateRangePickerMonthCellStyle(
          textStyle:
              mullerW400.copyWith(color: AppColors.color1D1D1D, fontSize: 12),
          todayTextStyle:
              mullerW400.copyWith(color: AppColors.color1D1D1D, fontSize: 12),
        ),
        startRangeSelectionColor: AppColors.color1679AB,
        endRangeSelectionColor: AppColors.color1679AB,
        rangeSelectionColor: AppColors.color1679AB.withOpacity(0.2),
        showNavigationArrow: true,
        allowViewNavigation: false,
        selectionMode: DateRangePickerSelectionMode.range,
        monthViewSettings: DateRangePickerMonthViewSettings(
          viewHeaderStyle: DateRangePickerViewHeaderStyle(
            textStyle:
                mullerW400.copyWith(color: AppColors.color2E236C, fontSize: 14),
          ),
        ),
        todayHighlightColor: AppColors.color1679AB,
        onSelectionChanged: (final DateRangePickerSelectionChangedArgs args) {
          selectedRange.value = args;
        },
        onSubmit: (final Object? object) {
          Get.back();
          if (selectedRange.value != null) {
            onSelectDate.call(selectedRange.value!);
          }
        },
        onCancel: () {
          Get.back();
        },
      ),
    );
  }
}
