import 'package:atobuy_vendor_flutter/controller/shipping_address_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile_detail/widgets/item_with_icon_title_and_right_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddressMoreBottomSheet extends StatelessWidget {
  AddressMoreBottomSheet(
      {super.key,
      required this.addressModel,
      required this.onTapEditProduct,
      required this.onTapDeleteProduct});

  final AddressModel addressModel;
  final Function() onTapEditProduct;
  final Function() onTapDeleteProduct;

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ShippingAddressController>(
      builder: (final ShippingAddressController controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.12),
                    blurRadius: 27.6,
                    spreadRadius: 0,
                    offset: Offset(0, -8),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Gap(20),
                  ItemWithIconTitleAndRightIconWidget(
                    title: 'Edit Address'.tr,
                    prefixSvgIcon: Assets.svg.icEditRoundedCorner,
                    onTap: onTapEditProduct,
                  ),
                  ItemWithIconTitleAndRightIconWidget(
                    title: 'Delete Address'.tr,
                    prefixSvgIcon: Assets.svg.icDeleteRoundedCorner,
                    onTap: onTapDeleteProduct,
                  ),
                  Gap(20),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static void show(
      {required final AddressModel addressModel,
      required final Function() onTapEditProduct,
      required final Function() onTapDeleteProduct}) {
    Get.bottomSheet(
      AddressMoreBottomSheet(
        addressModel: addressModel,
        onTapEditProduct: onTapEditProduct,
        onTapDeleteProduct: onTapDeleteProduct,
      ),
      barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
    );
  }
}
