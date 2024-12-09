import 'package:atobuy_vendor_flutter/controller/product/add_product_controller.dart';
import 'package:atobuy_vendor_flutter/data/request_model/product_bulk_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateUnitPriceBottomSheet extends StatelessWidget {
  CreateUnitPriceBottomSheet({super.key, this.index = 0, this.sizeData});

  final int? index;
  final ProductSizeModel? sizeData;
  TextEditingController txtUnit = TextEditingController();
  TextEditingController txtAmount = TextEditingController();

  @override
  Widget build(final BuildContext context) {
    final ProductSizeModel? sizeData = this.sizeData;
    if (sizeData != null) {
      txtUnit.text = sizeData.unit ?? '';
      txtAmount.text = sizeData.price ?? '';
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GetBuilder<AddProductController>(
            builder: (final AddProductController controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.12),
                    blurRadius: 27.6,
                    spreadRadius: 0,
                    offset: Offset(0, -8),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: controller.addUnitFormKey,
                child: Column(
                  children: <Widget>[
                    Gap(16),
                    Text(
                      'Add New Unit'.tr,
                      style: mullerW500.copyWith(
                        color: AppColors.color171236,
                        fontSize: 16,
                      ),
                    ),
                    Gap(16),
                    CommonTextField(
                      validator: (final String? p0) {
                        if (p0?.trim().isEmpty ?? false) {
                          return 'Please enter unit.'.tr;
                        } else {
                          return null;
                        }
                      },
                      inputFormatter: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(
                            AppConstants.priceUnitMaxLength),
                      ],
                      labelStyle: mullerW400.copyWith(
                          color: AppColors.color8ABCD5, fontSize: 12),
                      allowLeftRightPadding: false,
                      controller: txtUnit,
                      labelText: 'Unit'.tr,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChange: (final String text) {
                        txtUnit.text = text;
                      },
                    ),
                    Gap(12),
                    CommonTextField(
                      validator: (final String? p0) {
                        if (p0?.trim().isEmpty ?? false) {
                          return 'Please enter amount.'.tr;
                        } else {
                          return null;
                        }
                      },
                      inputFormatter: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(
                            AppConstants.priceUnitMaxLength),
                      ],
                      labelStyle: mullerW400.copyWith(
                          color: AppColors.color8ABCD5, fontSize: 12),
                      allowLeftRightPadding: false,
                      controller: txtAmount,
                      labelText: 'Amount'.tr,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      onChange: (final String text) {
                        txtAmount.text = text;
                      },
                    ),
                    Gap(26),
                    CommonButton(
                        onTap: () {
                          controller.onTapSaveNewSize(
                              sizeData, index, txtAmount.text, txtUnit.text);
                        },
                        title: 'Save'.tr),
                    Gap(MediaQuery.of(context).padding.bottom > 0
                        ? MediaQuery.of(context).padding.bottom
                        : 26),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
