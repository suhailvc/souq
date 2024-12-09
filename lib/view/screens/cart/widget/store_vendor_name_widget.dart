import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StoreVendorNameWidget extends StatelessWidget {
  StoreVendorNameWidget({required this.storeName, required this.vendorName});
  final String? storeName;
  final String? vendorName;
  @override
  Widget build(final BuildContext context) {
    return Visibility(
        visible: vendorName.isNotNullAndEmpty(),
        child: Row(
          children: <Widget>[
            Text(
              storeName ?? '',
              style: mullerW500.copyWith(
                  fontSize: 12, color: AppColors.color1679AB),
            ),
            Gap(storeName.isNotNullAndEmpty() ? 10.0 : 0),
            Text(
              _getVendorName(),
              style: mullerW500.copyWith(
                  fontSize: 12, color: AppColors.color677A81),
            ),
          ],
        ).paddingOnly(top: 10, left: 14, right: 14));
  }

  String _getVendorName() {
    return '${storeName.isNotNullAndEmpty() ? '( ' : ''} ${vendorName ?? '-'}${storeName.isNotNullAndEmpty() ? ' )' : ''}';
  }
}
