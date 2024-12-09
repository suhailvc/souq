import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    String? message;
    if (Get.arguments != null) {
      message = Get.arguments[AppConstants.successArgumentKey] ??
          'Details Updated'.tr;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          SvgPicture.asset(Assets.svg.icAccountCreated),
          Gap(40),
          Text(
            message ?? 'Details Updated'.tr,
            textAlign: TextAlign.center,
            style:
                mullerW700.copyWith(fontSize: 28, color: AppColors.color2E236C),
          ),
          Gap(68),
          CommonButton(
            onTap: () {
              Get.offAllNamed(
                (Get.find<SharedPreferenceHelper>().user?.vendorStoreExist ??
                        false)
                    ? RouteHelper.home
                    : RouteHelper.shop,
              );
            },
            title: 'Continue To Dashboard'.tr,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
