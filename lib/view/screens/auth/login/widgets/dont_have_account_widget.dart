import 'package:atobuy_vendor_flutter/controller/auth/login_controller.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DontHaveAccountWidget extends StatelessWidget {
  const DontHaveAccountWidget({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<LoginController>(
        builder: (final LoginController controller) {
      return Center(
        child: RichText(
          text: TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: 'Don’t have an account?'.tr,
                style: mullerW400.copyWith(
                    fontSize: 16, color: AppColors.color6A6982),
              ),
              const TextSpan(text: '  '),
              TextSpan(
                text: 'Sign Up'.tr,
                style: mullerW500.copyWith(
                    fontSize: 16, color: AppColors.color2E236C),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    controller.resetFormError();
                    Get.toNamed(RouteHelper.signUp);
                  },
              ),
            ],
          ),
        ),
      );
    });
  }
}
