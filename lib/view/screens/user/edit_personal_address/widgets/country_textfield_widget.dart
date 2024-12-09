import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CountryTextFieldWidget extends StatelessWidget {
  const CountryTextFieldWidget({
    super.key,
    this.selectedCountry,
    required this.onCountryChange,
  });

  final CountryModel? selectedCountry;
  final Function(CountryModel?) onCountryChange;
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<GlobalController>(
        builder: (final GlobalController globalController) {
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
        child: DropdownSearch<CountryModel>(
          items: globalController.countryList,
          selectedItem: selectedCountry,
          itemAsString: (final CountryModel country) => country.name ?? '',
          popupProps: PopupProps<CountryModel>.modalBottomSheet(
            onDismissed: () {
              FocusScope.of(Get.context!).unfocus();
            },
            showSearchBox: true,
            searchDelay: const Duration(milliseconds: 100),
            listViewProps: const ListViewProps(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
            constraints: BoxConstraints(maxHeight: Get.height - 80),
            itemBuilder: (final BuildContext context, final CountryModel item,
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
                hintText: 'Search Country'.tr,
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
              (final BuildContext context, final CountryModel? country) {
            return Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        Assets.svg.icCountry,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Country'.tr,
                      style: mullerW400.copyWith(
                          fontSize: country != null ? 12 : 16,
                          color: AppColors.color8ABCD5),
                    ),
                    country != null
                        ? Text(
                            country.name ?? '',
                            style: mullerW500.copyWith(
                                fontSize: 16, color: AppColors.color171236),
                          )
                        : SizedBox(),
                  ],
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
          onChanged: (final CountryModel? value) => onCountryChange.call(value),
        ),
      );
    });
  }
}
