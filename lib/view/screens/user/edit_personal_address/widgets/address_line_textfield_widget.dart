import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddressLineTextFieldWidget extends StatelessWidget {
  const AddressLineTextFieldWidget({
    super.key,
    required this.controller,
    required this.isAddressLine1,
    this.textInputType,
  });

  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool isAddressLine1;

  @override
  Widget build(final BuildContext context) {
    return CommonTextField(
      validator: (final String? p0) {
        if (p0?.trim().isEmpty ?? false) {
          return isAddressLine1
              ? 'Please enter address line 1'.tr
              : 'Please enter street'.tr;
        } else {
          return null;
        }
      },
      controller: controller,
      labelText: isAddressLine1 ? 'Address Line 1'.tr : 'Street'.tr,
      keyboardType: textInputType ?? TextInputType.text,
      textInputAction: TextInputAction.next,
      prefixIcon: Row(
        children: <Widget>[
          SvgPicture.asset(
            Assets.svg.icLocation,
          ),
          Gap(12),
          VerticalDividerWidget(
            height: 50,
            color: AppColors.colorDDECF2,
          ),
        ],
      ),
    );
  }
}
