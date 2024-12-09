import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CommonComingSoon extends StatelessWidget {
  const CommonComingSoon({super.key, required this.title});

  final String title;

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppbarWithBackIconAndTitle(
            title: title.tr,
          ),
          body: Center(
            child: Text(
              'Coming Soon'.tr,
              style: mullerW500.copyWith(
                  fontSize: 20.0, color: AppColors.color2E236C),
            ),
          ),
        ),
      ),
    );
  }
}
