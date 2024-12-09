import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductSubCategoryTextFieldWidget extends StatelessWidget {
  const ProductSubCategoryTextFieldWidget({
    super.key,
    required this.subCategories,
    required this.selectedCategory,
    required this.onSelectSubCategory,
  });

  final Category? selectedCategory;
  final List<Category> subCategories;
  final Function(Category?) onSelectSubCategory;
  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.colorB1D2E3,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: DropdownSearch<Category>(
        items: subCategories,
        selectedItem: selectedCategory,
        itemAsString: (final Category category) => category.getName(),
        popupProps: PopupProps<Category>.modalBottomSheet(
          onDismissed: () {
            FocusScope.of(Get.context!).unfocus();
          },
          showSearchBox: true,
          searchDelay: const Duration(milliseconds: 100),
          listViewProps: const ListViewProps(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          constraints: BoxConstraints(maxHeight: Get.height - 80),
          itemBuilder: (final BuildContext context, final Category item,
              final bool isSelected) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.colorB1D2E3,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(
                  item.getName(),
                  style: mullerW500,
                ),
                tileColor: isSelected
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.transparent,
                selectedTileColor: Colors.grey.withOpacity(0.3),
              ),
            );
          },
          searchFieldProps: TextFieldProps(
            autofocus: true,
            keyboardType: TextInputType.text,
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            textInputAction: TextInputAction.done,
            cursorColor: AppColors.color6A6982,
            style: mullerW400,
            decoration: InputDecoration(
              hintText: 'Search Sub Category'.tr,
              hintStyle: mullerW400,
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.colorB1D2E3, width: 1.0),
              ),
              border: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.colorB1D2E3, width: 1.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.colorB1D2E3, width: 1.0),
              ),
            ),
          ),
        ),
        dropdownBuilder:
            (final BuildContext context, final Category? category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Product Sub Category'.tr,
                style: mullerW400.copyWith(
                    fontSize: 12, color: AppColors.color8ABCD5),
              ),
              category != null
                  ? Text(
                      category.getName(),
                      style: mullerW500.copyWith(
                          fontSize: 16, color: AppColors.color171236),
                    )
                  : SizedBox(),
            ],
          );
        },
        dropdownButtonProps: DropdownButtonProps(
          icon: SvgPicture.asset(
            Assets.svg.icArrowDown,
            colorFilter:
                ColorFilter.mode(AppColors.color2E236C, BlendMode.srcIn),
          ),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          textAlignVertical: TextAlignVertical.center,
          dropdownSearchDecoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            ),
          ),
        ),
        onChanged: (final Category? value) => onSelectSubCategory.call(value),
      ),
    );
  }
}
