import 'dart:convert';

import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/product_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/user_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/business_type_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/user_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/user_response_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/utils/pref_keys.dart';
import 'package:atobuy_vendor_flutter/utils/static_data.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/country_picker/countries.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/login/widgets/logout_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/image_picker_option_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile/widgets/delete_account_bottomsheet.dart';
import 'package:dio/dio.dart' as dio_multi;
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

class UserProfileController extends GetxController {
  UserProfileController({
    required this.userRepo,
    required this.sharedPreferenceHelper,
    required this.globalController,
    required this.productRepo,
  });

  final UserRepo userRepo;
  final SharedPreferenceHelper sharedPreferenceHelper;
  final GlobalController globalController;
  final ProductRepo productRepo;

  //Edit Profile
  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  final GlobalKey<OtpPinFieldState> otpPinFieldKey =
      GlobalKey<OtpPinFieldState>();

  final TextEditingController txtFirstNameEc = TextEditingController();
  final TextEditingController txtLastNameEc = TextEditingController();
  final TextEditingController txtCompanyNameEc = TextEditingController();
  final TextEditingController txtEmailEc = TextEditingController();
  final TextEditingController txtMobileNumberEc = TextEditingController();

  String countryCode = qatarDialCode;
  String mobileNumber = '';
  Map<String, dynamic> queryParam = <String, dynamic>{};
  bool isFromEmailVerification = false;

  UserModel userProfile = UserModel();
  List<AddressModel> userAddressList = <AddressModel>[];
  String userAddress = '-';
  String userCompanyAddress = '-';
  String otpPin = '';
  String selectedImage = '';

  CountdownTimerController? countdownController;
  bool isResendOTPVisible = false;

  // Edit Address
  final GlobalKey<FormState> editAddressFormKey = GlobalKey<FormState>();

  final TextEditingController txtAddressLine1 = TextEditingController();
  final TextEditingController txtZoneNo = TextEditingController();
  final TextEditingController txtStreet = TextEditingController();
  final TextEditingController txtBuilding = TextEditingController();
  final TextEditingController txtLandMark = TextEditingController();
  final TextEditingController txtCity = TextEditingController();
  final TextEditingController txtState = TextEditingController();
  final TextEditingController txtCountry = TextEditingController();

  CountryModel? selectedCountry;
  Region? selectedState;
  City? selectedCity;
  int? addressId;

  List<BusinessCategory> arrBusinessTypes = <BusinessCategory>[];
  List<BusinessCategory> selectedBusinessTypes = <BusinessCategory>[];

  // Change Password
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  bool isOldPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final TextEditingController txtOldPassword = TextEditingController();
  final TextEditingController txtNewPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();
  String type = '';

  late List<Tuple3<String, String, VoidCallback>> profileOptionList =
      <Tuple3<String, String, VoidCallback>>[];

  List<StoreModel> arrStores = <StoreModel>[];
  StoreModel? selectedStore;

  @override
  void onInit() {
    super.onInit();
    initialise();
  }

  void initialise() {
    globalController.refreshCountryList();
    setMenuOptions();
    if (sharedPreferenceHelper.isLoggedIn) {
      getUserProfile();
      getAddressApiCall();
    }
  }

