import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/validation_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ConfirmPasswordWidget extends StatelessWidget {
  const ConfirmPasswordWidget(
      {super.key,
      required this.controller,
      required this.isPasswordVisible,
      required this.password,
      required this.onPasswordVisibility});

  final TextEditingController controller;
  final bool isPasswordVisible;
  final String password;
  final Function(bool) onPasswordVisibility;

  @override
  Widget build(final BuildContext context) {
    return CommonTextField(
      validator: (final String? confirmPassword) {
        if (!(confirmPassword ?? '').isValidPassword()) {
          return 'Password must contains at least one upper case,\none lower case, one digit, one special character\nand it should be 8 character long'
              .tr;
        } else if (password != (confirmPassword ?? '')) {
          return 'Password doesn\'t match'.tr;
        } else {
          return null;
        }
      },
      controller: controller,
      textInputAction: TextInputAction.done,
      labelText: 'Confirm Password'.tr,
      isPasswordVisible: isPasswordVisible,
      prefixIcon: Row(
        children: <Widget>[
          SvgPicture.asset(
            Assets.svg.icLock,
          ),
          Gap(12),
          VerticalDividerWidget(
            height: 50,
            color: AppColors.colorDDECF2,
          ),
        ],
      ),
      suffixIcon: GestureDetector(
        onTap: () {
          onPasswordVisibility.call(!isPasswordVisible);
        },
        child: Icon(
          !isPasswordVisible
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.color8ABCD5,
        ),
      ),
    );
  }
}
