import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderSortByListCell extends StatelessWidget {
  OrderSortByListCell(
      {super.key,
      required this.selectionSortByOption,
      required this.index,
      required this.onTap});

  SortOptions selectionSortByOption;
  int index;
  Function(SortOptions selectedOption) onTap;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(SortOptions.values[index]);
      },
      child: Row(
        children: <Widget>[
          (selectionSortByOption == SortOptions.values[index])
              ? SvgPicture.asset(Assets.svg.icRadioButtonSelected)
              : SvgPicture.asset(Assets.svg.icRadioButton),
          Gap(12),
          Text(
            SortOptions.values[index].message.tr,
            style: (selectionSortByOption == SortOptions.values[index])
                ? mullerW500.copyWith(
                    fontSize: 16, color: AppColors.color171236)
                : mullerW400.copyWith(
                    fontSize: 16, color: AppColors.color12658E),
          ),
        ],
      ).paddingSymmetric(vertical: 12, horizontal: 16),
    );
  }
}
