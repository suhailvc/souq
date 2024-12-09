import 'package:atobuy_vendor_flutter/controller/auth/login_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/login/widgets/error_info_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/reset_password/widget/resend_otp_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/reset_password/widget/reset_password_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
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
        child: Scaffold(
          body: SafeArea(
            child: GetBuilder<LoginController>(
                initState: (final GetBuilderState<LoginController> state) {
              Get.find<LoginController>().txtNewPassword.text = '';
              Get.find<LoginController>().txtConfirmPassword.text = '';
              Get.find<LoginController>()
                  .otpVerificationController
                  .resetTimer();
            }, builder: (final LoginController controller) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gap(34),
                    SvgPicture.asset(Assets.svg.icLogoColored),
                    Gap(51.87),
                    Text(
                      'Reset Password'.tr,
                      style: mullerW700.copyWith(
                          fontSize: 28, color: AppColors.color2E236C),
                    ),
                    Gap(9),
                    Text(
                      'Please enter OTP and new password'.tr,
                      style: mullerW400.copyWith(
                          fontSize: 16, color: AppColors.color6A6982),
                    ),
                    Gap(controller.resetError != null ? 24 : 0),
                    controller.resetError != null
                        ? ErrorInfoView(
                            message: controller.resetError!,
                          )
                        : SizedBox(),
                    Gap(16),
                    ResetPasswordFormWidget(),
                    Gap(30),
                    CommonButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controller.callResetPasswordAPI();
                      },
                      title: 'Submit'.tr,
                    ),
                    Gap(30),
                    ResendOTPWidget(
                      onTapResend: () {
                        controller.resendForgotPassword();
                      },
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),
              );
            }),
          ),
        ),
      ),
    );
  }
}
