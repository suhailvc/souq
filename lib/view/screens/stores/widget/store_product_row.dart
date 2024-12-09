import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StoreProductRow extends StatelessWidget {
  const StoreProductRow(
      {super.key, required this.productModel, required this.onProductClick});

  final ProductDetailsModel productModel;
  final Function(ProductDetailsModel) onProductClick;

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => onProductClick(productModel),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: AppColors.white,
          border: Border.all(
            color: AppColors.colorB1D2E3,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: productModel.coverImage?.image ?? '',
              imageBuilder: (final BuildContext context,
                      final ImageProvider<Object> imageProvider) =>
                  AspectRatio(
                aspectRatio: 109 / 85,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              placeholder: (final BuildContext context, final String url) =>
                  _placeholder(),
              errorWidget: (final BuildContext context, final String url,
                      final Object error) =>
                  _placeholder(),
            ),
            Gap(8),
            Text(
              productModel.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: mullerW400.copyWith(
                  fontSize: 14, color: AppColors.color1D1D1D),
            ).paddingSymmetric(horizontal: 12.0),
            Gap(10.0),
            Visibility(
              visible: (productModel.offerPrice ?? 0.00) > 0,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  productModel.getActualPrice(),
                  style: mullerW400.copyWith(
                      fontSize: 14,
                      color: AppColors.color1D1D1D,
                      decoration: TextDecoration.lineThrough),
                ).paddingSymmetric(horizontal: 12.0),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                productModel.getPrice(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: mullerW500.copyWith(
                    fontSize: 14, color: AppColors.color1D1D1D),
              ).paddingSymmetric(horizontal: 12.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return AspectRatio(
      aspectRatio: 109 / 85,
      child: CommonImagePlaceholderWidget(
        backgroundColor: AppColors.color666666.withOpacity(0.05),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
