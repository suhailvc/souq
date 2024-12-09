import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackToLoginWidget extends StatelessWidget {
  const BackToLoginWidget({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(children: <InlineSpan>[
          TextSpan(
            text: 'Go Back to'.tr,
            style:
                mullerW400.copyWith(fontSize: 16, color: AppColors.color6A6982),
          ),
          const TextSpan(text: '  '),
          TextSpan(
              text: 'Login'.tr,
              style: mullerW500.copyWith(
                  fontSize: 16, color: AppColors.color2E236C),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.back();
                }),
        ]),
      ),
    );
  }
}
