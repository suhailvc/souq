import 'package:atobuy_vendor_flutter/controller/auth/signup_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/otp_pin_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: Scaffold(
        body: GetBuilder<SignupController>(
            builder: (final SignupController signupController) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Gap(50),
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
                        signupController.mobileNumber,
                        style: mullerW500.copyWith(
                            fontSize: 16,
                            color: AppColors.color2E236C.withOpacity(0.5)),
                      ),
                      Gap(10.0),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          'Change'.tr,
                          style: mullerW400.copyWith(
                              fontSize: 14, color: AppColors.color2E236C),
                        ),
                      ),
                    ],
                  ),
                  Gap(26),
                  CustomOtpPinField(
                      otpPinFieldKey: signupController.otpPinFieldKey,
                      onSubmit: (final String text) {
                        signupController.setOtpValue(text);
                      },
                      onChange: (final String text) {
                        signupController.setOtpValue(text);
                      }),
                  Gap(30),
                  CommonButton(
                    onTap: () {
                      signupController.checkVerifyOTPValidation();
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
                          crossFadeState: signupController.isResendOTPVisible
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
                              signupController.resendOTP();
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
                          visible: signupController.isResendOTPVisible
                              ? false
                              : true,
                          child: CountdownTimer(
                            controller: signupController.countdownController,
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
          );
        }),
      ),
    );
  }
}
