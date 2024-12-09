import 'package:atobuy_vendor_flutter/data/response_models/inventory/inventory_category_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/cupertino.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {super.key, required this.arrCategory, required this.onSelectCategory});

  final List<InventoryCategoryModel> arrCategory;
  final Function(InventoryCategoryModel) onSelectCategory;
  @override
  Widget build(final BuildContext context) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: arrCategory.map((final InventoryCategoryModel category) {
        return GestureDetector(
          onTap: () {
            onSelectCategory.call(category);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            margin: EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
              color:
                  category.isSelected ? AppColors.color2E236C : AppColors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: AppColors.colorB1D2E3),
            ),
            child: Text(
              category.category,
              style: category.isSelected
                  ? mullerW500.copyWith(fontSize: 16, color: AppColors.white)
                  : mullerW400.copyWith(
                      fontSize: 16, color: AppColors.color12658E),
            ),
          ),
        );
      }).toList(),
    );
  }
}
