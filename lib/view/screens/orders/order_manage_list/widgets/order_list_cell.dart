import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/user_default_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderListCell extends StatelessWidget {
  const OrderListCell({
    super.key,
    required this.order,
    this.isCustomerOrder = false,
    required this.onTapOrder,
    required this.onTapMore,
  });

  final OrderDetailsModel order;
  final VoidCallback onTapOrder;
  final VoidCallback onTapMore;
  final bool isCustomerOrder;
  @override
  Widget build(final BuildContext context) {
    final OrderedItem? orderItem = isCustomerOrder
        ? this.order.getFirstItemFromSubOrders()
        : this.order.getFirstItemFromItems();
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTapOrder,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '${'ID'.tr} : ',
                  style: mullerW400.copyWith(
                      fontSize: 12, color: AppColors.color12658E),
                ),
                Text(
                  order.orderId ?? '',
                  style: mullerW500.copyWith(
                      fontSize: 12, color: AppColors.color0B3D56),
                ),
                Spacer(),
                Container(
                  width: 67,
                  height: 16,
                  alignment: Alignment.center,
                  child: Text(
                    order.orderStatus?.title ?? '',
                    style: mullerW500.copyWith(
                        fontSize: 11, color: AppColors.white),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: order.orderStatus != null
                        ? Utility.getOrderStatusColor(order.orderStatus!)
                        : AppColors.color12658E,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Gap(8),
                    GestureDetector(
                      onTap: onTapMore,
                      child: SvgPicture.asset(
                        Assets.svg.icMore,
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gap(8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.colorD0E4EE.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
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
                                isCustomerOrder ? 'Items'.tr : 'Qty.'.tr,
                                style: mullerW400.copyWith(
                                    fontSize: 10, color: AppColors.white),
                              ),
                              Text(
                                isCustomerOrder
                                    ? '${order.getItemCountFromSubOrders()}'
                                    : ('${order.items?.first.qty ?? '0'}'),
                                style: mullerW500.copyWith(
                                    fontSize: 15, color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                        Gap(12),
                        Expanded(
                          child: Text(
                            orderItem?.getVendorProductName() ?? '',
                            style: mullerW500.copyWith(
                                fontSize: 15, color: AppColors.color171236),
                            maxLines: 3,
                            softWrap: true,
                          ),
                        ),
                        Gap(12.0),
                        Text(
                          order.getOrderTotalWithCurrency(),
                          style: mullerW500.copyWith(
                              fontSize: 15, color: AppColors.color171236),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !isCustomerOrder,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Divider(
                          height: 1.0,
                          color: AppColors.colorB1D1D3,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Order Placed By'.tr,
                              style: mullerW400.copyWith(
                                fontSize: 12,
                                color: AppColors.color12658E,
                              ),
                            ),
                            Spacer(),
                            CachedNetworkImage(
                              imageUrl: order.orderPlacedBy?.profileImage ?? '',
                              imageBuilder: (final BuildContext context,
                                  final ImageProvider<Object> imageProvider) {
                                return Container(
                                  padding: EdgeInsets.all(1),
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.color12658E, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7.5),
                                    child: Image(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              errorWidget: (final BuildContext context,
                                  final String url, final Object error) {
                                return Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.color12658E, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: UserDefaultIcon(size: 13),
                                );
                              },
                            ),
                            Gap(3),
                            Text(
                              order.orderPlacedByName ?? '',
                              style: mullerW500.copyWith(
                                  fontSize: 12, color: AppColors.color0B3D56),
                            ),
                          ],
                        ).paddingAll(8.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Gap(8),
            Row(
              children: <Widget>[
                Text(
                  'Payment :'.tr,
                  style: mullerW400.copyWith(
                      fontSize: 12, color: AppColors.color12658E),
                ),
                Gap(3),
                SvgPicture.asset(Assets.svg.icOnlinePayment),
                Gap(3),
                Text(
                  order.paymentMode ?? '',
                  style: mullerW500.copyWith(
                      fontSize: 12, color: AppColors.color2E236C),
                ),
                Spacer(),
                Text(
                  'Date :'.tr,
                  style: mullerW400.copyWith(
                      fontSize: 12, color: AppColors.color12658E),
                ),
                Gap(3),
                Text(
                  order.created.formatDDMMYY(),
                  style: mullerW500.copyWith(
                      fontSize: 12, color: AppColors.color2E236C),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
