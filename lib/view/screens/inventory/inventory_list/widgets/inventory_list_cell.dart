import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InventoryListCell extends StatelessWidget {
  InventoryListCell(
      {super.key, required this.onSelectInventory, required this.inventory});

  final StoreModel inventory;
  final VoidCallback onSelectInventory;

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: onSelectInventory,
      child: Row(
        children: <Widget>[
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              border: Border.all(color: AppColors.colorB1D2E3),
            ),
            child: CachedNetworkImage(
              imageUrl: inventory.logo ?? '',
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
          ),
          Gap(12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  inventory.name ?? '',
                  style: mullerW500.copyWith(
                      fontSize: 15, color: AppColors.color171236),
                ),
                Gap(5.0),
                SizedBox(
                  height: 25,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: (inventory.categories ?? <Category>[]).length > 3
                        ? 4
                        : (inventory.categories ?? <Category>[]).length,
                    itemBuilder: (final BuildContext context, final int index) {
                      return index < 3
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 4.0),
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border:
                                    Border.all(color: AppColors.colorB1D2E3),
                              ),
                              child: Text(
                                (inventory.categories ?? <Category>[])
                                        .isNotEmpty
                                    ? inventory.categories![index].getName()
                                    : '',
                                style: mullerW400.copyWith(
                                    fontSize: 12, color: AppColors.color12658E),
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
                                '+${(inventory.categories ?? <Category>[]).length - 3}',
                                style: mullerW400.copyWith(
                                    fontSize: 12, color: AppColors.white),
                              ),
                            );
                    },
                  ),
                ),
                Gap(5.0),
                Row(
                  children: <Widget>[
                    Text(
                      '${'No of Products'.tr} : ',
                      style: mullerW400.copyWith(
                          fontSize: 12, color: AppColors.color12658E),
                    ),
                    Text(
                      '${inventory.productsCount ?? 0}',
                      style: mullerW500.copyWith(
                          fontSize: 12, color: AppColors.color2E236C),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.0, vertical: 12.0),
    );
  }
}
