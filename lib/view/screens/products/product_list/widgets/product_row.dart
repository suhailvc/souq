import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductRow extends StatelessWidget {
  const ProductRow(
      {super.key, required this.productModel, required this.onTapMore});

  final ProductDetailsModel productModel;
  final VoidCallback onTapMore;

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.productDetails,
            arguments: <String, dynamic>{'product': productModel});
      },
      child: SizedBox(
        height: 99,
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: productModel.coverImage?.image ?? '',
              imageBuilder: (final BuildContext context,
                      final ImageProvider<Object> imageProvider) =>
                  AspectRatio(
                aspectRatio: 73 / 73,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: AppColors.white,
                    border: Border.all(
                      color: AppColors.colorB1D2E3,
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              placeholder: (final BuildContext context, final String url) =>
                  AspectRatio(
                aspectRatio: 73 / 73,
                child: CommonImagePlaceholderWidget(
                  padding: EdgeInsets.all(10),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: AppColors.colorB1D2E3,
                  ),
                ),
              ),
              errorWidget: (final BuildContext context, final String url,
                      final Object error) =>
                  AspectRatio(
                aspectRatio: 73 / 73,
                child: CommonImagePlaceholderWidget(
                  padding: EdgeInsets.all(10),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: AppColors.colorB1D2E3,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        productModel.getProductTitle(),
                        style: mullerW500.copyWith(
                            fontSize: 16, color: AppColors.color171236),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ).paddingSymmetric(horizontal: 15.0),
                    ),
                    productModel.status != ProductApprovalStatus.inReview
                        ? IconButton(
                            padding: EdgeInsets.all(0),
                            alignment: Alignment.topCenter,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            style: IconButton.styleFrom(
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.all(0),
                                iconSize: 16),
                            onPressed: onTapMore,
                            icon: SvgPicture.asset(
                              Assets.svg.icMore,
                              height: 16,
                              width: 16,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        productModel.getActualPrice(),
                        style: mullerW500.copyWith(
                            fontSize: 16, color: AppColors.color171236),
                      ).paddingSymmetric(horizontal: 10),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Utility.getProductStatusColor(
                            productModel.status?.key ?? ''),
                      ),
                      child: Text(
                        productModel.status?.title ?? '',
                        style: mullerW500.copyWith(
                            fontSize: 11, color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ))
          ],
        ).marginSymmetric(horizontal: 16, vertical: 13),
      ),
    );
  }
}
