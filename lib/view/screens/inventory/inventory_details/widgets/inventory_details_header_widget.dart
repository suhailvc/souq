import 'package:atobuy_vendor_flutter/controller/inventory/inventory_details_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InventoryDetailsHeaderWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<InventoryDetailsController>(
        builder: (final InventoryDetailsController controller) {
      return Column(
        children: <Widget>[
          Gap(kToolbarHeight / 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Inventory Details'.tr,
                style: mullerW500.copyWith(
                  fontSize: 18,
                  color: AppColors.color2E236C,
                ),
              ),
            ],
          ),
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 45),
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.colorD0E4EE.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: <Widget>[
                    Gap(61.0),
                    Text(
                      controller.inventoryDetails?.name ?? '',
                      style: mullerW500.copyWith(
                        fontSize: 20,
                        color: AppColors.color1D1D1D,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(16.0),
                    SizedBox(
                      height: 25,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: (controller.inventoryDetails?.categories ??
                                        <Category>[])
                                    .length >
                                3
                            ? 4
                            : (controller.inventoryDetails?.categories ??
                                    <Category>[])
                                .length,
                        itemBuilder:
                            (final BuildContext context, final int index) {
                          return index < 3
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 4.0),
                                  margin: EdgeInsets.only(right: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                        color: AppColors.colorB1D2E3),
                                  ),
                                  child: Text(
                                    controller.inventoryDetails
                                            ?.categories?[index]
                                            .getName() ??
                                        '',
                                    style: mullerW400.copyWith(
                                        fontSize: 12,
                                        color: AppColors.color12658E),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  margin: EdgeInsets.only(right: 8.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.color12658E,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Text(
                                    '+${(controller.inventoryDetails?.categories ?? <Category>[]).length - 3}',
                                    style: mullerW400.copyWith(
                                        fontSize: 12, color: AppColors.white),
                                  ),
                                );
                        },
                      ),
                    ),
                    Gap(16.0),
                    Divider(
                      height: 1,
                      color: AppColors.colorB1D2E3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Gap(10.0),
                              Text(
                                'No. of Products'.tr,
                                style: mullerW400.copyWith(
                                    fontSize: 12, color: AppColors.color12658E),
                              ),
                              Gap(10.0),
                              Text(
                                (controller.inventoryDetails?.productsCount ??
                                        0)
                                    .toString(),
                                style: mullerW500.copyWith(
                                    color: AppColors.color2E236C),
                              ),
                              Gap(10.0),
                            ],
                          ),
                        ),
                        VerticalDividerWidget(
                          height: 65,
                          color: AppColors.colorB1D2E3,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Gap(10.0),
                              Text(
                                'No. of Orders'.tr,
                                style: mullerW400.copyWith(
                                    fontSize: 12, color: AppColors.color12658E),
                              ),
                              Gap(10.0),
                              Text(
                                (controller.inventoryDetails?.ordersCount ?? 0)
                                    .toString(),
                                style: mullerW500.copyWith(
                                    color: AppColors.color2E236C),
                              ),
                              Gap(10.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(3.43),
                height: 91,
                width: 91,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.colorB1D2E3, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CachedNetworkImage(
                  imageUrl: controller.inventoryDetails?.logo ?? '',
                  imageBuilder: (final BuildContext context,
                          final ImageProvider<Object> imageProvider) =>
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (final BuildContext context, final String url) =>
                      CommonImagePlaceholderImage(),
                  errorWidget: (final BuildContext context, final String url,
                          final Object error) =>
                      CommonImagePlaceholderImage(),
                ),
              )
            ],
          ).marginSymmetric(horizontal: 16.0, vertical: 16),
        ],
      );
    });
  }
}
