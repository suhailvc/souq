import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/auth_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/business_type_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/login_reponse_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/push_notification/notification_service.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/utils/static_data.dart';
import 'package:atobuy_vendor_flutter/view/base/country_picker/countries.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class SignupController extends GetxController implements GetxService {
  SignupController({
    required this.authRepo,
    required this.globalController,
  });

  final AuthRepo authRepo;
  final GlobalController globalController;

  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<OtpPinFieldState> otpPinFieldKey =
      GlobalKey<OtpPinFieldState>();

  bool isPasswordVisible = false;
  bool isCnfPasswordVisible = false;
  bool isTnCTicked = false;

  CountdownTimerController? countdownController;
  bool isResendOTPVisible = false;

  final TextEditingController firstNameEC = TextEditingController();
  final TextEditingController lastNameEC = TextEditingController();
  final TextEditingController companyEC = TextEditingController();
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController phoneEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();
  final TextEditingController confirmPasswordEC = TextEditingController();

  List<BusinessCategory> arrBusinessTypes = <BusinessCategory>[];
  List<BusinessCategory> selectedBusinessTypes = <BusinessCategory>[];

  String countryCode = qatarDialCode;
  CountryModel? selectedCountry;
  String mobileNumber = '';
  String otpPin = '';

  void initialise() {
    resetFormData();
    getBusinessType();
    globalController.refreshCountryList();
  }

  void resetFormData() {
    firstNameEC.text = '';
    lastNameEC.text = '';
    companyEC.text = '';
    emailEC.text = '';
    phoneEC.text = '';
    mobileNumber = '';
    passwordEC.text = '';
    confirmPasswordEC.text = '';
    isTnCTicked = false;
    isPasswordVisible = false;
    isCnfPasswordVisible = false;
    countryCode = qatarDialCode;
    selectedBusinessTypes = <BusinessCategory>[];
  }

  void createUserAccount() async {
    if (!await ConnectionUtils.isNetworkConnected()) {
      showCustomSnackBar(message: MessageConstant.networkError.tr);
      return;
    }

    if (!validateSignupForm()) {
      return;
    }
    try {
      Loader.load(true);
      final bool result =
          await authRepo.createUser(body: getSignupRequestData());
      if (result) {
        isResendOTPVisible = false;
        startTimer();
        Get.toNamed(RouteHelper.verifyOTP);
      }
      Loader.load(false);
      update();
    } catch (e) {
      Loader.load(false);
    }
  }

  bool validateSignupForm() {
    if (signUpFormKey.currentState?.validate() ?? false) {
      if (selectedCountry == null) {
        showCustomSnackBar(message: 'Please select your country'.tr);
        return false;
      }
      if (!isTnCTicked) {
        showCustomSnackBar(
            message: 'Please agree to our Terms & Conditions'.tr);
        return false;
      }
      if (!selectedBusinessTypes.isNotNullOrEmpty()) {
        showCustomSnackBar(message: 'Please select your business type'.tr);
        return false;
      }

      return true;
    } else {
      return false;
    }
  }

  Map<String, dynamic> getSignupRequestData() {
    mobileNumber = '+${countryCode}${phoneEC.text.trim()}';
    final businessIds = [];
    for (int i = 0; i < selectedBusinessTypes.length; i++) {
      businessIds.add(selectedBusinessTypes[i].id);
    }
    return <String, dynamic>{
      'email': emailEC.text.toLowerCase().trim(),
      'first_name': firstNameEC.text.trim(),
      'last_name': lastNameEC.text.trim(),
      'contact_number': mobileNumber,
      'country': selectedCountry?.id ?? '',
      'user_type': 'BUSINESS_USER',
      'company_name': companyEC.text.trim(),
      'password': passwordEC.text.trim(),
      'confirm_password': confirmPasswordEC.text.trim(),
      'is_terms_and_condition_accepted': isTnCTicked,
      'business_type': businessIds,
    };
  }

  Future<void> getBusinessType() async {
    try {
      arrBusinessTypes = await globalController.getBusinessCategory(
          queryParams: <String, String>{'page_size': 'all'});
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyOTP() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      final Map<String, dynamic> payLoad = <String, dynamic>{
        'otp': otpPin,
        'contact_number': mobileNumber,
      };
      final LoginUserResponse result = await authRepo.verifyOTPRequest(
          body: payLoad, queryParams: <String, bool>{'is_mobile_otp': true});
      Loader.load(false);
      if (result.token != null) {
        NotificationService().getFCMToken();
        Get.offAllNamed(RouteHelper.accountCreated);
      }
    } catch (e) {
      Loader.load(false);
      rethrow;
    }
  }

  Future<void> resendOTP() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      final Map<String, dynamic> payLoad = <String, dynamic>{
        'contact_number': mobileNumber,
      };
      await authRepo.resendOTP(body: payLoad);
      resetTimer();
      Loader.load(false);
    } catch (e) {
      Loader.load(false);
      rethrow;
    }
  }

  void checkVerifyOTPValidation() {
    if (otpPin.isEmpty) {
      showCustomSnackBar(message: 'Please enter OTP.'.tr);
      return;
    } else if (otpPin.length < 6) {
      showCustomSnackBar(message: 'Please enter valid OTP.'.tr);
      return;
    }
    verifyOTP();
  }

  void setOtpValue(final String value) {
    otpPin = value;
  }

  void changePasswordVisibility(final bool result) {
    isPasswordVisible = result;
    update();
  }

  void changeCnfPasswordVisibility(final bool result) {
    isCnfPasswordVisible = result;
    update();
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

  void setPhoneDialCode(
    final Country country,
  ) {
    countryCode = '${country.dialCode}';
  }

  void setSelectedCountry(final CountryModel? value) {
    if (value == selectedCountry) {
      return;
    }
    selectedCountry = value;
    update();
  }
}
