import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderBillingInfo extends StatelessWidget {
  const OrderBillingInfo({
    super.key,
    required this.billingAddress,
    required this.vendorName,
  });
  final OrderBillingAddress? billingAddress;
  final String? vendorName;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(16.0),
        Text(
          'Billed To'.tr,
          style:
              mullerW400.copyWith(fontSize: 12, color: AppColors.color12658E),
        ).paddingSymmetric(horizontal: 5),
        Gap(8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: AppColors.colorD0E4EE.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: vendorName.isNotNullAndEmpty(),
                child: Text(
                  vendorName ?? '',
                  style: mullerW500.copyWith(color: AppColors.color171236),
                ),
              ),
              Gap(vendorName.isNotNullAndEmpty() ? 11.0 : 0),
              Text(
                billingAddress?.getFullAddress() ?? '',
                style: mullerW400.copyWith(
                    color: AppColors.color677A81, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
