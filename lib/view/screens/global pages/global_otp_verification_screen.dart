import 'package:atobuy_vendor_flutter/controller/global_otp_verification_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/otp_pin_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class GlobalOTPVerificationScreen extends StatelessWidget {
  const GlobalOTPVerificationScreen({
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
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: GetBuilder<OTPVerificationController>(initState:
                (final GetBuilderState<OTPVerificationController> state) {
              Get.find<OTPVerificationController>().pinController.text = '';
              Get.find<OTPVerificationController>().manageArguments();
              Get.find<OTPVerificationController>().resetTimer();
            }, builder: (final OTPVerificationController controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gap(50.74),
                    SvgPicture.asset(Assets.svg.icLogoColored),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Gap(50),
                            Text(
                              'Enter your OTP'.tr,
                              style: mullerW700.copyWith(
                                  fontSize: 28, color: AppColors.color1D1D1D),
                            ),
                            Gap(10),
                            Text(
                              'Please Enter the OTP'.tr,
                              style: mullerW400.copyWith(
                                  fontSize: 16, color: AppColors.color757474),
                            ),
                            Gap(26),
                            Row(
                              children: <Widget>[
                                Text(
                                  controller.mobileNumber,
                                  style: mullerW500.copyWith(
                                      fontSize: 16,
                                      color: AppColors.color1679AB),
                                ),
                                Gap(10.0),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'Change'.tr,
                                    style: mullerW500.copyWith(
                                        color: AppColors.color1D1D1D),
                                  ),
                                ),
                              ],
                            ),
                            Gap(20),
                            CustomOtpPinField(
                                otpPinFieldKey: controller.otpPinFieldKey,
                                onSubmit: (final String text) {
                                  controller.pinController.text = text;
                                },
                                onChange: (final String text) {
                                  controller.pinController.text = text;
                                }),
                            Gap(30),
                            CommonButton(
                              onTap: () {
                                if (controller.pinController.text.length < 6) {
                                  showCustomSnackBar(
                                      message: 'Please enter valid OTP.'.tr);
                                  return;
                                }
                                controller.onTapSubmit();
                              },
                              title: 'Submit'.tr,
                            ),
                            Gap(50),
                            Visibility(
                              visible: true,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  AnimatedCrossFade(
                                    crossFadeState:
                                        controller.isResendOTPVisible
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                    duration: const Duration(milliseconds: 200),
                                    firstChild: Text(
                                      'Resend OTP in'.tr,
                                      style: mullerW400.copyWith(
                                          color: AppColors.color6A6982),
                                    ),
                                    secondChild: GestureDetector(
                                      onTap: () {
                                        controller
                                            .resendOTP(controller.mobileNumber);
                                        controller.resetTimer();
                                      },
                                      child: Text(
                                        'Resend'.tr,
                                        style: mullerW400.copyWith(
                                            color: AppColors.color6A6982),
                                      ),
                                    ),
                                  ),
                                  Gap(5),
                                  Visibility(
                                    visible: controller.isResendOTPVisible
                                        ? false
                                        : true,
                                    child: CountdownTimer(
                                      controller:
                                          controller.countdownController,
                                      widgetBuilder: (final BuildContext
                                              context,
                                          final CurrentRemainingTime? time) {
                                        return Text(
                                            '${time?.sec.toString() ?? ''}s');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
