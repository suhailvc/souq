import 'package:atobuy_vendor_flutter/controller/product/stores/store_product_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/brand_list_model.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/widget/business_category_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandListWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<StoreProductController>(
      builder: (final StoreProductController controller) {
        return SizedBox(
          height: 105.0,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: controller.arrBrands.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (final BuildContext context, final int index) {
              final Brand brand = controller.arrBrands[index];
              return BusinessCategoryRow(
                title: brand.title,
                logo: brand.logo,
                onTapType: () {
                  controller.onSelectBrand(brand: brand);
                },
                isSelected:
                    controller.arrBrands[index] == controller.selectedBrand,
              );
            },
            separatorBuilder: (final BuildContext context, final int index) {
              return SizedBox(
                width: 16,
              );
            },
          ),
        );
      },
    );
  }
}
