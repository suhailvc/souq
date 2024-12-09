import 'package:atobuy_vendor_flutter/controller/inventory/inventory_details_controller.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/inventory/inventory_details/widgets/inventory_details_header_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InventoryFlexibleSpaceBar extends StatelessWidget {
  const InventoryFlexibleSpaceBar({super.key, required this.topHeight});

  final double topHeight;
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<InventoryDetailsController>(
        builder: (final InventoryDetailsController controller) {
      return FlexibleSpaceBar(
        expandedTitleScale: 1.0,
        centerTitle: true,
        titlePadding: EdgeInsets.symmetric(vertical: 12),
        title: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: topHeight == kToolbarHeight ? 1.0 : 0.0,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.color12658E,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 16,
                  width: 16,
                  child: CachedNetworkImage(
                    imageUrl: controller.inventoryDetails?.logo ?? '',
                    imageBuilder: (final BuildContext context,
                            final ImageProvider<Object> imageProvider) =>
                        Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder:
                        (final BuildContext context, final String url) =>
                            CommonImagePlaceholderImage(),
                    errorWidget: (final BuildContext context, final String url,
                            final Object error) =>
                        CommonImagePlaceholderImage(),
                  ),
                ),
                Gap(8),
                Text(
                  controller.inventoryDetails?.name ?? '',
                  style:
                      mullerW500.copyWith(fontSize: 14, color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
        collapseMode: CollapseMode.parallax,
        background: InventoryDetailsHeaderWidget(),
      );
    });
  }
}
