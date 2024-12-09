import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/country_picker/countries.dart';
import 'package:atobuy_vendor_flutter/view/base/country_picker/country_picker_dialog.dart';
import 'package:atobuy_vendor_flutter/view/base/country_picker/intl_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class MobileNumberWidget extends StatelessWidget {
  const MobileNumberWidget(
      {super.key,
      required this.controller,
      required this.countryCode,
      required this.onCountryChange,
      this.isPrefixIcon,
      this.allowOnCountryTap,
      this.labelStyle});

  final bool? isPrefixIcon;
  final bool? allowOnCountryTap;
  final TextEditingController controller;
  final String countryCode;
  final TextStyle? labelStyle;
  final Function(Country country) onCountryChange;

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<GlobalController>(
        builder: (final GlobalController globalController) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.colorB1D2E3,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: (isPrefixIcon ?? true) ? 70 : 16, top: 8),
                  child: Text(
                    'Mobile Number'.tr,
                    style: labelStyle ??
                        mullerW400.copyWith(
                            color: AppColors.color8ABCD5, fontSize: 15.0),
                  ),
                ),
              ],
            ),
            IntlPhoneField(
              countriesModelList: globalController.countryList,
              initialCountryCode: countryCode,
              cursorColor: Colors.black,
              cursorWidth: 1,
              allowOnCountryTap: allowOnCountryTap,
              controller: controller,
              pickerDialogStyle: PickerDialogStyle(
                backgroundColor: Colors.white,
                listTileDivider: Divider(
                  color: AppColors.colorDDECF2,
                  height: .5,
                ),
                countryCodeStyle: mullerW500.copyWith(
                    fontSize: 16.0, color: AppColors.color16171B),
                searchFieldCursorColor: AppColors.black,
                searchFieldInputDecoration: InputDecoration(
                  labelText: 'Search country',
                  labelStyle: mullerW400.copyWith(color: AppColors.color8ABCD5),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.colorDDECF2),
                  ),
                ),
              ),
              showDropdownIcon: true,
              flagsButtonPadding: EdgeInsetsDirectional.only(start: 20),
              textAlignVertical: TextAlignVertical.top,
              style: mullerW500.copyWith(
                  fontSize: 16, color: AppColors.color1D1D1D),
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              dropdownTextStyle: mullerW700.copyWith(fontSize: 16.0),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 40,
                ),
                counterText: '',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                floatingLabelStyle:
                    mullerW400.copyWith(color: AppColors.color8ABCD5),
                labelStyle: mullerW400.copyWith(color: AppColors.color8ABCD5),
              ),
              prefixIcon: (isPrefixIcon ?? true) ? null : SizedBox(),
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              invalidNumberMessage: 'invalidNumberMessage'.tr,
              textAlign: TextAlign.start,
              disableLengthCheck: false,
              onCountryChanged: (final Country country) {
                onCountryChange(country);
              },
            ),
          ],
        ),
      );
    });
  }
}
