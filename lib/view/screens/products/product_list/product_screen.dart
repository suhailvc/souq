import 'package:atobuy_vendor_flutter/controller/product/product_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/tabbar_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/common_button_image.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/add_product_option_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/product_row.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/search_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({final Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<ProductListController>(
            init: ProductListController(
                sharedPref: Get.find(),
                productRepo: Get.find(),
                globalController: Get.find()),
            builder: (final ProductListController controller) {
              return Scaffold(
                appBar: AppbarWithBackIconAndTitle(
                  title: 'Products'.tr,
                ),
                extendBody: true,
                body: Column(
                  children: <Widget>[
                    SearchHeader(
                      onTapFilter: () {
                        FocusScope.of(context).unfocus();
                        Get.toNamed(RouteHelper.productFilter);
                      },
                      onTapSort: () {
                        controller.onTapSort();
                      },
                      textEditController: controller.txtSearchEc,
                      onSubmitSearch: (final String value) {
                        controller.setSearchText(value);
                      },
                      onChangeSearch: (final String value) {
                        controller.setOnChangeSearchText(value);
                      },
                      onClearSearch: () {
                        controller.setSearchText('');
                      },
                    ),
                    TabBarWidget(
                        onTap: (final int index) {},
                        tabController: controller.tabController!,
                        arrTabs: <String>[
                          'All Products'.tr,
                          'Approved'.tr,
                          'Rejected'.tr,
                        ]),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                        children: <Widget>[
                          //All Products Tab
                          Visibility(
                            visible: controller.selectedTabIndex == 0,
                            child: RefreshIndicator(
                              color: AppColors.color2E236C,
                              onRefresh: () => controller.handleRefresh(
                                  controller.allProductPagingController),
                              child: PagedListView<int,
                                  ProductDetailsModel>.separated(
                                padding: EdgeInsets.only(bottom: 100),
                                physics: controller
                                        .allProductPagingController.itemList
                                        .isNotNullOrEmpty()
                                    ? null
                                    : NeverScrollableScrollPhysics(),
                                pagingController:
                                    controller.allProductPagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                    ProductDetailsModel>(
                                  itemBuilder: (final BuildContext context,
                                          final ProductDetailsModel item,
                                          final int index) =>
                                      ProductRow(
                                    productModel: item,
                                    onTapMore: () {
                                      controller.onTapMore(item);
                                    },
                                  ),
                                  firstPageErrorIndicatorBuilder:
                                      (final BuildContext context) {
                                    return NoItemFoundWidget(
                                      image: Assets.svg.icNoProduct,
                                      message: 'No products found!'.tr,
                                    );
                                  },
                                  noItemsFoundIndicatorBuilder:
                                      (final BuildContext context) {
                                    return NoItemFoundWidget(
                                      image: Assets.svg.icNoProduct,
                                      message: 'No products found!'.tr,
                                    );
                                  },
                                ),
                                separatorBuilder: (final BuildContext context,
                                    final int index) {
                                  return Divider(
                                    color: AppColors.colorDFE6E9,
                                    thickness: 1,
                                  );
                                },
                              ),
                            ),
                          ),
                          //Approved Tab
                          Visibility(
                            visible: controller.selectedTabIndex == 1,
                            child: RefreshIndicator(
                              color: AppColors.color2E236C,
                              onRefresh: () => controller.handleRefresh(
                                  controller.approvedProductPagingController),
                              child: PagedListView<int,
                                  ProductDetailsModel>.separated(
                                padding: EdgeInsets.only(bottom: 100),
                                physics: controller
                                        .approvedProductPagingController
                                        .itemList
                                        .isNotNullOrEmpty()
                                    ? null
                                    : NeverScrollableScrollPhysics(),
                                pagingController:
                                    controller.approvedProductPagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                    ProductDetailsModel>(
                                  itemBuilder: (final BuildContext context,
                                          final ProductDetailsModel item,
                                          final int index) =>
                                      ProductRow(
                                    productModel: item,
                                    onTapMore: () {
                                      controller.onTapMore(item);
                                    },
                                  ),
                                  firstPageErrorIndicatorBuilder:
                                      (final BuildContext context) {
                                    return NoItemFoundWidget(
                                      image: Assets.svg.icNoProduct,
                                      message: 'No products found!'.tr,
                                    );
                                  },
                                  noItemsFoundIndicatorBuilder:
                                      (final BuildContext context) {
                                    return NoItemFoundWidget(
                                      image: Assets.svg.icNoProduct,
                                      message: 'No products found!'.tr,
                                    );
                                  },
                                ),
                                separatorBuilder: (final BuildContext context,
                                    final int index) {
                                  return Divider(
                                    color: AppColors.colorDFE6E9,
                                    thickness: 1,
                                  );
                                },
                              ),
                            ),
                          ),
                          //Rejected Tab
                          Visibility(
                            visible: controller.selectedTabIndex == 2,
                            child: RefreshIndicator(
                              color: AppColors.color2E236C,
                              onRefresh: () => controller.handleRefresh(
                                  controller.rejectedProductPagingController),
                              child: PagedListView<int,
                                  ProductDetailsModel>.separated(
                                padding: EdgeInsets.only(bottom: 100),
                                physics: controller
                                        .rejectedProductPagingController
                                        .itemList
                                        .isNotNullOrEmpty()
                                    ? null
                                    : NeverScrollableScrollPhysics(),
                                pagingController:
                                    controller.rejectedProductPagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                    ProductDetailsModel>(
                                  itemBuilder: (final BuildContext context,
                                          final ProductDetailsModel item,
                                          final int index) =>
                                      ProductRow(
                                    productModel: item,
                                    onTapMore: () {
                                      controller.onTapMore(item);
                                    },
                                  ),
                                  firstPageErrorIndicatorBuilder:
                                      (final BuildContext context) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: NoItemFoundWidget(
                                        image: Assets.svg.icNoProduct,
                                        message: 'No products found!'.tr,
                                      ),
                                    );
                                  },
                                  noItemsFoundIndicatorBuilder:
                                      (final BuildContext context) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 50.0),
                                      child: NoItemFoundWidget(
                                        image: Assets.svg.icNoProduct,
                                        message: 'No products found!'.tr,
                                      ),
                                    );
                                  },
                                ),
                                separatorBuilder: (final BuildContext context,
                                    final int index) {
                                  return Divider(
                                    color: AppColors.colorDFE6E9,
                                    thickness: 1,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                bottomNavigationBar: Container(
                  height: 144,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom > 0
                          ? MediaQuery.of(context).padding.bottom
                          : 34),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        AppColors.white.withOpacity(0),
                        AppColors.white,
                        AppColors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: CommonButtonWithImage(
                    margin: EdgeInsets.symmetric(horizontal: 79),
                    onTap: () async {
                      controller.resetImportFileDetail();
                      AddProductOptionBottomSheet.show();
                    },
                    title: 'Add New Product'.tr,
                    backgroundColor: AppColors.color2E236C,
                    suffixWidget: SvgPicture.asset(
                      Assets.svg.icArrowUp,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
