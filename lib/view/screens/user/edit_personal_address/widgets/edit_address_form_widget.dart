import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_personal_address/widgets/address_line_textfield_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_personal_address/widgets/building_textfield_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_personal_address/widgets/city_textfield_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_personal_address/widgets/country_textfield_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_personal_address/widgets/landmark_textfield_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_personal_address/widgets/state_textfield_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_personal_address/widgets/zone_no_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditAddressFormWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<UserProfileController>(
        builder: (final UserProfileController controller) {
      return Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: controller.editAddressFormKey,
            child: Column(
              children: <Widget>[
                Gap(24),
                ZoneNoTextFieldWidget(controller: controller.txtZoneNo),
                Gap(16),
                AddressLineTextFieldWidget(
                  controller: controller.txtStreet,
                  isAddressLine1: false,
                  textInputType: TextInputType.streetAddress,
                ),
                Gap(16),
                BuildingTextFieldWidget(
                  controller: controller.txtBuilding,
                ),
                Gap(16),
                LandmarkTextFieldWidget(controller: controller.txtLandMark),
                Gap(16),
                CountryTextFieldWidget(
                  selectedCountry: controller.selectedCountry,
                  onCountryChange: (final CountryModel? country) {
                    controller.setSelectedCountry(country);
                  },
                ),
                Gap(16),
                StateTextFieldWidget(
                  selectedState: controller.selectedState,
                  onStateChange: (final Region? state) {
                    controller.setSelectedState(state);
                  },
                ),
                Gap(16),
                CityTextFieldWidget(
                  selectedCity: controller.selectedCity,
                  onCityChange: (final City? city) {
                    controller.setSelectedCity(city);
                  },
                ),
                Gap(16),
              ],
            ),
          ),
        ),
      );
    });
  }
}
