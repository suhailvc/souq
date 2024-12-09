import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/confirm_password_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/password_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ChangePasswordWidget extends StatelessWidget {
  const ChangePasswordWidget({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<UserProfileController>(
        builder: (final UserProfileController controller) {
      return Form(
        key: controller.changePasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Gap(10),
            PasswordWidget(
              title: 'Old Password'.tr,
              controller: controller.txtOldPassword,
              isPasswordVisible: controller.isOldPasswordVisible,
              onPasswordVisibility: (final bool isVisible) {
                controller.onOldPasswordVisibility(isVisible);
              },
            ),
            Gap(16),
            PasswordWidget(
              title: 'New Password'.tr,
              controller: controller.txtNewPassword,
              isPasswordVisible: controller.isNewPasswordVisible,
              onPasswordVisibility: (final bool isVisible) {
                controller.onNewPasswordVisibility(isVisible);
              },
              onChange: (final String value) {
                controller.update();
              },
            ),
            Gap(16),
            ConfirmPasswordWidget(
                controller: controller.txtConfirmPassword,
                password: controller.txtNewPassword.text,
                isPasswordVisible: controller.isConfirmPasswordVisible,
                onPasswordVisibility: (final bool isVisible) {
                  controller.onConfirmPasswordVisibility(isVisible);
                }),
          ],
        ),
      );
    });
  }
}
