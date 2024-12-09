import 'package:atobuy_vendor_flutter/controller/shop_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/widget/store_category_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class StoreCategoryWidget extends StatelessWidget {
  const StoreCategoryWidget({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ShopController>(
        builder: (final ShopController controller) {
      return PagedGridView<int, Category>(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 100, left: 16, right: 16),
        shrinkWrap: true,
        pagingController: controller.categoryListController,
        builderDelegate: PagedChildBuilderDelegate<Category>(
          itemBuilder: (final BuildContext context, final Category item,
                  final int index) =>
              StoreCategoryCell(
                  category: item,
                  onTapCategory: (final Category category) {
                    Get.toNamed(RouteHelper.storeProductList,
                        arguments: <String, dynamic>{'category': category});
                  }),
          firstPageErrorIndicatorBuilder: (final BuildContext context) {
            return NoItemFoundWidget(
              image: Assets.svg.icNoProduct,
              message: 'No Items found!'.tr,
            );
          },
          noItemsFoundIndicatorBuilder: (final BuildContext context) {
            return NoItemFoundWidget(
              image: Assets.svg.icNoProduct,
              message: 'No Items found!'.tr,
            );
          },
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 109 / 130,
        ),
      );
    });
  }
}
