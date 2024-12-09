import 'package:atobuy_vendor_flutter/controller/product/product_details_controller.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductBottomSheetItemWidget extends StatelessWidget {
  const ProductBottomSheetItemWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ProductDetailsController>(
        builder: (final ProductDetailsController controller) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.colorE8EBEC,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CachedNetworkImage(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              imageUrl: controller.getProductImage(),
              imageBuilder: (final BuildContext context,
                  final ImageProvider<Object> imageProvider) {
                return Container(
                  width: 73,
                  height: 73,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                    border: Border.all(
                      color: AppColors.colorB1D2E3,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              },
              errorWidget: (final BuildContext context, final String url,
                  final Object error) {
                return SizedBox(
                  width: 73,
                  height: 73,
                  child: CommonImagePlaceholderWidget(),
                );
              },
              placeholder: (final BuildContext context, final String url) {
                return SizedBox(
                  width: 73,
                  height: 73,
                  child: CommonImagePlaceholderWidget(),
                );
              },
            ),
            Gap(12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    controller.productDetails?.title ?? '',
                    style: mullerW500.copyWith(
                      color: AppColors.color171236,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                  ),
                  Text(
                    '${controller.productDetails?.currency ?? ''} ${controller.productDetails?.price ?? ''}',
                    style: mullerW500.copyWith(
                      color: AppColors.color171236,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
