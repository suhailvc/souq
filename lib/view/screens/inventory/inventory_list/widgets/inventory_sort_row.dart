import 'package:atobuy_vendor_flutter/data/response_models/inventory/inventory_sort_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InventorySortRow extends StatelessWidget {
  const InventorySortRow(
      {super.key, required this.sortBy, required this.onTapSelect});

  final SortModel sortBy;
  final Function(SortModel) onTapSelect;
  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapSelect.call(sortBy);
      },
      child: Row(
        children: <Widget>[
          Icon(
            sortBy.isSelected
                ? Icons.radio_button_checked_outlined
                : Icons.radio_button_off_outlined,
            color: sortBy.isSelected
                ? AppColors.color2E236C
                : AppColors.color12658E,
          ),
          Gap(12.0),
          Text(
            sortBy.title,
            style: sortBy.isSelected
                ? mullerW500.copyWith(
                    fontSize: 16, color: AppColors.color171236)
                : mullerW400.copyWith(
                    fontSize: 16, color: AppColors.color12658E),
          )
        ],
      ).paddingSymmetric(vertical: 16, horizontal: 16.0),
    );
  }
}
