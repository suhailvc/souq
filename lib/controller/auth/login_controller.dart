import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/controller/global_otp_verification_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/auth_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/login_reponse_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/common/common_detail_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/push_notification/notification_service.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/utils/static_data.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class LoginController extends GetxController implements GetxService {
  LoginController({
    required this.authRepo,
    required this.sharedPreferenceHelper,
    required this.globalController,
  });

  final AuthRepo authRepo;
  final SharedPreferenceHelper sharedPreferenceHelper;
  final GlobalController globalController;

  SelectedLoginType selectedTab = SelectedLoginType.email;

  // Email Login
  final GlobalKey<FormState> loginWithEmailFormKey = GlobalKey<FormState>();
  final GlobalKey<OtpPinFieldState> otpPinFieldKey =
      GlobalKey<OtpPinFieldState>();
  bool isPasswordVisible = false;
  bool isRememberMeTicked = false;
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  String? loginError;

  //Mobile Login
  final GlobalKey<FormState> loginWithMobileFormKey = GlobalKey<FormState>();
  final TextEditingController txtMobileNumber = TextEditingController();
  final OTPVerificationController otpVerificationController =
      Get.find<OTPVerificationController>();
  String selectedCountryCode = qatarDialCode;

  //forgot password
  String? forgotPasswordError;
  final TextEditingController txtForgotEmail = TextEditingController();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  // reset password
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final TextEditingController txtNewPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  String? resetError;

  void init() {
    if (sharedPreferenceHelper.isRememberMe ?? false) {
      isRememberMeTicked = true;
      txtEmail.text = sharedPreferenceHelper.email;
      txtPassword.text = sharedPreferenceHelper.getUserPassword;
    }
    globalController.refreshCountryList();
  }

  void onPasswordVisibility(final bool isVisible) {
    isPasswordVisible = isVisible;
    update();
  }

  void onNewPasswordVisibility(final bool isVisible) {
    isNewPasswordVisible = isVisible;
    update();
  }

  void onConfirmPasswordVisibility(final bool isVisible) {
    isConfirmPasswordVisible = isVisible;
    update();
  }

  void onTapLogin() {
    FocusScope.of(Get.context!).unfocus();
    if (selectedTab == SelectedLoginType.email) {
      loginWithEmail();
    } else {
      loginWithMobile();
    }
  }

  Future<void> loginWithEmail() async {
    if (loginWithEmailFormKey.currentState?.validate() ?? true) {
      await sharedPreferenceHelper.saveIsRememberMe(isRememberMeTicked);
      if (isRememberMeTicked) {
        sharedPreferenceHelper.saveEmail(txtEmail.text.toLowerCase().trim());
        sharedPreferenceHelper.setUserPassword(txtPassword.text);
      } else {
        sharedPreferenceHelper.saveEmail('');
        sharedPreferenceHelper.setUserPassword('');
      }
      try {
        if (!await ConnectionUtils.isNetworkConnected()) {
          showCustomSnackBar(message: MessageConstant.networkError.tr);
          return;
        }

        Loader.load(true);
        final Map<String, String> body = <String, String>{
          'email': txtEmail.text.toLowerCase().trim(),
          'password': txtPassword.text.trim(),
        };
        debugPrint('$body');
        await authRepo
            .loginWithEmail(body: body)
            .then((final LoginUserResponse response) async {
          Loader.load(false);
          loginError = null;
          update();
          Utility.saveUserDetails(
            response,
            isRememberMeTicked: isRememberMeTicked,
            password: txtPassword.text,
          );
          Future<void>.delayed(Duration(milliseconds: 500), () {
            NotificationService().getFCMToken();
            globalController.getCartList();
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

  Future<void> loginWithMobile() async {
    final String mobileNumber =
        '+${selectedCountryCode}${txtMobileNumber.text}'.trim();

    if ((loginWithMobileFormKey.currentState?.validate() ?? false)) {
      try {
        await otpVerificationController
            .resendOTP(mobileNumber)
            .then((final dynamic value) {
          Get.toNamed(
            RouteHelper.globalVerifyOTP,
            arguments: <String, dynamic>{
              'mobileNumber': mobileNumber,
              'from': OTPVerificationFor.mobileLogin
            },
          );
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> callForgotPasswordAPT() async {
    final Map<String, dynamic> request = <String, dynamic>{
      'email': txtForgotEmail.text.toLowerCase().trim()
    };
    if ((forgotPasswordFormKey.currentState?.validate() ?? false)) {
      Loader.load(true);
      try {
        await authRepo
            .forgotPassword(body: request)
            .then((final CommonDetailModel value) {
          Loader.load(false);
          showCustomSnackBar(
              isError: false,
              message:
                  value.detail ?? 'OTP has been send to your email id.'.tr);
          Get.toNamed(RouteHelper.resetPassword);
        });
      } catch (e) {
        Loader.load(false);
        debugPrint(e.toString());
      }
    }
  }

  Future<void> resendForgotPassword() async {
    final Map<String, dynamic> request = <String, dynamic>{
      'email': txtForgotEmail.text.toLowerCase().trim()
    };
    if ((forgotPasswordFormKey.currentState?.validate() ?? false)) {
      Loader.load(true);
      try {
        await authRepo
            .forgotPassword(body: request)
            .then((final CommonDetailModel value) {
          Loader.load(false);
          otpVerificationController.resetTimer();
          showCustomSnackBar(
              isError: false,
              message:
                  value.detail ?? 'OTP has been send to your email id.'.tr);
        });
      } catch (e) {
        Loader.load(false);
        debugPrint(e.toString());
      }
    }
  }

  bool isValidatedPasswordAndOTP() {
    if (pinController.text.trim().length < 6) {
      showCustomSnackBar(message: 'Invalid OTP entered');
      return false;
    }
    if (txtConfirmPassword.text.trim() != txtNewPassword.text.trim()) {
      showCustomSnackBar(message: 'Password does not match');
      return false;
    }

    return true;
  }

  Future<void> callResetPasswordAPI() async {
    final Map<String, dynamic> request = <String, dynamic>{
      'email': txtForgotEmail.text.toLowerCase().trim(),
      'otp': pinController.text.trim(),
      'password': txtNewPassword.text.trim(),
      'confirm_password': txtConfirmPassword.text.trim()
    };
    if ((resetPasswordFormKey.currentState?.validate() ?? false) &&
        isValidatedPasswordAndOTP()) {
      Loader.load(true);
      try {
        await authRepo
            .resetPassword(body: request)
            .then((final CommonDetailModel value) {
          Loader.load(false);
          Get.back();
          Get.back();

          showCustomSnackBar(
              isError: false,
              message: value.detail ??
                  'User password has been successfully reset'.tr);
        });
      } catch (e) {
        Loader.load(false);
        debugPrint(e.toString());
      }
    }
  }

  void resetFieldsAndValidations() {
    loginError = null;
    if (!(sharedPreferenceHelper.isRememberMe ?? false)) {
      txtEmail.text = '';
      txtPassword.text = '';
      isRememberMeTicked = false;
    }
    txtMobileNumber.text = '';
    selectedCountryCode = qatarDialCode;
    selectedTab = SelectedLoginType.email;
  }

  void resetFormError() {
    loginError = null;
    txtEmail.text = '';
    txtPassword.text = '';
    loginWithEmailFormKey.currentState?.reset();
    update();
  }

  Future<void> logOut() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      Loader.load(true);
      await authRepo.logOutApi();
      Loader.load(false);
      Utility.logout();
    } catch (e) {
      Loader.load(false);
      rethrow;
    }
  }
}
