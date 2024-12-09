import 'package:atobuy_vendor_flutter/controller/global_otp_verification_controller.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ResendOTPWidget extends StatelessWidget {
  const ResendOTPWidget({required this.onTapResend});

  final Function() onTapResend;
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<OTPVerificationController>(
        builder: (final OTPVerificationController controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedCrossFade(
            crossFadeState: controller.isResendOTPVisible
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
            firstChild: Text(
              'Resend OTP in'.tr,
              style: mullerW400.copyWith(color: AppColors.color6A6982),
            ),
            secondChild: GestureDetector(
              onTap: () {
                onTapResend.call();
              },
              child: Text(
                'Resend'.tr,
                style: mullerW400.copyWith(color: AppColors.color6A6982),
              ),
            ),
          ),
          Gap(5),
          Visibility(
            visible: controller.isResendOTPVisible ? false : true,
            child: CountdownTimer(
              controller: controller.countdownController,
              widgetBuilder: (final BuildContext context,
                  final CurrentRemainingTime? time) {
                return Text('${time?.sec.toString() ?? ''}s');
              },
            ),
          ),
        ],
      );
    });
  }
}
