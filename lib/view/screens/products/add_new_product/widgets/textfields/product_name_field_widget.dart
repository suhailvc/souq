import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductNameTextFieldWidget extends StatelessWidget {
  const ProductNameTextFieldWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(final BuildContext context) {
    return CommonTextField(
      validator: (final String? p0) {
        if (p0?.trim().isEmpty ?? false) {
          return 'Please enter product name.'.tr;
        } else {
          return null;
        }
      },
      labelStyle:
          mullerW400.copyWith(color: AppColors.color8ABCD5, fontSize: 12),
      allowLeftRightPadding: false,
      controller: controller,
      labelText: 'Product Name'.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
    );
  }
}
