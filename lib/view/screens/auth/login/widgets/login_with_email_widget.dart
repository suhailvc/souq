import 'package:atobuy_vendor_flutter/controller/auth/login_controller.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/email_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/password_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<LoginController>(
        builder: (final LoginController controller) {
      return Form(
        key: controller.loginWithEmailFormKey,
        child: Column(
          children: <Widget>[
            EmailWidget(controller: controller.txtEmail),
            Gap(16),
            PasswordWidget(
              controller: controller.txtPassword,
              isPasswordVisible: controller.isPasswordVisible,
              onPasswordVisibility: (final bool isVisible) {
                controller.onPasswordVisibility(isVisible);
              },
              textInputAction: TextInputAction.done,
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    controller.isRememberMeTicked =
                        !controller.isRememberMeTicked;
                    controller.update();
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        controller.isRememberMeTicked
                            ? Icons.check_box_rounded
                            : Icons.check_box_outline_blank_rounded,
                        color: AppColors.color2E236C,
                      ),
                      Gap(8),
                      Text(
                        'Remember me'.tr,
                        style:
                            mullerW500.copyWith(color: AppColors.color5F6E85),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.resetFormError();
                    Get.toNamed(RouteHelper.forgotPassword);
                  },
                  child: Text(
                    'Forgot Password?'.tr,
                    style: mullerW500.copyWith(color: AppColors.color2E236C),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
