import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductStoreTextFieldWidget extends StatelessWidget {
  const ProductStoreTextFieldWidget({
    super.key,
    required this.selectedStore,
    required this.stores,
    required this.onSelectStore,
  });

  final StoreModel? selectedStore;
  final List<StoreModel> stores;
  final Function(StoreModel?) onSelectStore;
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
      child: DropdownSearch<StoreModel>(
        items: stores,
        selectedItem: selectedStore,
        itemAsString: (final StoreModel store) => store.name ?? '',
        popupProps: PopupProps<StoreModel>.modalBottomSheet(
          onDismissed: () {
            FocusScope.of(Get.context!).unfocus();
          },
          showSearchBox: true,
          searchDelay: const Duration(milliseconds: 100),
          listViewProps: const ListViewProps(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          constraints: BoxConstraints(maxHeight: Get.height - 80),
          itemBuilder: (final BuildContext context, final StoreModel item,
              final bool isSelected) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.colorDDECF2,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(
                  item.name ?? '',
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
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            textInputAction: TextInputAction.done,
            cursorColor: AppColors.color6A6982,
            style: mullerW400,
            autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Search Store'.tr,
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
        dropdownBuilder: (final BuildContext context, final StoreModel? store) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Product Store'.tr,
                style: mullerW400.copyWith(
                    fontSize: 12, color: AppColors.color8ABCD5),
              ),
              store != null
                  ? Text(
                      store.name ?? '',
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
        onChanged: (final StoreModel? value) => onSelectStore.call(value),
      ),
    );
  }
}
