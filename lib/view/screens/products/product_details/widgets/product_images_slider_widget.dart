import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductImagesSliderWidget extends StatelessWidget {
  const ProductImagesSliderWidget({
    super.key,
    required this.productImageList,
  });

  final List<Images> productImageList;

  @override
  Widget build(final BuildContext context) {
    return productImageList.isNotEmpty
        ? CarouselSlider.builder(
            options: CarouselOptions(
              aspectRatio: 375 / 363,
              viewportFraction: 0.85,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              scrollDirection: Axis.horizontal,
            ),
            itemCount: productImageList.length,
            itemBuilder: (final BuildContext context, final int index,
                final int realIndex) {
              final String item = productImageList[index].image ?? '';
              return CachedNetworkImage(
                imageUrl: item,
                imageBuilder: (final BuildContext context,
                    final ImageProvider<Object> imageProvider) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                },
                errorWidget: (final BuildContext context, final String url,
                    final Object error) {
                  return CommonImagePlaceholderWidget();
                },
                placeholder: (final BuildContext context, final String url) {
                  return CommonImagePlaceholderWidget();
                },
              );
            },
          )
        : SizedBox(height: 363, child: CommonImagePlaceholderWidget());
  }
}
