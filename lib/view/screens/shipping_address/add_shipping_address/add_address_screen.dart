import 'package:atobuy_vendor_flutter/controller/shipping_address_controller.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/shipping_address/add_shipping_address/widgets/add_shipping_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddShippingAddressScreen extends StatelessWidget {
  const AddShippingAddressScreen({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ShippingAddressController>(
        initState: (final GetBuilderState<ShippingAddressController> state) {
      Get.find<ShippingAddressController>().addressModel = null;
      Get.find<ShippingAddressController>().resetAddressForm();
      Future<void>.delayed(Duration.zero, () {
        Get.find<ShippingAddressController>().getCountries();
      });
    }, builder: (final ShippingAddressController controller) {
      return Scaffold(
        appBar: AppbarWithBackIconAndTitle(
          title: controller.addressModel != null
              ? 'Edit Address'.tr
              : 'Add Address'.tr,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              AddShippingAddressWidget(),
              CommonButton(
                onTap: () {
                  controller.onTapSaveAddress();
                },
                title: 'Save Changes'.tr,
              ),
              Gap(MediaQuery.of(context).padding.bottom > 0 ? 0 : 16)
            ],
          ).paddingSymmetric(horizontal: 16.0),
        ),
      );
    });
  }
}
