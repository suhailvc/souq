import 'package:atobuy_vendor_flutter/controller/order/order_detail_controller.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/user_default_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderDriverDetail extends StatelessWidget {
  const OrderDriverDetail({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<OrderDetailController>(
        builder: (final OrderDetailController controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gap(16),
          Text(
            'Assigned Driver'.tr,
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
                  imageUrl: controller.orderDetails?.driver?.profileImage ?? '',
                  imageBuilder: (final BuildContext context,
                      final ImageProvider<Object> imageProvider) {
                    return SizedBox(
                      height: 48,
                      width: 48,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (final BuildContext context, final String url) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: UserDefaultAvatar(),
                    );
                  },
                  errorWidget: (final BuildContext context, final String url,
                      final Object error) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: UserDefaultAvatar(),
                    );
                  },
                ),
                Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        controller.orderDetails?.driver?.name ?? '',
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: mullerW500.copyWith(
                            fontSize: 15, color: AppColors.color171236),
                      ),
                      Gap(12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'ID: '.tr,
                            style: mullerW400.copyWith(
                                fontSize: 12, color: AppColors.color171236),
                          ),
                          Gap(4),
                          Expanded(
                            child: Text(
                              controller.orderDetails?.driver?.uuid ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: mullerW400.copyWith(
                                  fontSize: 12, color: AppColors.color171236),
                            ),
                          ),
                        ],
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
