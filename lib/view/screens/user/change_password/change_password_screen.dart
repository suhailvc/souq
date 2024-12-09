import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/change_password/widget/change_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<UserProfileController>(
            builder: (final UserProfileController controller) {
          return Scaffold(
            appBar: AppbarWithBackIconAndTitle(
              onBackPress: () {
                controller.resetChangePasswordFields();
                Get.back();
              },
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gap(34),
                    SvgPicture.asset(Assets.svg.icLogoColored),
                    Gap(51.87),
                    Text(
                      'Change Password'.tr,
                      style: mullerW700.copyWith(
                          fontSize: 28, color: AppColors.color1D1D1D),
                    ),
                    Gap(9),
                    ChangePasswordWidget(),
                    Gap(30),
                    CommonButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controller.changePasswordApiCall();
                      },
                      title: 'Submit'.tr,
                    ),
                    Gap(30),
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),
            ),
          );
        }),
      ),
    );
  }
}
