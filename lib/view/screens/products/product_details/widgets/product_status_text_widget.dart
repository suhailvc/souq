import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:flutter/material.dart';

class ProductStatusTextWidget extends StatelessWidget {
  const ProductStatusTextWidget({
    super.key,
    required this.status,
  });

  final ProductApprovalStatus? status;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Utility.getProductStatusColor(status?.key ?? ''),
      ),
      child: Text(
        status?.title ?? '',
        style: mullerW500.copyWith(
          color: AppColors.white,
          fontSize: 11,
          height: 1,
        ),
      ),
    );
  }
}
