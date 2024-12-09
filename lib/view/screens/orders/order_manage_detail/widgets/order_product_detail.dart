import 'package:atobuy_vendor_flutter/controller/order/order_detail_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderProductDetail extends StatelessWidget {
  const OrderProductDetail({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<OrderDetailController>(
        builder: (final OrderDetailController controller) {
      final OrderedItem? selectedProduct =
          (controller.orderDetails?.items ?? <OrderedItem>[]).length >
                  controller.selectedProductIndex
              ? controller.orderDetails?.items![controller.selectedProductIndex]
              : null;
      final Metadata? metaData = selectedProduct?.metadata;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Product Ordered'.tr,
            style:
                mullerW400.copyWith(fontSize: 12, color: AppColors.color12658E),
          ),
          Gap(8.0),
          Container(
            decoration: BoxDecoration(
              color: AppColors.colorD0E4EE.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Gap(12),
                SizedBox(
                  height: 74,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        (controller.orderDetails?.items ?? <OrderedItem>[])
                            .length,
                    itemBuilder: (final BuildContext context, final int index) {
                      final Images? coverImage =
                          (controller.orderDetails?.items ??
                                  <OrderedItem>[])[index]
                              .product
                              ?.coverImage;

                      return GestureDetector(
                        onTap: () {
                          controller.selectedProductIndex = index;
                          controller.update();
                        },
                        child: CachedNetworkImage(
                            imageUrl: coverImage?.image ?? '',
                            imageBuilder: (final BuildContext context,
                                    final ImageProvider<Object>
                                        imageProvider) =>
                                AspectRatio(
                                  aspectRatio: 74 / 74,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(7.0),
                                      ),
                                      border: Border.all(
                                        color:
                                            controller.selectedProductIndex ==
                                                    index
                                                ? AppColors.colorB1D2E3
                                                : Colors.transparent,
                                      ),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                            placeholder: (final BuildContext context,
                                    final String url) =>
                                _productPlaceHolder(controller, index),
                            errorWidget: (final BuildContext context,
                                    final String url, final Object error) =>
                                _productPlaceHolder(controller, index)),
                      );
                    },
                    separatorBuilder:
                        (final BuildContext context, final int index) {
                      return Gap(10);
                    },
                  ),
                ).paddingSymmetric(horizontal: 8),
                Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 48,
                      width: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.color2E236C,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Qty.'.tr,
                            style: mullerW400.copyWith(
                                fontSize: 10, color: AppColors.white),
                          ),
                          Text(
                            '${selectedProduct?.qty ?? 0}',
                            style: mullerW500.copyWith(
                                fontSize: 15, color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                    Gap(12),
                    Expanded(
                      child: Text(
                        selectedProduct?.getVendorProductName() ?? '',
                        style: mullerW500.copyWith(
                            fontSize: 15, color: AppColors.color171236),
                        maxLines: 3,
                        softWrap: true,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Visibility(
                          visible: (metaData?.offerPrice ?? 0.00) > 0 &&
                              selectedProduct?.size == null,
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            selectedProduct?.getProductPriceWithoutOffer() ??
                                '',
                            style: mullerW400.copyWith(
                                fontSize: 14,
                                color: AppColors.color1D1D1D,
                                decoration: TextDecoration.lineThrough),
                          ).paddingSymmetric(horizontal: 12.0),
                        ),
                        Text(
                          selectedProduct?.getProductPrice() ?? '',
                          style: mullerW500.copyWith(
                              fontSize: 15, color: AppColors.color171236),
                        ),
                      ],
                    ).paddingOnly(left: 10),
                  ],
                ).paddingSymmetric(horizontal: 8),
                Gap(12),
                Divider(
                  height: 1.0,
                  color: AppColors.colorB1D1D3,
                ),
                Gap(11),
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      RouteHelper.productDetails,
                      arguments: <String, dynamic>{
                        'product': selectedProduct?.product,
                        'come_from': 'order',
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Go To Product Details'.tr,
                        style: mullerW400.copyWith(
                            fontSize: 12, color: AppColors.color12658E),
                      ),
                      Gap(12),
                      SvgPicture.asset(
                        Assets.svg.icRightArrowRound,
                        colorFilter: ColorFilter.mode(
                            AppColors.color12658E, BlendMode.srcIn),
                      ),
                    ],
                  ),
                ),
                Gap(11),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _productPlaceHolder(
      final OrderDetailController controller, final int index) {
    return AspectRatio(
      aspectRatio: 74 / 74,
      child: CommonImagePlaceholderWidget(
        padding: EdgeInsets.all(10),
        borderRadius: BorderRadius.circular(12.0),
        backgroundColor: AppColors.white,
        border: Border.all(
          color: controller.selectedProductIndex == index
              ? AppColors.color8ABCD5
              : Colors.transparent,
        ),
      ),
    );
  }
}
