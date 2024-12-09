import 'package:atobuy_vendor_flutter/controller/shop_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/business_type_model.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/widget/business_category_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessCategoryWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ShopController>(
      builder: (final ShopController controller) {
        return SizedBox(
          height: 105.0,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: controller.arrBusinessCategory.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (final BuildContext context, final int index) {
              final BusinessCategory category =
                  controller.arrBusinessCategory[index];
              return BusinessCategoryRow(
                title: category.name,
                logo: category.icon,
                onTapType: () {
                  controller.onSelectBusinessCategory(category: category);
                },
                isSelected: controller.arrBusinessCategory[index] ==
                    controller.selectedBusinessCategory,
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
