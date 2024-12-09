import 'package:atobuy_vendor_flutter/controller/order/order_detail_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/driver_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/user_default_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderAssignDriverRow extends StatelessWidget {
  const OrderAssignDriverRow(
      {super.key, required this.driver, required this.onSelect});

  final Driver driver;
  final VoidCallback onSelect;
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<OrderDetailController>(
        builder: (final OrderDetailController controller) {
      return GestureDetector(
        onTap: onSelect,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: (driver.isSelected ?? false)
                  ? AppColors.color12658E
                  : AppColors.colorB1D2E3,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: (driver.isSelected ?? false)
                    ? AppColors.color12658E.withOpacity(0.12)
                    : Colors.transparent,
                blurRadius: 27.6,
                spreadRadius: 0,
                offset: Offset(-1, 20),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: driver.profileImage ?? '',
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
                  return _driverProfilePlaceholder();
                },
                errorWidget: (final BuildContext context, final String url,
                    final Object error) {
                  return _driverProfilePlaceholder();
                },
              ),
              Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      driver.name ?? '',
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: mullerW500.copyWith(
                          fontSize: 15, color: AppColors.color171236),
                    ),
                    Gap(8),
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
                            driver.uuid ?? '',
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: mullerW400.copyWith(
                                fontSize: 12, color: AppColors.color171236),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Gap(12),
              SvgPicture.asset((driver.isSelected ?? false)
                  ? Assets.svg.icCheckboxSelected
                  : Assets.svg.icCheckboxDeselected),
              Gap(8),
            ],
          ),
        ),
      );
    });
  }

  Widget _driverProfilePlaceholder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: UserDefaultAvatar(),
    );
  }
}
