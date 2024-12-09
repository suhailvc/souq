import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductStatusWidget extends StatelessWidget {
  const ProductStatusWidget({
    super.key,
    required this.isActive,
    required this.onChangeStatus,
    this.margin,
    this.padding,
    this.titleFontSize,
  });

  final bool isActive;
  final ValueChanged<bool> onChangeStatus;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? titleFontSize;

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.colorE8EBEC,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Text(
            'Product Status'.tr,
            style: mullerW500.copyWith(
              fontSize: titleFontSize ?? 12,
              color: AppColors.color2E236C,
            ),
          ),
          Spacer(),
          Text(
            isActive ? 'Active'.tr : 'Inactive'.tr,
            style: mullerW500.copyWith(
              fontSize: 12,
              color: AppColors.color2E236C,
            ),
          ),
          Gap(8),
          FlutterSwitch(
            value: isActive,
            onToggle: onChangeStatus,
            height: 18 * 1.3,
            width: 35 * 1.3,
            toggleSize: 10,
            activeColor: AppColors.color2E236C,
            inactiveColor: AppColors.color8DBBBF,
            activeToggleColor: AppColors.color2E236C,
            inactiveToggleColor: AppColors.color8DBBBF,
            showOnOff: false,
            activeSwitchBorder:
                Border.all(color: AppColors.color2E236C, width: 3),
            inactiveSwitchBorder:
                Border.all(color: AppColors.color8DBBBF, width: 3),
          )
        ],
      ),
    );
  }
}
