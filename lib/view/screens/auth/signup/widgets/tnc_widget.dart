import 'package:atobuy_vendor_flutter/controller/auth/signup_controller.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TnCWidget extends StatelessWidget {
  const TnCWidget({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<SignupController>(
        builder: (final SignupController signupController) {
      return Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              signupController.isTnCTicked = !signupController.isTnCTicked;
              signupController.update();
            },
            icon: Icon(
              signupController.isTnCTicked
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: AppColors.color2E236C,
            ),
          ),
          Gap(8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: '${'iAgree'.tr} SOUQ NO 1’s ',
                    style: mullerW400.copyWith(color: AppColors.color5F6E85),
                  ),
                  TextSpan(
                    text: 'tnc'.tr,
                    style: mullerW500.copyWith(color: AppColors.color5F6E85),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(RouteHelper.staticPageDetail,
                            arguments: <String, StaticPages>{
                              'page': StaticPages.termsAndCondition
                            });
                      },
                  ),
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
