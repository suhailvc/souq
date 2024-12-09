import 'package:atobuy_vendor_flutter/controller/order/order_detail_controller.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/user_default_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderByDetail extends StatelessWidget {
  const OrderByDetail({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<OrderDetailController>(
        builder: (final OrderDetailController controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Order By'.tr,
            style:
                mullerW400.copyWith(fontSize: 12, color: AppColors.color12658E),
          ),
          Gap(8.0),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.colorD0E4EE.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl:
                      controller.orderDetails?.orderPlacedBy?.profileImage ??
                          '',
                  imageBuilder: (final BuildContext context,
                      final ImageProvider<Object> imageProvider) {
                    return Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.colorDCE4E7, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (final BuildContext context, final String url) {
                    return Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.colorDCE4E7, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: UserDefaultIcon(size: 30),
                    );
                  },
                  errorWidget: (final BuildContext context, final String url,
                      final Object error) {
                    return Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.colorDCE4E7, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: UserDefaultIcon(size: 30),
                    );
                  },
                ),
                Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        controller.orderDetails?.orderPlacedBy?.fullName ?? '',
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: mullerW500.copyWith(
                            fontSize: 15, color: AppColors.color171236),
                      ),
                      Gap(4),
                      Text(
                        controller.orderDetails?.orderPlacedBy?.email ?? '',
                        style: mullerW400.copyWith(
                            fontSize: 14, color: AppColors.color12658E),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
