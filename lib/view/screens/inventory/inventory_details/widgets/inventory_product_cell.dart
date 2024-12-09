import 'package:atobuy_vendor_flutter/data/response_models/inventory/inventory_details_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InventoryProductCell extends StatelessWidget {
  const InventoryProductCell(
      {super.key, required this.product, required this.onSelectProduct});

  final InventoryProduct product;
  final VoidCallback onSelectProduct;
  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: onSelectProduct,
      child: Row(
        children: <Widget>[
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.colorD0E4EE, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: product.coverImage?.image ?? '',
              imageBuilder: (final BuildContext context,
                  final ImageProvider<Object> imageProvider) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                );
              },
              errorWidget: (final BuildContext context, final String url,
                  final Object error) {
                return _placeholder();
              },
              placeholder: (
                final BuildContext context,
                final String url,
              ) {
                return _placeholder();
              },
            ),
          ),
          Gap(12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.title ?? '',
                  style: mullerW400.copyWith(
                    color: AppColors.color171236,
                  ),
                ),
                Gap(8.0),
                RichText(
                  text: TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: '${'Quantity'.tr} :',
                        style: mullerW400.copyWith(
                            color: AppColors.color12658E, fontSize: 13.0),
                      ),
                      TextSpan(
                        text: '${product.quantity ?? 0}',
                        style: mullerW500.copyWith(
                            color: AppColors.color171236, fontSize: 13.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ).marginSymmetric(horizontal: 16.0, vertical: 12),
    );
  }

  Widget _placeholder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Assets.images.splashLogo.image(color: AppColors.colorD0E4EE),
    ).paddingAll(3.43);
  }
}
