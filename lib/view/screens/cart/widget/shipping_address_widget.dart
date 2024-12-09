import 'package:atobuy_vendor_flutter/controller/cart/cart_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/cart/widget/shipping_address_row.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShippingAddressWidget extends StatelessWidget {
  const ShippingAddressWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<CartController>(
      builder: (final CartController controller) {
        return controller.shippingAddressList.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Select Delivery Address'.tr,
                          style: mullerW500.copyWith(
                              fontSize: 14, color: AppColors.color171236),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            RouteHelper.addShippingAddress,
                          )?.then((final dynamic value) {
                            if (value ?? false) {
                              controller.getAddressApiCall();
                            }
                          });
                        },
                        child: Text(
                          '+ Add New'.tr,
                          style: mullerW500.copyWith(
                              fontSize: 14, color: AppColors.color12658E),
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 16),
                  Gap(16),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: controller.shippingAddressList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (final BuildContext context, final int index) {
                      return ShippingAddressRow(
                        addressModel: controller.shippingAddressList[index],
                        selectedAddressModel: controller.selectedAddress,
                        onAddressSelection: (final AddressModel addressModel) {
                          controller.onAddressTap(addressModel);
                        },
                      );
                    },
                    separatorBuilder:
                        (final BuildContext context, final int index) {
                      return Divider(
                        color: AppColors.colorE8EBEC,
                      ).paddingSymmetric(vertical: 4);
                    },
                  ),
                ],
              )
            : GestureDetector(
                onTap: () {
                  FocusScope.of(Get.context!).unfocus();
                  Get.toNamed(
                    RouteHelper.addShippingAddress,
                  )?.then((final dynamic value) {
                    if (value ?? false) {
                      controller.getAddressApiCall();
                    }
                  });
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12.0),
                  color: AppColors.colorB1D2E3,
                  strokeWidth: 2,
                  dashPattern: <double>[4, 6],
                  padding: EdgeInsets.zero,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppColors.colorD0E4EE.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            Assets.svg.icAddSubImage,
                            colorFilter: ColorFilter.mode(
                                AppColors.color8ABCD5, BlendMode.srcIn),
                          ),
                          Gap(12.0),
                          Text(
                            'Click here to add shipping address'.tr,
                            style: mullerW400.copyWith(
                                fontSize: 12, color: AppColors.color8ABCD5),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
