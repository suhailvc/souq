import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StoreListCell extends StatelessWidget {
  StoreListCell(
      {super.key,
      required this.onSelectStore,
      required this.store,
      required this.isSelected});

  final StoreModel store;
  final VoidCallback onSelectStore;
  final bool isSelected;

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        onSelectStore.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.color8ABCD5 : AppColors.colorD0E4EE,
          ),
        ),
        child: Column(
          children: <Widget>[
            store.logo != null
                ? CachedNetworkImage(
                    imageUrl: store.logo ?? '',
                    imageBuilder: (final BuildContext context,
                            final ImageProvider<Object> imageProvider) =>
                        AspectRatio(
                      aspectRatio: 109 / 85,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    placeholder:
                        (final BuildContext context, final String url) =>
                            _placeholder(),
                    errorWidget: (final BuildContext context, final String url,
                            final Object error) =>
                        _placeholder(),
                  )
                : _placeholder(),
            Gap(8),
            Text(
              store.name ?? '',
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: mullerW500.copyWith(
                  fontSize: 12, color: AppColors.color1D1D1D),
            ).paddingSymmetric(horizontal: 15.0),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return AspectRatio(
      aspectRatio: 109 / 85,
      child: CommonImagePlaceholderWidget(
        borderRadius: BorderRadius.circular(0),
        backgroundColor: AppColors.color666666.withOpacity(0.05),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
