import 'package:atobuy_vendor_flutter/controller/contact_us_controller.dart';
import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/country_picker/countries.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/email_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/first_name_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/last_name_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/message_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/mobile_number_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ContactUsFormWidget extends StatelessWidget {
  const ContactUsFormWidget({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ContactUsController>(
        builder: (final ContactUsController controller) {
      return Form(
        key: controller.contactUsFormKey,
        child: Column(
          children: <Widget>[
            FirstNameWidget(
              controller: controller.txtFirstName,
              isPrefixIcon: false,
            ),
            Gap(16),
            LastNameWidget(
              controller: controller.txtLastName,
              isPrefixIcon: false,
            ),
            Gap(16),
            EmailWidget(
              controller: controller.txtEmail,
              isPrefixIcon: false,
            ),
            Gap(16),
            GetBuilder<GlobalController>(
                builder: (final GlobalController globalController) {
              return MobileNumberWidget(
                controller: controller.txtMobileNumber,
                onCountryChange: (final Country country) {
                  controller.setPhoneDialCode(country);
                },
                isPrefixIcon: false,
                countryCode: controller.countryCode,
                allowOnCountryTap:
                    Utility.isAllowCountryCodeTap(globalController),
              );
            }),
            Gap(16),
            MessageWidget(controller: controller.txtMessage),
            Gap(16),
          ],
        ),
      );
    });
  }
}
