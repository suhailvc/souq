import 'package:atobuy_vendor_flutter/controller/auth/signup_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AccountCreatedScreen extends StatelessWidget {
  const AccountCreatedScreen({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: Scaffold(
        body: GetBuilder<SignupController>(
            builder: (final SignupController signupController) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Gap(40),
                  SvgPicture.asset(Assets.svg.icLogoColored),
                  Spacer(),
                  SvgPicture.asset(
                    Assets.svg.icAccountCreated,
                    width: 120,
                    height: 120,
                  ),
                  Gap(20),
                  Text(
                    'Account Created Successfully'.tr,
                    textAlign: TextAlign.center,
                    style: mullerW700.copyWith(
                        fontSize: 28, color: AppColors.color1D1D1D),
                  ),
                  Gap(26),
                  CommonButton(
                    onTap: () {
                      Get.offAllNamed(RouteHelper.shop);
                    },
                    title: 'Continue To Dashboard'.tr,
                  ),
                  Spacer(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
