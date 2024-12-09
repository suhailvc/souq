import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/statics_repo.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/utils/static_data.dart';
import 'package:atobuy_vendor_flutter/view/base/country_picker/countries.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  ContactUsController({
    required this.staticRepo,
    required this.globalController,
  });

  final StaticsRepository staticRepo;
  final GlobalController globalController;

  //Contact Us
  final GlobalKey<FormState> contactUsFormKey = GlobalKey<FormState>();

  final TextEditingController txtMessage = TextEditingController();
  final TextEditingController txtFirstName = TextEditingController();
  final TextEditingController txtLastName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtMobileNumber = TextEditingController();

  String countryCode = qatarDialCode;

  void resetEditProfileFrom() {
    txtFirstName.text = '';
    txtMessage.text = '';
    txtLastName.text = '';
    txtEmail.text = '';
    txtMobileNumber.text = '';
    countryCode = qatarDialCode;
  }

  void refreshCountryList() {
    globalController.refreshCountryList();
  }

  Future<void> callContactUsApiRequest() async {
    if (contactUsFormKey.currentState?.validate() ?? false) {
      try {
        if (!await ConnectionUtils.isNetworkConnected()) {
          showCustomSnackBar(message: MessageConstant.networkError.tr);
          return;
        }
        Loader.load(true);

        final String mobileNumber =
            '+${countryCode}${txtMobileNumber.text}'.trim();
        final Map<String, String> data = <String, String>{
          'email': txtEmail.text.toString().trim(),
          'first_name': txtFirstName.text.toString().trim(),
          'last_name': txtLastName.text.toString().trim(),
          'contact_number': mobileNumber,
          'message': txtMessage.text.toString().trim(),
        };
        await staticRepo.callContactUsApiRequest(body: data);
        Get.back();
        showCustomSnackBar(
            isError: false,
            message:
                'Thank You!\nYour submission has been sent successfully.'.tr);
        Loader.load(false);
      } catch (e) {
        Loader.load(false);
      }
    }
  }

  void setPhoneDialCode(
    final Country country,
  ) {
    countryCode = '${country.dialCode}';
  }
}
