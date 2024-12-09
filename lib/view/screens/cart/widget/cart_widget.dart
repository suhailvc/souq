import 'package:atobuy_vendor_flutter/controller/cart/cart_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/cart_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/view/screens/cart/widget/cart_row.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<CartController>(
        builder: (final CartController controller) {
      return PagedListView<int, VendorModel>.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        pagingController: controller.cartListController,
        builderDelegate: PagedChildBuilderDelegate<VendorModel>(
          itemBuilder: (final BuildContext context, final VendorModel item,
                  final int index) =>
              CartRow(
            vendorModel: item,
            cartModel: controller.cartModel,
            onIncreaseQty: (final ProductItem product) {
              controller.updateCart(product);
            },
            onDecreaseQty: (final ProductItem product, final bool isDelete) {
              if (isDelete) {
                controller.onTapRemoveFromBag(product: product);
              } else {
                controller.decreaseCartQty(product, isDelete);
              }
            },
            onUpdateQty: (final ProductItem product, final int updatedQty) {
              controller.updateCartWithQuantity(product, updatedQty);
            },
          ),
          firstPageErrorIndicatorBuilder: (final BuildContext context) {
            return _noDataFoundWidget();
          },
          noItemsFoundIndicatorBuilder: (final BuildContext context) {
            return _noDataFoundWidget();
          },
        ),
        separatorBuilder: (final BuildContext context, final int index) {
          return SizedBox(
            height: 12,
          );
        },
      );
    });
  }

  Widget _noDataFoundWidget() {
    return NoItemFoundWidget(
      image: Assets.svg.icNoProduct,
      message: 'Your cart is empty'.tr,
    );
  }
}
