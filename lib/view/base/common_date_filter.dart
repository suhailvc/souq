import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CommonDateFilter extends StatelessWidget {
  CommonDateFilter({
    super.key,
    required this.filterFromDate,
    required this.filterToDate,
    required this.onFromDateSelection,
    required this.onToDateSelection,
    this.maxDate,
    this.minDate,
  });

  final DateTime? filterFromDate;
  final DateTime? filterToDate;
  final DateTime? maxDate;
  final DateTime? minDate;
  final Function(DateTime) onFromDateSelection;
  final Function(DateTime) onToDateSelection;

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
            final DateTime? selectedFromDate = await showDatePicker(
              context: context,
              initialDate: filterFromDate ?? DateTime.now(),
              firstDate: minDate ?? DateTime.fromMillisecondsSinceEpoch(0),
              lastDate: maxDate ?? DateTime.now(),
            );
            if (selectedFromDate != null) {
              onFromDateSelection(selectedFromDate);
            }
          },
          child: Container(
            width: (Get.width - 47) / 2,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.color8ABCD5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: <Widget>[
                Gap(8),
                Text(
                  'From'.tr,
                  style: mullerW400.copyWith(
                      color: AppColors.color8ABCD5, fontSize: 12.0),
                ),
                Gap(12),
                VerticalDividerWidget(
                  height: 32,
                  color: AppColors.color8ABCD5,
                ).paddingSymmetric(vertical: 10),
                Gap(5),
                Text(
                  filterFromDate != null
                      ? filterFromDate.formatDDMMYY()
                      : 'DD/MM/YYYY'.tr,
                  style: filterFromDate != null
                      ? mullerW500.copyWith(
                          fontSize: 16,
                          color: AppColors.color171236,
                        )
                      : mullerW400.copyWith(
                          fontSize: 12, color: AppColors.color8ABCD5),
                ),
                Gap(8),
              ],
            ),
          ),
        ),
        Gap(15),
        GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
            final DateTime? selectedToDate = await showDatePicker(
              context: context,
              initialDate: filterToDate ?? (filterFromDate ?? DateTime.now()),
              firstDate: filterFromDate ??
                  (minDate ?? DateTime.fromMillisecondsSinceEpoch(0)),
              lastDate: maxDate ?? DateTime.now(),
            );
            if (selectedToDate != null) {
              onToDateSelection(selectedToDate);
            }
          },
          child: Container(
            width: (Get.width - 47) / 2,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.colorB1D2E3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: <Widget>[
                Gap(8),
                Text(
                  'To'.tr,
                  style: mullerW400.copyWith(
                      color: AppColors.color8ABCD5, fontSize: 12.0),
                ),
                Gap(12),
                VerticalDividerWidget(
                  height: 32,
                  color: AppColors.color8ABCD5,
                ).paddingSymmetric(vertical: 10),
                Gap(5),
                Text(
                  filterToDate != null
                      ? filterToDate.formatDDMMYY()
                      : 'DD/MM/YYYY'.tr,
                  style: filterToDate != null
                      ? mullerW500.copyWith(
                          fontSize: 16,
                          color: AppColors.color171236,
                        )
                      : mullerW400.copyWith(
                          fontSize: 12, color: AppColors.color8ABCD5),
                ),
                Gap(8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
