import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/auth_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/login_reponse_model.dart';
import 'package:atobuy_vendor_flutter/helper/push_notification/notification_service.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OTPVerificationController extends GetxController implements GetxService {
  OTPVerificationController({
    required this.authRepo,
    required this.sharedPreferenceHelper,
  });

  final AuthRepo authRepo;
  final SharedPreferenceHelper sharedPreferenceHelper;

  CountdownTimerController? countdownController;
  bool isResendOTPVisible = false;

  final TextEditingController pinController = TextEditingController();
  final GlobalKey<OtpPinFieldState> otpPinFieldKey =
      GlobalKey<OtpPinFieldState>();

  String mobileNumber = '';
  OTPVerificationFor? comeFrom;
  void manageArguments() {
    if (Get.arguments != null) {
      if (Get.arguments['mobileNumber'] != null) {
        mobileNumber = Get.arguments['mobileNumber'];
      }

      if (Get.arguments['from'] != null) {
        if (Get.arguments['from'] is OTPVerificationFor) {
          comeFrom = Get.arguments['from'];
        }
      }
    }
  }

  void startTimer() {
    final int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
    countdownController =
        CountdownTimerController(endTime: endTime, onEnd: onTimerEnd);
  }

  void resetTimer() {
    startTimer();
    isResendOTPVisible = false;
    update();
  }

  void onTimerEnd() {
    isResendOTPVisible = true;
    update();
  }

  void onTapSubmit() {
    verifyMobileLoginOTP(mobileNumber: mobileNumber, otp: pinController.text);
  }

  Future<void> resendOTP(final String mobileNumber) async {
    try {
      Loader.load(true);
      final Map<String, String> body = <String, String>{
        'contact_number': mobileNumber,
      };

      debugPrint('$body');
      await authRepo.resendOTP(body: body).then((final bool response) async {
        resetTimer();
        Loader.load(false);
      });
    } catch (e) {
      Loader.load(false);
      rethrow;
    }
  }

  Future<void> verifyMobileLoginOTP(
      {required final String mobileNumber, required final String otp}) async {
    try {
      Loader.load(true);
      final Map<String, String> body = <String, String>{
        'otp': otp,
        'contact_number': mobileNumber,
      };

      debugPrint('$body');
      await authRepo
          .verifyMobileLoginOTP(body: body)
          .then((final LoginUserResponse response) async {
        Loader.load(false);
        Utility.saveUserDetails(
          response,
        );

        Future<void>.delayed(Duration(milliseconds: 500), () {
          NotificationService().getFCMToken();
          Get.find<GlobalController>().getCartList();
          Get.offAllNamed(
              (sharedPreferenceHelper.user?.vendorStoreExist ?? false)
                  ? RouteHelper.home
                  : RouteHelper.shop,
              arguments: <String, bool>{'isLogin': true});
        });
      });
    } catch (e) {
      Loader.load(false);
    }
  }
}
