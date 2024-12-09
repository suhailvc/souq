import 'package:atobuy_vendor_flutter/controller/shipping_address_controller.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/shipping_address/widgets/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ShippingAddressController>(
        initState: (final GetBuilderState<ShippingAddressController> state) {
      Get.find<ShippingAddressController>().getAddressApiCall();
    }, builder: (final ShippingAddressController controller) {
      return Scaffold(
        appBar: AppbarWithBackIconTitleAndSuffixWidget(
          title: 'Shipping Address'.tr,
          suffixWidget: IconButton(
            onPressed: () {
              Get.toNamed(RouteHelper.addShippingAddress);
            },
            icon: Icon(
              Icons.add_circle,
              color: AppColors.color12658E,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Gap(20.0),
              AddressWidget(),
              Gap(MediaQuery.of(context).padding.bottom > 0 ? 0 : 16)
            ],
          ).paddingSymmetric(horizontal: 16.0),
        ),
      );
    });
  }
}
