import 'package:atobuy_vendor_flutter/data/request_model/product_bulk_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/login/widgets/error_info_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/cart/widget/store_vendor_name_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CustomerOrderDetails extends StatelessWidget {
  const CustomerOrderDetails({
    super.key,
    required this.subOrders,
  });

  final List<OrderDetailsModel> subOrders;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Gap(16.0),
        Text(
          'Order Details'.tr,
          style:
              mullerW400.copyWith(fontSize: 12, color: AppColors.color12658E),
        ).paddingSymmetric(horizontal: 5),
        Gap(8.0),
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          separatorBuilder: (final BuildContext context, final int index) {
            return Divider(
              height: 1,
              color: AppColors.colorB1D2E3,
            ).paddingSymmetric(vertical: 16);
          },
          itemCount: subOrders.length,
          itemBuilder: (final BuildContext context, final int index) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.colorD0E4EE.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      StoreVendorNameWidget(
                        storeName: subOrders[index].getStoreName(),
                        vendorName: subOrders[index].vendorName,
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Utility.getOrderStatusColor(
                              subOrders[index].orderStatus),
                        ),
                        child: Text(
                          subOrders[index].orderStatus?.title ?? '',
                          style: mullerW500.copyWith(
                              fontSize: 12, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  Gap(12.0),
                  Visibility(
                    visible:
                        subOrders[index].cancelReason?.isNotNullAndEmpty() ??
                            false,
                    child: ErrorInfoView(
                      message: subOrders[index].cancelReason ?? '',
                    ),
                  ),
                  _subItems(subOrders[index].items ?? <OrderedItem>[]),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget _subItems(final List<OrderedItem> order) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      separatorBuilder: (final BuildContext context, final int index) {
        return Divider(
          height: 1,
          color: AppColors.colorB1D2E3,
        );
      },
      itemCount: order.length,
      itemBuilder: (final BuildContext context, final int index) {
        return _orderRowItem(order[index]);
      },
    );
  }

  Widget _orderRowItem(final OrderedItem order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 48,
              height: 48,
              child: CachedNetworkImage(
                  imageUrl: order.product?.coverImage?.image ?? '',
                  imageBuilder: (final BuildContext context,
                          final ImageProvider<Object> imageProvider) =>
                      Container(
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
                  placeholder: (final BuildContext context, final String url) =>
                      _productPlaceHolder(),
                  errorWidget: (final BuildContext context, final String url,
                          final Object error) =>
                      _productPlaceHolder()),
            ),
            Gap(12.0),
            Expanded(
              child: Text(
                maxLines: 2,
                softWrap: true,
                order.metadata?.productName ?? '',
                style: mullerW500.copyWith(
                    color: AppColors.color1D1D1D, fontSize: 15),
              ),
            )
          ],
        ),
        Gap(12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Qty.'.tr,
                  style: mullerW500.copyWith(
                      fontSize: 12, color: AppColors.color12658E),
                ),
                Gap(10.0),
                Text(
                  (order.product?.sizeData ?? <ProductSizeModel>[])
                          .isNotNullOrEmpty()
                      ? '${order.size?.unit ?? ''}  X  ${order.qty ?? 0}'
                      : '${order.qty ?? 0}',
                  style: mullerW500.copyWith(
                      fontSize: 12, color: AppColors.color171236),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Price'.tr,
                  style: mullerW500.copyWith(
                      fontSize: 12, color: AppColors.color12658E),
                ),
                Gap(10.0),
                Visibility(
                  visible: (order.metadata?.offerPrice ?? 0.00) > 0 &&
                      order.product?.sizeData == null,
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    order.getProductPriceWithoutOffer(),
                    style: mullerW400.copyWith(
                        fontSize: 12,
                        color: AppColors.color1D1D1D,
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
                Text(
                  order.getProductPrice(),
                  style: mullerW500.copyWith(
                      fontSize: 12, color: AppColors.color171236),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Total'.tr,
                  style: mullerW500.copyWith(
                      fontSize: 12, color: AppColors.color12658E),
                ),
                Gap(10.0),
                Text(
                  order.getTotalProductPrice(),
                  style: mullerW500.copyWith(
                      fontSize: 12, color: AppColors.color171236),
                ),
              ],
            ),
          ],
        )
      ],
    ).paddingSymmetric(vertical: 12);
  }

  Widget _productPlaceHolder() {
    return CommonImagePlaceholderWidget(
      borderRadius: BorderRadius.circular(12.0),
    );
  }
}
