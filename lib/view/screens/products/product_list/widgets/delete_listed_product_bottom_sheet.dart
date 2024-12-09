import 'dart:ui';

import 'package:atobuy_vendor_flutter/controller/product/product_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/bottomsheet/success_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DeleteListedProductBottomSheet extends StatelessWidget {
  const DeleteListedProductBottomSheet({super.key, required this.product});
  final ProductDetailsModel product;
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ProductListController>(
        builder: (final ProductListController controller) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: Get.width,
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
                  Gap(24),
                  SvgPicture.asset(
                    Assets.svg.icDeleteBig,
                    width: 36,
                    height: 36,
                  ),
                  Gap(16),
                  Text(
                    'Are you sure you want to delete?'.tr,
                    style: mullerW400.copyWith(
                      color: AppColors.color171236,
                      fontSize: 18,
                    ),
                  ),
                  Gap(12),
                  _ProductDetailsWidget(product: product),
                  Gap(12),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      child: Text(
                        'Yes, Delete Product'.tr,
                        style: mullerW500.copyWith(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                        controller
                            .deleteProduct(
                                productUUID: product.uuid ?? '',
                                productID: product.id ?? 0)
                            .then((final bool isDeleted) {
                          if (isDeleted) {
                            SuccessBottomSheet.show(
                              title: 'Product deleted successfully.'.tr,
                              onTapContinue: () {},
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colorE52551,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        elevation: 5,
                        shadowColor: AppColors.black,
                      ),
                    ),
                  ),
                  Gap(12),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'No, Don’t Delete'.tr,
                        style: mullerW500.copyWith(
                          fontSize: 16,
                          color: AppColors.color12658E,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(
                          width: 1,
                          color: AppColors.color8ABCD5,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        elevation: 5,
                        shadowColor: AppColors.black,
                      ),
                    ),
                  ),
                  Gap(50),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _ProductDetailsWidget({required final ProductDetailsModel product}) {
    return GetBuilder<ProductListController>(
        builder: (final ProductListController controller) {
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
              imageUrl: product.coverImage?.image ?? '',
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
                    product.title ?? '',
                    style: mullerW500.copyWith(
                      color: AppColors.color171236,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                  ),
                  Text(
                    '${product.currency ?? ''} ${product.price ?? ''}',
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
