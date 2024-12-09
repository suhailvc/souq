import 'package:atobuy_vendor_flutter/controller/auth/login_controller.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/otp_pin_field.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/password_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ResetPasswordFormWidget extends StatelessWidget {
  const ResetPasswordFormWidget({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<LoginController>(
        builder: (final LoginController controller) {
      return Form(
        key: controller.resetPasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'otp'.tr,
              style: mullerW500.copyWith(color: AppColors.color6A6982),
            ),
            Gap(10),
            CustomOtpPinField(
                otpPinFieldKey: controller.otpPinFieldKey,
                onSubmit: (final String text) {
                  controller.pinController.text = text;
                },
                onChange: (final String text) {
                  controller.pinController.text = text;
                }),
            Gap(16),
            PasswordWidget(
              title: 'New Password'.tr,
              controller: controller.txtNewPassword,
              isPasswordVisible: controller.isNewPasswordVisible,
              onPasswordVisibility: (final bool isVisible) {
                controller.onNewPasswordVisibility(isVisible);
              },
            ),
            Gap(16),
            PasswordWidget(
              title: 'Confirm Password'.tr,
              controller: controller.txtConfirmPassword,
              isPasswordVisible: controller.isConfirmPasswordVisible,
              onPasswordVisibility: (final bool isVisible) {
                controller.onConfirmPasswordVisibility(isVisible);
              },
            ),
          ],
        ),
      );
    });
  }
}
