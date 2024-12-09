import 'dart:math';

import 'package:atobuy_vendor_flutter/controller/inventory/inventory_details_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/inventory/inventory_details_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/screens/inventory/inventory_details/widgets/inventory_flexible_space_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/inventory/inventory_details/widgets/inventory_product_cell.dart';
import 'package:atobuy_vendor_flutter/view/screens/inventory/inventory_details/widgets/inventory_product_search_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class InventoryDetailsScreen extends StatelessWidget {
  const InventoryDetailsScreen({super.key});
  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: GetBuilder<InventoryDetailsController>(
                init: InventoryDetailsController(inventoryRepo: Get.find()),
                builder: (final InventoryDetailsController controller) {
                  return controller.inventoryDetails != null
                      ? CustomScrollView(
                          slivers: <Widget>[
                            SliverAppBar(
                              pinned: true,
                              expandedHeight: 340.0,
                              collapsedHeight: 56,
                              leading: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: SvgPicture.asset(
                                  Assets.svg.icBack,
                                  matchTextDirection: true,
                                ),
                              ),
                              backgroundColor: AppColors.white,
                              flexibleSpace: LayoutBuilder(builder:
                                  (final BuildContext context,
                                      final BoxConstraints constraints) {
                                final double top = constraints.biggest.height;
                                return InventoryFlexibleSpaceBar(
                                  topHeight: top,
                                );
                              }),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              delegate: _SliverAppBarDelegate(
                                minHeight: 56.0,
                                maxHeight: 56.0,
                                child: InventoryProductSearchWidget(
                                  txtSearchProduct: controller.txtSearchProduct,
                                  onSubmitSearch: (final String text) {
                                    controller.setSearchProductText(text: text);
                                  },
                                  onChangeSearchText: (final String text) {
                                    controller.txtSearchProduct.text = text;
                                    controller.update();
                                  },
                                ),
                              ),
                            ),
                            (controller.inventoryDetails?.products ??
                                        <InventoryProduct>[])
                                    .isNotEmpty
                                ? SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (final BuildContext context,
                                          final int index) {
                                        return InventoryProductCell(
                                          product: controller.inventoryDetails
                                                  ?.products?[index] ??
                                              InventoryProduct(),
                                          onSelectProduct: () {
                                            Get.toNamed(
                                              RouteHelper.productDetails,
                                              arguments: <String, dynamic>{
                                                'product': controller
                                                    .inventoryDetails
                                                    ?.products?[index],
                                              },
                                            );
                                          },
                                        );
                                      },
                                      childCount: controller.inventoryDetails
                                              ?.products?.length ??
                                          0,
                                    ),
                                  )
                                : SliverFillRemaining(
                                    child: NoItemFoundWidget(
                                      image: Assets.svg.icNoProduct,
                                      message: 'No products found!'.tr,
                                    ),
                                  ),
                          ],
                        )
                      : SizedBox();
                }),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(final BuildContext context, final double shrinkOffset,
      final bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(final _SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
