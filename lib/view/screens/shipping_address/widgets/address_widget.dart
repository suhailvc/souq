import 'package:atobuy_vendor_flutter/controller/shipping_address_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/shipping_address/widgets/address_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ShippingAddressController>(
        builder: (final ShippingAddressController controller) {
      return controller.addressList.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                  itemCount: controller.addressList.length,
                  itemBuilder: (final BuildContext context, final int index) {
                    return AddressRow(
                      addressModel: controller.addressList[index],
                      onTapEditProduct: (final AddressModel addressModel) {
                        Get.back();
                        Get.toNamed(RouteHelper.addShippingAddress,
                            arguments: <String, AddressModel>{
                              'address': addressModel,
                            });
                      },
                      onTapDeleteProduct: (final AddressModel addressModel) {
                        Get.back();
                        controller.onTapDeleteShippingAddress(
                            address: addressModel);
                      },
                    );
                  }),
            )
          : controller.isLoading
              ? SizedBox()
              : Expanded(
                  child: NoItemFoundWidget(
                    image: Assets.svg.icNoOrder,
                    message: 'No Addresses Found.'.tr,
                  ),
                );
    });
  }
}
