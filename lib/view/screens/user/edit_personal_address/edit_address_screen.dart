import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_personal_address/widgets/edit_address_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<UserProfileController>(
        initState: (final GetBuilderState<UserProfileController> state) {
      Get.find<UserProfileController>().resetAddressFrom();
      Future<void>.delayed(Duration.zero, () {
        Get.find<UserProfileController>().setAddress();
      });
    }, builder: (final UserProfileController controller) {
      return Scaffold(
        appBar: AppbarWithBackIconAndTitle(
          title: controller.isComeForPersonalAddress()
              ? 'Edit Personal Address'.tr
              : 'Edit Business Address'.tr,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              EditAddressFormWidget(),
              CommonButton(
                onTap: () {
                  controller.onTapSaveAddress();
                },
                title: 'Save Changes'.tr,
              ),
              Gap(MediaQuery.of(context).padding.bottom > 0
                  ? MediaQuery.of(context).padding.bottom
                  : 16)
            ],
          ).paddingSymmetric(horizontal: 16.0),
        ),
      );
    });
  }
}
