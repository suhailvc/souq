import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDescFieldWidget extends StatelessWidget {
  const ProductDescFieldWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 232,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.colorB1D2E3,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: CommonTextField(
        labelStyle:
            mullerW400.copyWith(color: AppColors.color8ABCD5, fontSize: 12),
        controller: controller,
        labelText: 'Product Description'.tr,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        maxLines: 10,
        allowLeftRightPadding: false,
        borderColor: Colors.transparent,
      ),
    );
  }
}
