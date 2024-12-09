import 'package:atobuy_vendor_flutter/data/response_models/auth/business_type_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BusinessTypeTextFieldWidget extends StatelessWidget {
  const BusinessTypeTextFieldWidget({
    super.key,
    required this.selectedTypes,
    required this.onChangeType,
    required this.arrBusinessType,
  });

  final List<BusinessCategory> selectedTypes;
  final List<BusinessCategory> arrBusinessType;
  final Function(List<BusinessCategory>?) onChangeType;

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 60,
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
      child: DropdownSearch<BusinessCategory>.multiSelection(
        items: arrBusinessType,
        selectedItems: selectedTypes,
        itemAsString: (final BusinessCategory type) => type.name ?? '',
        compareFn: (final BusinessCategory c1, final BusinessCategory c2) =>
            c1.id == c2.id,
        popupProps: PopupPropsMultiSelection<BusinessCategory>.modalBottomSheet(
          onDismissed: () {
            FocusScope.of(Get.context!).unfocus();
          },
          showSearchBox: true,
          textDirection: Get.find<SharedPreferenceHelper>().getLanguageCode ==
                  AppConstants.arabicLangCode
              ? TextDirection.rtl
              : TextDirection.ltr,
          searchDelay: const Duration(milliseconds: 100),
          listViewProps: const ListViewProps(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          constraints: BoxConstraints(maxHeight: Get.height - 80),
          itemBuilder: (final BuildContext context, final BusinessCategory item,
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
            decoration: InputDecoration(
              hintText: 'Search Business Type'.tr,
              hintStyle: mullerW400,
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.colorDDECF2, width: 1.0),
              ),
              border: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.colorDDECF2, width: 1.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.colorDDECF2, width: 1.0),
              ),
            ),
          ),
        ),
        dropdownBuilder:
            (final BuildContext context, final List<BusinessCategory>? items) {
          return Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      Assets.svg.icBusinessType,
                      matchTextDirection: true,
                    ),
                    Gap(12),
                    VerticalDividerWidget(
                      height: 50,
                      color: AppColors.colorDDECF2,
                    ),
                  ],
                ),
              ),
              Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Business Type'.tr,
                      style: mullerW400.copyWith(
                          fontSize: items.isNotNullOrEmpty() ? 12 : 16,
                          color: AppColors.color8ABCD5),
                    ),
                    items.isNotNullOrEmpty()
                        ? _selectedItems(items!)
                        : SizedBox(),
                  ],
                ),
              )
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
          ),
        ),
        onChanged: (final List<BusinessCategory>? value) =>
            onChangeType.call(value),
      ),
    );
  }

  Widget _selectedItems(
    final List<BusinessCategory> items,
  ) {
    return SizedBox(
      height: 20,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (final BuildContext context, final int index) {
          return Text(
            items[index].name ?? '',
            style:
                mullerW500.copyWith(fontSize: 14, color: AppColors.color171236),
          );
        },
        separatorBuilder: (final BuildContext context, final int index) {
          return SizedBox(
            child: Text(', '),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
