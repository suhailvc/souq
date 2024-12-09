import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/user_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/common_delete_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddressController extends GetxController implements GetxService {
  ShippingAddressController(
      {required this.userRepo, required this.globalController});

  final UserRepo userRepo;
  final GlobalController globalController;

  // Edit Address
  final GlobalKey<FormState> addAddressFormKey = GlobalKey<FormState>();

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
  AddressModel? addressModel;
  List<AddressModel> addressList = <AddressModel>[];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    addressModel = null;
    addressList.clear();
    getAddressApiCall();
  }

  void getCountries() {
    globalController.refreshCountryList();
    if (Get.arguments != null && Get.arguments['address'] != null) {
      addressModel = Get.arguments['address'];
      setAddressData();
    }
  }

  Future<void> getAddressApiCall() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      final Map<String, dynamic> params = <String, dynamic>{
        'type': AddressType.shipping.name,
      };
      final AddressListModel addressListModel =
          await userRepo.getAddresses(params: params);
      if (addressListModel.results.isNotNullOrEmpty()) {
        addressList = (addressListModel.results ?? <AddressModel>[]);
      }
      isLoading = false;
      update();
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      update();
    }
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
    if (addAddressFormKey.currentState?.validate() ?? false) {
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

  void setAddressData() {
    if (addressModel != null) {
      addressId = addressModel?.id;
      txtAddressLine1.text = addressModel?.addressLine1 ?? '';
      txtStreet.text = addressModel?.street ?? '';
      txtLandMark.text = addressModel?.landmark ?? '';
      txtZoneNo.text = addressModel!.postalCode.toString();
      txtBuilding.text = addressModel!.building ?? '';

      if (addressModel?.city != null) {
        if (addressModel?.city?.country != null) {
          setSelectedCountry(addressModel?.city?.country);
        }
        if (addressModel?.city?.region != null) {
          setSelectedState(addressModel?.city?.region);
        }
        setSelectedCity(addressModel?.city);
      }
    }
  }

  void resetAddressForm() {
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
    addressModel = null;
    addressId = null;
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
        'address_type': AddressType.shipping.name,
      };
      await userRepo.createUpdateAddresses(body: requestData);
      Loader.load(false);
      getAddressApiCall();
      Get.back(result: true);
    } catch (e) {
      Loader.load(false);
      rethrow;
    }
  }

  Future<void> deleteAddressApiCall(final AddressModel addressModel) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);

      await userRepo.deleteAddressApiCall(addressId: addressModel.id ?? 0);
      Loader.load(false);
      addressList.remove(addressModel);
      update();
    } catch (e) {
      Loader.load(false);
      rethrow;
    }
  }

  void onTapDeleteShippingAddress({required final AddressModel address}) {
    Get.bottomSheet(CommonDeleteBottomSheet(
      onTapDelete: () {
        deleteAddressApiCall(address);
      },
      title: 'Delete shipping address'.tr,
      subTitle: 'Are you sure you want to remove this address from list?'.tr,
    ));
  }
}
