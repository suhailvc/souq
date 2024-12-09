import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TotalResultFoundWidget extends StatelessWidget {
  const TotalResultFoundWidget({super.key, required this.itemCounts});

  final int itemCounts;
  @override
  Widget build(final BuildContext context) {
    return Visibility(
      visible: itemCounts > 0,
      child: Text(
        '${itemCounts} ${'Results found'.tr}',
        style: mullerW400.copyWith(color: AppColors.color757474, fontSize: 12),
      ).paddingSymmetric(horizontal: 16.0),
    );
  }
}
