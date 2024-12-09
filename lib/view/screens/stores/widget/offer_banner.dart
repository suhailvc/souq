import 'package:atobuy_vendor_flutter/controller/shop_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/promo_banner/banner_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ShopController>(
      builder: (final ShopController controller) {
        return controller.bannerList.isNotEmpty
            ? CarouselSlider.builder(
                options: CarouselOptions(
                  viewportFraction: 0.9,
                  clipBehavior: Clip.antiAlias,
                  autoPlay: true,
                  enableInfiniteScroll:
                      controller.bannerList.length > 1 ? true : false,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  aspectRatio: 327 / 140,
                  onPageChanged: (final int index,
                      final CarouselPageChangedReason reason) {},
                ),
                itemCount: controller.bannerList.length,
                itemBuilder: (final BuildContext context, final int index,
                    final int realIndex) {
                  final BannerItem banner = controller.bannerList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: CachedNetworkImage(
                      imageUrl: controller.bannerList[index].image ?? '',
                      imageBuilder: (final BuildContext context,
                              final ImageProvider<Object> imageProvider) =>
                          GestureDetector(
                        onTap: () {
                          if (controller.isValidBanner(banner: banner)) {
                            Get.toNamed(
                              RouteHelper.purchaseProductDetails,
                              arguments: <String, dynamic>{
                                'uuid': banner.product?.uuid ?? '',
                                'product_id': banner.product?.id ?? ''
                              },
                            );
                          }
                        },
                        child: AspectRatio(
                          aspectRatio: 327 / 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                      placeholder:
                          (final BuildContext context, final String url) =>
                              _placeholder(),
                      errorWidget: (final BuildContext context,
                              final String url, final Object error) =>
                          _placeholder(),
                    ),
                  );
                },
              )
            : _placeholder().paddingSymmetric(horizontal: 16);
      },
    );
  }

  Widget _placeholder() {
    return AspectRatio(
      aspectRatio: 327 / 140,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          Assets.images.imgPlaceholder.path,
          fit: BoxFit.cover,
          height: 140,
          width: Get.width,
        ),
      ),
    );
  }
}
