import 'package:atobuy_vendor_flutter/controller/purchase/purchase_product_details_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/widget/store_product_row.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class MoreItemsWidget extends StatelessWidget {
  MoreItemsWidget({required this.tag});
  final String tag;

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<PurchaseProductDetailsController>(
      tag: tag,
      builder: (final PurchaseProductDetailsController controller) {
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add more items'.tr,
                  style: mullerW700.copyWith(
                      fontSize: 18, color: AppColors.color1D1D1D),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(
                      RouteHelper.searchProductList,
                      preventDuplicates: false,
                      arguments: <String, dynamic>{
                        'product': controller.productDetails
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerRight,
                  ),
                  child: Text(
                    'See All'.tr,
                    style: mullerW400.copyWith(
                        fontSize: 12, color: AppColors.color3D8FB9),
                  ),
                ),
              ],
            ),
            Gap(16.0),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 164 / 225,
              ),
              itemCount: controller.arrSimilarProducts.length,
              itemBuilder: (final BuildContext context, final int index) {
                return StoreProductRow(
                  productModel: controller.arrSimilarProducts[index],
                  onProductClick: (final ProductDetailsModel productModel) {
                    Get.toNamed(
                      preventDuplicates: false,
                      RouteHelper.getProductDetailRoute(productModel.uuid),
                      arguments: <String, dynamic>{
                        'uuid': productModel.uuid,
                        'product_id': productModel.id ?? '',
                      },
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