  void setMenuOptions() {
    //TODO commented on 25/06/2024 after confirming with @mahavir
    // Tuple3<String, String, VoidCallback>(
    //     Assets.svg.icKycConfirmation, 'KYC Confirmation'.tr, () {}),
    profileOptionList = <Tuple3<String, String, VoidCallback>>[];

    profileOptionList.add(
      Tuple3<String, String, VoidCallback>(
          Assets.svg.icTranslation, 'Change Language', () {
        if (sharedPreferenceHelper.getLanguageCode ==
            AppConstants.englishLangCode) {
          sharedPreferenceHelper.setLanguageCode(AppConstants.arabicLangCode);
          sharedPreferenceHelper.setCountryCode('QA');
          Get.updateLocale(
            Locale(AppConstants.arabicLangCode, 'QA'),
          );
        } else if (sharedPreferenceHelper.getLanguageCode ==
            AppConstants.arabicLangCode) {
          sharedPreferenceHelper.setLanguageCode(AppConstants.englishLangCode);
          sharedPreferenceHelper.setCountryCode('US');
          Get.updateLocale(
            Locale(AppConstants.englishLangCode, 'US'),
          );
        }

        globalController.getProductFilter();
        globalController.getPaymentMethods();
        globalController.refreshCountryList();
      }),
    );

    profileOptionList.addAllIf(
      sharedPreferenceHelper.isLoggedIn,
      <Tuple3<String, String, VoidCallback>>[
        Tuple3<String, String, VoidCallback>(
            Assets.svg.icLocation, 'Shipping Address', () {
          Get.toNamed(
            RouteHelper.shippingAddress,
          );
        }),
        // TODO: will use once we will have payment methods in app.
        // Tuple3<String, String, VoidCallback>(
        //     Assets.svg.icPaymentMethods, 'Payment Methods', () {
        //   Get.to(
        //     () => CommonComingSoon(
        //       title: 'Payment Methods',
        //     ),
        //   );
        // }),
        Tuple3<String, String, VoidCallback>(
            Assets.svg.icPurchaseHistory, 'Your Purchase History', () {
          Get.toNamed(
            RouteHelper.purchaseHistory,
          );
        }),
      ],
    );
    profileOptionList.addIf(
      sharedPreferenceHelper.isLoggedIn &&
          (sharedPreferenceHelper.user?.vendorStoreExist ?? false),
      Tuple3<String, String, VoidCallback>(
          Assets.svg.icShopUnselected, 'Store List', () {
        Get.toNamed(
          RouteHelper.allStoreList,
        );
      }),
    );

    profileOptionList.addAll(
      <Tuple3<String, String, VoidCallback>>[
        Tuple3<String, String, VoidCallback>(
            Assets.svg.icContactUs, 'Contact us', () {
          Get.toNamed(RouteHelper.contactUs);
        }),
        Tuple3<String, String, VoidCallback>(
            Assets.svg.icContactUs, 'Chat with us', () {
          Utility.openWhatsApp();
        }),
        Tuple3<String, String, VoidCallback>(
            Assets.svg.icInfoCircle, StaticPages.aboutUs.title, () {
          Get.toNamed(RouteHelper.staticPageDetail,
              arguments: <String, StaticPages>{'page': StaticPages.aboutUs});
        }),
        Tuple3<String, String, VoidCallback>(
            Assets.svg.icFaqs, StaticPages.faqs.title, () {
          Get.toNamed(RouteHelper.staticPageDetail,
              arguments: <String, StaticPages>{'page': StaticPages.faqs});
        }),
        Tuple3<String, String, VoidCallback>(
            Assets.svg.icPrivacyPolicy, StaticPages.privacyPolicy.title, () {
          Get.toNamed(RouteHelper.staticPageDetail,
              arguments: <String, StaticPages>{
                'page': StaticPages.privacyPolicy
              });
        }),
        Tuple3<String, String, VoidCallback>(
            Assets.svg.icTermsConditions, StaticPages.termsAndCondition.title,
            () {
          Get.toNamed(RouteHelper.staticPageDetail,
              arguments: <String, StaticPages>{
                'page': StaticPages.termsAndCondition
              });
        }),
      ],
    );

    profileOptionList.addAllIf(
        sharedPreferenceHelper.isLoggedIn,
        <Tuple3<String, String, VoidCallback>>[
          Tuple3<String, String, VoidCallback>(
            Assets.svg.icTrash,
            'Delete Account',
            () {
              onTapDeleteAccount();
            },
          ),
          Tuple3<String, String, VoidCallback>(
            Assets.svg.icLogout,
            'Logout',
            () {
              Get.bottomSheet(
                const LogoutBottomSheet(),
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15.0),
                  ),
                ),
                isScrollControlled: false,
              );
            },
          ),
        ]);
  }

  // Edit Profile
  void setUserData() {
    txtFirstNameEc.text = userProfile.firstName ?? '';
    txtLastNameEc.text = userProfile.lastName ?? '';
    txtEmailEc.text = userProfile.email ?? '';
    txtMobileNumberEc.text = '${userProfile.phoneNumberWithoutCode ?? ''}';
    countryCode = '${userProfile.countryCode?.replaceAll('+', '')}';
    mobileNumber = '+${countryCode}${userProfile.phoneNumberWithoutCode ?? ''}';

    selectedImage = userProfile.profileImage ?? '';

    if (userProfile.company.isNotNullOrEmpty()) {
      txtCompanyNameEc.text = userProfile.company!.first.companyName ?? '';
    }
  }

  Future<void> resetData() async {
    resetEditProfileFrom();
    setUserData();
    getBusinessType();
  }

  void resetEditProfileFrom() {
    txtFirstNameEc.text = '';
    txtLastNameEc.text = '';
    txtCompanyNameEc.text = '';
    txtEmailEc.text = '';
    txtMobileNumberEc.text = '';
    mobileNumber = '';
    countryCode = qatarDialCode;
    selectedImage = '';
    isFromEmailVerification = false;
    selectedBusinessTypes = <BusinessCategory>[];
  }

  Future<void> onProfileImageUpdate() async {
    Get.bottomSheet(
      CommonBottomSheet(
        onTapCamera: () async {
          final Media? profileMedia =
              await Utility.pickImage(PhotoPickerType.camera);
          selectedImage = profileMedia?.path ?? '';
          update();
        },
        onTapGallery: () async {
          final Media? profileMedia =
              await Utility.pickImage(PhotoPickerType.photos);
          selectedImage = profileMedia?.path ?? '';
          update();
        },
      ),
      isDismissible: true,
      enableDrag: false,
      isScrollControlled: false,
    );
  }

  Future<void> getUserProfile() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      final UserResponseModel userProfileModel =
          await userRepo.getUserProfile();

      if (userProfileModel.results.isNotNullOrEmpty()) {
        userProfile = userProfileModel.results!.first;
        sharedPreferenceHelper.saveUser(userProfile);
        setUserData();
      }
      update();
    } catch (e) {
      Loader.load(false);
      debugPrint(e.toString());
    }
  }

  Future<void> getAddressApiCall() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      final AddressListModel addressListModel =
          await userRepo.getAddresses(params: <String, dynamic>{});
      if (addressListModel.results.isNotNullOrEmpty()) {
        userAddressList = addressListModel.results ?? <AddressModel>[];

        for (AddressModel addressModel
            in addressListModel.results ?? <AddressModel>[]) {
          if (addressModel.addressType == AddressType.user) {
            //user address
            userAddress = addressModel.getFullAddress();
          } else if (addressModel.addressType == AddressType.company) {
            //user company address
            userCompanyAddress = addressModel.getFullAddress();
          }
        }
        update();
      }
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> editUserProfile({final String? type}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      dio_multi.MultipartFile? profileImageParam;
      if (selectedImage.isNotEmpty &&
          !Utility.checkIsNetworkUrl(selectedImage)) {
        profileImageParam = await dio_multi.MultipartFile.fromFile(
            selectedImage,
            filename: selectedImage.split('/').last);
      }
      if (!selectedBusinessTypes.isNotNullOrEmpty()) {
        showCustomSnackBar(message: 'Please select your business type'.tr);
        return;
      }
      final List<int> businessIds = <int>[];
      selectedBusinessTypes.forEach((final BusinessCategory type) {
        if (type.id != null) {
          businessIds.add(type.id!);
        }
      });
      final Map<String, dynamic> companyMap = <String, dynamic>{
        'company_name': txtCompanyNameEc.text.trim(),
      };
      if (editProfileFormKey.currentState?.validate() ?? false) {
        mobileNumber = '+${countryCode}${txtMobileNumberEc.text.trim()}';
        final Map<String, dynamic> payLoad = <String, dynamic>{
          'first_name': txtFirstNameEc.text.trim(),
          'last_name': txtLastNameEc.text.trim(),
          'otp': otpPin,
          'email': txtEmailEc.text.trim(),
          'business_type': businessIds,
          'contact_number': mobileNumber,
          'company': jsonEncode(companyMap),
          if (selectedImage.isNotEmpty &&
              !Utility.checkIsNetworkUrl(selectedImage))
            'profile_image': profileImageParam,
        };
        Loader.load(true);
        final UserModel updatedUser = await userRepo.editUserProfile(
            type: type, userId: userProfile.id ?? 0, params: payLoad);
        Loader.load(false);

        sharedPreferenceHelper.saveUser(updatedUser);
        update();
        Get.offAllNamed(RouteHelper.successScreen, arguments: <String, String>{
          AppConstants.successArgumentKey: 'Profile Details Updated.'.tr
        });
      }
    } catch (e) {
      Loader.load(false);
      debugPrint(e.toString());
    }
  }

  Future<void> getBusinessType() async {
    try {
      arrBusinessTypes = await globalController.getBusinessCategory(
          queryParams: <String, String>{'page_size': 'all'});
      selectedBusinessTypes = <BusinessCategory>[];
      for (int i = 0;
          i < (userProfile.businessType ?? <BusinessType>[]).length;
          i++) {
        for (int index = 0; index < arrBusinessTypes.length; index++) {
          if (userProfile.businessType![i].id == arrBusinessTypes[index].id) {
            debugPrint('ID matched ==> ${arrBusinessTypes[index]}');
            selectedBusinessTypes.add(arrBusinessTypes[index]);
          }
        }
      }
      debugPrint('selectedBusinessTypes ==> $selectedBusinessTypes');
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resendOTP({final bool isResend = false}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      final Map<String, dynamic> payload = <String, dynamic>{
        if (getChangeType() == EditEmailOrPhone.mobile.name)
          'contact_number': mobileNumber
        else
          'email': txtEmailEc.text.trim()
      };
      await userRepo.resendOTP(body: payload, queryParams: queryParam);
      Loader.load(false);
      resetTimer();
      if (!isResend) {
        Get.toNamed(
          RouteHelper.editVerifyOtp,
        );
      }
    } catch (e) {
      Loader.load(false);
      rethrow;
    }
  }

  Future<void> sendOTPForEmailVerification(
      {final bool isResend = false}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      final Map<String, dynamic> payLoad = <String, dynamic>{
        'email': userProfile.email ?? ''
      };
      await userRepo.sendOTPForEmailVerification(
        body: payLoad,
        queryParams: <String, bool>{'is_email_otp': true},
      );
      Loader.load(false);
      resetTimer();
      if (!isResend) {
        Get.toNamed(
          RouteHelper.editVerifyOtp,
        );
      }
    } catch (e) {
      Loader.load(false);
      rethrow;
    }
  }

  Future<void> verifyEmailVerificationOTP() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      final Map<String, dynamic> payLoad = <String, dynamic>{
        'otp': otpPin,
        'email': userProfile.email ?? '',
      };
      await userRepo.verifyOTPRequest(
          body: payLoad, queryParams: <String, bool>{'is_email_otp': true});
      Loader.load(false);
      showCustomSnackBar(
          message: 'Email verified successfully.'.tr, isError: false);
      Utility.goBack();
      getUserProfile();
    } catch (e) {
      Loader.load(false);
      rethrow;
    }
  }

  void setOtpValue(final String value) {
    otpPin = value;
  }

  void checkVerifyOTPValidation() {
    if (otpPin.isEmpty) {
      showCustomSnackBar(message: 'Please enter OTP.'.tr);
      return;
    } else if (otpPin.length < 6) {
      showCustomSnackBar(message: 'Please enter valid OTP.'.tr);
      return;
    }
    if (isFromEmailVerification) {
      verifyEmailVerificationOTP();
    } else {
      editUserProfile(type: '?type=${getChangeType()}');
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

  // Change Password
  void changePasswordApiCall() async {
    if (!await ConnectionUtils.isNetworkConnected()) {
      showCustomSnackBar(message: MessageConstant.networkError.tr);
      return;
    }
    try {
      if (changePasswordFormKey.currentState?.validate() ?? false) {
        final Map<String, dynamic> payLoad = <String, dynamic>{
          'old_password': txtOldPassword.text.trim(),
          'new_password1': txtNewPassword.text.trim(),
          'new_password2': txtConfirmPassword.text.trim(),
        };

        Loader.load(true);
        final bool result = await userRepo.changePassword(body: payLoad);
        Loader.load(false);
        if (result) {
          resetChangePasswordFields();
          Utility.logout();
        }
      } else {
        showCustomSnackBar(
            message: 'Please fill the all the required data.'.tr);
      }
    } catch (e) {
      Loader.load(false);
    }
  }

  void onOldPasswordVisibility(final bool isVisible) {
    isOldPasswordVisible = isVisible;
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

  void resetChangePasswordFields() {
    txtOldPassword.text = '';
    txtNewPassword.text = '';
    txtConfirmPassword.text = '';
  }

  String getChangeType() {
    mobileNumber = '+${countryCode}${txtMobileNumberEc.text.trim()}';
    if (userProfile.contactNumber != mobileNumber) {
      queryParam = <String, dynamic>{'is_profile_change_mobile_otp': true};
      return EditEmailOrPhone.mobile.name;
    } else if (userProfile.email != txtEmailEc.text.trim()) {
      queryParam = <String, dynamic>{'is_profile_change_email_otp': true};
      return EditEmailOrPhone.email.name;
    }
    return '';
  }

  // Address
  void setAddress() {
    AddressModel? address;
    if (isComeForPersonalAddress()) {
      if (userAddressList.isNotEmpty) {
        address = userAddressList.firstWhereOrNull(
            (final AddressModel element) =>
                element.addressType == AddressType.user);
      }
    } else {
      if (userAddressList.isNotEmpty) {
        address = userAddressList.firstWhereOrNull(
            (final AddressModel element) =>
                element.addressType == AddressType.company);
      }
    }

    if (address != null) {
      addressId = address.id;
      txtAddressLine1.text = address.addressLine1 ?? '';
      txtStreet.text = address.street ?? '';
      txtBuilding.text = address.building ?? '';
      txtLandMark.text = address.landmark ?? '';
      txtZoneNo.text = address.postalCode.toString();

      if (address.city != null) {
        if (address.city?.country != null) {
          setSelectedCountry(address.city?.country);
        }
        if (address.city?.region != null) {
          setSelectedState(address.city?.region);
        }
        setSelectedCity(address.city);
      }
    }
  }

  void resetAddressFrom() {
    txtAddressLine1.text = '';
    txtStreet.text = '';
    txtLandMark.text = '';
    txtCity.text = '';
    txtState.text = '';
    txtCountry.text = '';
    txtZoneNo.text = '';
    txtBuilding.text = '';
    selectedCity = null;
    selectedState = null;
    selectedCountry = null;
    addressId = null;
  }

  bool isComeForPersonalAddress() {
    if (Get.arguments != null) {
      if (Get.arguments['come_from'] != null) {
        if (Get.arguments['come_from'] == UserProfileFromPage.personal.name) {
          return true;
        }
      }
    }
    return false;
  }

  void setSelectedCity(final City? value) {
    if (value == selectedCity) {
      return;
    }
    selectedCity = value;
    update();
  }

  void setSelectedCountry(final CountryModel? value) {
    if (value == selectedCountry) {
      return;
    }
    selectedCountry = value;
    if (value != null) {
      Get.find<GlobalController>().fetchState(
        countryId: selectedCountry?.id ?? 0,
      );
    }

    selectedState = null;
    selectedCity = null;
    update();
  }

  void setSelectedState(final Region? value) {
    if (value == selectedState) {
      return;
    }
    selectedState = value;
    if (value != null) {
      Get.find<GlobalController>().fetchCity(
        stateId: selectedState?.id ?? 0,
        countryId: selectedCountry?.id ?? 0,
      );
    }
    selectedCity = null;
    update();
  }

  void onTapSaveAddress() {
    if (editAddressFormKey.currentState?.validate() ?? false) {
      if (selectedCountry == null) {
        showCustomSnackBar(message: 'Please select your country'.tr);
        return;
      }
      if (selectedState == null) {
        showCustomSnackBar(message: 'Please select your state'.tr);
        return;
      }
      if (selectedCity == null) {
        showCustomSnackBar(message: 'Please select your city'.tr);
        return;
      }
      createOrEditAddress();
    }
  }

  Future<void> createOrEditAddress() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);

      final Map<String, dynamic> requestData = <String, dynamic>{
        'id': addressId,
        'line1': txtAddressLine1.text.trim(),
        'postal_code': txtZoneNo.text.trim(),
        'line2': txtStreet.text.trim(),
        'line3': txtBuilding.text.trim(),
        'landmark': txtLandMark.text.trim(),
        'city': selectedCity?.id ?? 0,
      };

      if (addressId == null) {
        requestData['address_type'] = isComeForPersonalAddress()
            ? AddressType.user.name
            : AddressType.company.name;
      }
      await userRepo.createUpdateAddresses(body: requestData);
      Loader.load(false);
      Get.back();
      getAddressApiCall();
    } catch (e) {
      Loader.load(false);
      rethrow;
    }
  }

  void setPhoneDialCode(
    final Country country,
  ) {
    countryCode = '${country.dialCode}';
  }

  void onTapDeleteAccount() {
    Get.bottomSheet(
      DeleteAccountBottomSheet(
        onTapConfirmDeleteAccount: () {
          deleteUserAccount();
        },
      ),
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      isScrollControlled: false,
    );
  }

  Future<void> deleteUserAccount() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      await userRepo.deleteUserAccount();
      Loader.load(false);
      Utility.logout();
    } catch (e) {
      Loader.load(false);
      rethrow;
    }
  }

  void initialiseStoreScreen() {
    getStoreList();
  }

  Future<void> getStoreList() async {
    try {
      Loader.load(true);

      final Map<String, String> param = <String, String>{'page_size': 'all'};
      await productRepo
          .getStoreList(params: param)
          .then((final List<StoreModel> stores) async {
        Loader.load(false);
        arrStores = <StoreModel>[StoreModel(name: 'All')];
        arrStores.addAll(stores);
        selectedStore = arrStores.firstWhereOrNull((final StoreModel store) =>
            store.id == sharedPreferenceHelper.selectedStoreId);
        if (selectedStore == null && arrStores.isNotEmpty) {
          selectedStore = arrStores.first;
        }
        update();
      });
    } catch (e) {
      Loader.load(false);
    }
  }

  void onTapSelectStore({required final StoreModel store}) {
    selectedStore = store;
    update();
  }

  void onTapSaveSelectedStore() {
    if (selectedStore?.id != null) {
      sharedPreferenceHelper.saveSelectedStore(selectedStore?.id ?? 0);
      update();
    } else {
      Get.find<SharedPreferences>().remove(PrefKeys.storeId);
    }

    Get.back();
  }

  void onSaveProfileChanges() {
    if (userProfile.email != txtEmailEc.text.trim() &&
        userProfile.contactNumber !=
            '+${countryCode}${txtMobileNumberEc.text}') {
      showCustomSnackBar(
          message:
              'You can either update email address or mobile number at a time.'
                  .tr);
      return;
    }
    if (editProfileFormKey.currentState?.validate() ?? false) {
      if (getChangeType() == EditEmailOrPhone.mobile.name ||
          getChangeType() == EditEmailOrPhone.email.name) {
        //either mobile or email changed.Call send OTP API
        resendOTP();
      } else {
        //when mobile or email not changed
        editUserProfile();
      }
    } else {
      showCustomSnackBar(message: 'Please fill the all the required data.'.tr);
    }
  }
}
