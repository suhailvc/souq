import 'package:atobuy_vendor_flutter/controller/product/product_details_controller.dart';
import 'package:atobuy_vendor_flutter/data/request_model/product_bulk_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/readmore.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/login/widgets/error_info_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/common_widget/product_status_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/bottomsheet/create_offer_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/category_sub_category_list_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/on_going_offers_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/product_images_slider_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/product_status_text_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/purchase/purchase_product_details/widgets/product_size_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<ProductDetailsController>(
            initState: (final GetBuilderState<ProductDetailsController> state) {
          Get.find<ProductDetailsController>().initialise();
        }, builder: (final ProductDetailsController controller) {
          return Scaffold(
            appBar: AppbarWithBackIconTitleAndSuffixWidget(
              title: 'Product Details'.tr,
              suffixWidget: controller.productDetails?.status !=
                          ProductApprovalStatus.inReview &&
                      controller.isEditable &&
                      controller.productDetails != null
                  ? IconButton(
                      onPressed: controller.onTapMore,
                      icon: SvgPicture.asset(Assets.svg.icMore),
                    )
                  : SizedBox(),
            ),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: controller.handleDetailsRefresh,
                child: controller.productDetails != null
                    ? Column(
                        children: <Widget>[
                          controller.productDetails?.status !=
                                      ProductApprovalStatus.inReview &&
                                  controller.productDetails?.status !=
                                      ProductApprovalStatus.rejected &&
                                  controller.isEditable
                              ? ProductStatusWidget(
                                  isActive:
                                      controller.productDetails?.isActive ??
                                          false,
                                  onChangeStatus: (final bool value) {
                                    controller.toggleProductStatus(value);
                                  },
                                )
                              : SizedBox(
                                  height: 16,
                                ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Visibility(
                                    visible: controller
                                        .productDetails!.rejectedReason
                                        .isNotNullAndEmpty(),
                                    child: ErrorInfoView(
                                      message: controller
                                              .productDetails?.rejectedReason ??
                                          '',
                                    ).paddingOnly(
                                        left: 16, right: 16, bottom: 10),
                                  ),
                                  ProductImagesSliderWidget(
                                    productImageList:
                                        controller.productDetails?.images ??
                                            <Images>[],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ReadMoreText(
                                        controller.productDetails
                                                ?.getProductTitle() ??
                                            '-',
                                        trimMode: TrimMode.line,
                                        trimLines: 3,
                                        colorClickableText:
                                            AppColors.colorE72351,
                                        trimCollapsedText: 'Show more'.tr,
                                        trimExpandedText:
                                            '   ' + 'Show less'.tr,
                                        style: mullerW500.copyWith(
                                          fontSize: 18,
                                          color: AppColors.color171236,
                                        ),
                                        moreStyle: mullerW400.copyWith(
                                          fontSize: 14,
                                          color: AppColors.colorE72351,
                                        ),
                                        lessStyle: mullerW400.copyWith(
                                          fontSize: 14,
                                          color: AppColors.colorE72351,
                                        ),
                                      ),
                                      Gap(20),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            controller.productDetails
                                                    ?.getActualPrice() ??
                                                '0.00 ${controller.productDetails?.currency ?? AppConstants.defaultCurrency}',
                                            style: mullerW500.copyWith(
                                              fontSize: 18,
                                              color: AppColors.color171236,
                                            ),
                                          ),
                                          Gap(8),
                                          Text(
                                            '(Per Piece)'.tr,
                                            style: mullerW500.copyWith(
                                              fontSize: 12,
                                              color: AppColors.color0B3D56,
                                            ),
                                          ),
                                          Spacer(),
                                          ProductStatusTextWidget(
                                            status: controller
                                                .productDetails?.status,
                                          ),
                                        ],
                                      ),
                                      Gap(24),
                                      Divider(
                                        color: AppColors.colorB1D2E3,
                                        height: 1,
                                      ),
                                      Gap(16),
                                      Text(
                                        'Description'.tr,
                                        style: mullerW500.copyWith(
                                          color: AppColors.color677A81,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Gap(8),
                                      ReadMoreText(
                                        controller.productDetails
                                                ?.getProductDescription() ??
                                            '-',
                                        trimMode: TrimMode.line,
                                        trimLines: 4,
                                        colorClickableText:
                                            AppColors.color171236,
                                        trimCollapsedText: 'Show more'.tr,
                                        trimExpandedText:
                                            '   ' + 'Show less'.tr,
                                        style: mullerW400.copyWith(
                                          color: AppColors.color171236,
                                          fontSize: 14,
                                        ),
                                        moreStyle: mullerW400.copyWith(
                                          color: AppColors.colorE72351,
                                          fontSize: 12,
                                        ),
                                        lessStyle: mullerW400.copyWith(
                                          color: AppColors.colorE72351,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Gap(16),
                                      Divider(
                                        color: AppColors.colorB1D2E3,
                                        height: 1,
                                      ),
                                      Gap(16),
                                      Text(
                                        'Product Store'.tr,
                                        style: mullerW400.copyWith(
                                          color: AppColors.color677A81,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Gap(8),
                                      Text(
                                        controller.productDetails?.storeName ??
                                            '',
                                        style: mullerW500.copyWith(
                                          color: AppColors.color171236,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Gap(16),
                                      Visibility(
                                        visible: (controller
                                                    .productDetails?.sizeData ??
                                                <ProductSizeModel>[])
                                            .isNotEmpty,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(
                                              color: AppColors.colorB1D2E3,
                                              height: 1,
                                            ),
                                            Gap(16),
                                            Text(
                                              'Product Sizes'.tr,
                                              style: mullerW400.copyWith(
                                                color: AppColors.color677A81,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Gap(16),
                                            ProductSizeSelectionWidget(
                                              sizeData: controller
                                                      .productDetails
                                                      ?.sizeData ??
                                                  <ProductSizeModel>[],
                                            ),
                                            Gap(16),
                                            Divider(
                                              color: AppColors.colorB1D1D3,
                                              height: 1,
                                            ),
                                            Gap(16),
                                          ],
                                        ),
                                      ),
                                      CategorySubCategoryWidget(
                                        category:
                                            controller.productDetails?.category,
                                        title: 'Category'.tr,
                                      ),
                                      CategorySubCategoryWidget(
                                        title: 'Sub Category'.tr,
                                        category: controller
                                            .productDetails?.subCategory,
                                      ),
                                      if ((controller.productDetails?.barcode ??
                                              '')
                                          .isNotNullAndEmpty())
                                        CategorySubCategoryWidget(
                                          title: 'Barcode Number'.tr,
                                          category: Category(
                                              name: controller
                                                  .productDetails?.barcode),
                                        ),
                                      Visibility(
                                        visible: (controller
                                                .productDetails?.brand?.title
                                                .isNotNullAndEmpty() ??
                                            false),
                                        child: CategorySubCategoryWidget(
                                          title: 'Brand'.tr,
                                          category: Category(
                                              name: controller.productDetails
                                                      ?.brand?.title ??
                                                  ''),
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.isEditable,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    'Minimum Order \nQuantity'
                                                        .tr,
                                                    style: mullerW400.copyWith(
                                                      color:
                                                          AppColors.color677A81,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '${controller.productDetails?.minimumOrderQuantity ?? ''}',
                                                  style: mullerW500.copyWith(
                                                    color:
                                                        AppColors.color171236,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Gap(16),
                                            Divider(
                                              color: AppColors.colorB1D2E3,
                                              height: 1,
                                            ),
                                            Gap(16),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Inventory Level'.tr,
                                            style: mullerW400.copyWith(
                                              color: AppColors.color677A81,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '${controller.productDetails?.quantity ?? ''} pcs.',
                                            style: mullerW500.copyWith(
                                              color: AppColors.color171236,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(16),
                                      Divider(
                                        color: AppColors.colorB1D2E3,
                                        height: 1,
                                      ),
                                      Gap(16),
                                      Visibility(
                                        visible:
                                            controller.isOnGoingOfferVisible(),
                                        child: OnGoingOffersWidget(
                                          onClickedAddOffer: () {
                                            Get.bottomSheet(
                                              CreateOfferBottomSheet(),
                                              barrierColor: AppColors
                                                  .colorE8EBEC
                                                  .withOpacity(0.85),
                                              isScrollControlled: true,
                                            );
                                          },
                                        ),
                                      ),
                                      Gap(32),
                                    ],
                                  ).paddingSymmetric(
                                      horizontal: 16, vertical: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : controller.isLoading
                        ? SizedBox()
                        : NoItemFoundWidget(
                            image: Assets.svg.icNoProduct,
                            message: 'No Details Found.'.tr),
              ),
            ),
          );
        }),
      ),
    );
  }
}
