import 'package:atobuy_vendor_flutter/helper/regex_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderMinQtyFieldWidget extends StatelessWidget {
  const OrderMinQtyFieldWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(final BuildContext context) {
    return CommonTextField(
      validator: (final String? p0) {
        if (p0?.trim().isEmpty ?? false) {
          return 'Please enter minimum order quantity.'.tr;
        } else {
          return null;
        }
      },
      inputFormatter: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegexHelper.regexDecimal),
      ],
      labelStyle:
          mullerW400.copyWith(color: AppColors.color8ABCD5, fontSize: 12),
      controller: controller,
      allowLeftRightPadding: false,
      labelText: 'Minimum Order Quantity'.tr,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
    );
  }
}
