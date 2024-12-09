import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/otp_pin_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditProfileVerifyOtpScreen extends StatelessWidget {
  const EditProfileVerifyOtpScreen({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GetBuilder<UserProfileController>(
          builder: (final UserProfileController controller) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppbarWithBackIconAndTitle(
              onBackPress: () {
                controller.otpPin = '';
                Get.back();
              },
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gap(34),
                    SvgPicture.asset(Assets.svg.icLogoColored),
                    Gap(50),
                    Text(
                      'Enter your OTP'.tr,
                      style: mullerW700.copyWith(
                          fontSize: 28, color: AppColors.color2E236C),
                    ),
                    Gap(10),
                    Text(
                      'Please Enter the OTP'.tr,
                      style: mullerW400.copyWith(
                          fontSize: 16, color: AppColors.color6A6982),
                    ),
                    Gap(26),
                    Row(
                      children: <Widget>[
                        Text(
                          controller.getChangeType() ==
                                  EditEmailOrPhone.mobile.name
                              ? controller.mobileNumber
                              : controller.txtEmailEc.text.trim(),
                          style: mullerW500.copyWith(
                              fontSize: 16,
                              color: AppColors.color2E236C.withOpacity(0.5)),
                        ),
                        Gap(10.0),
                        Visibility(
                          visible: !controller.isFromEmailVerification,
                          child: InkWell(
                            onTap: () {
                              controller.countdownController?.dispose();
                              Get.back();
                            },
                            child: Text(
                              'Change'.tr,
                              style: mullerW400.copyWith(
                                  fontSize: 14, color: AppColors.color2E236C),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(26),
                    CustomOtpPinField(
                        otpPinFieldKey: controller.otpPinFieldKey,
                        onSubmit: (final String text) {
                          controller.setOtpValue(text);
                        },
                        onChange: (final String text) {
                          controller.setOtpValue(text);
                        }),
                    Gap(30),
                    CommonButton(
                      onTap: () {
                        controller.checkVerifyOTPValidation();
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
                            crossFadeState: controller.isResendOTPVisible
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 200),
                            firstChild: Text(
                              'Resend OTP in'.tr,
                              style: mullerW400.copyWith(
                                  color: AppColors.color6A6982),
                            ),
                            secondChild: GestureDetector(
                              onTap: () async {
                                if (!controller.isFromEmailVerification) {
                                  controller.resendOTP(isResend: true);
                                } else {
                                  controller.sendOTPForEmailVerification(
                                      isResend: true);
                                }
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
                            visible:
                                controller.isResendOTPVisible ? false : true,
                            child: CountdownTimer(
                              controller: controller.countdownController,
                              widgetBuilder: (final BuildContext context,
                                  final CurrentRemainingTime? time) {
                                return Text('${time?.sec.toString() ?? ''}s');
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
