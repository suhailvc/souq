import 'package:atobuy_vendor_flutter/controller/product/add_product_controller.dart';
import 'package:atobuy_vendor_flutter/data/request_model/product_bulk_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/bottom_sheet/create_unit_with_price.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductSizeDataWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<AddProductController>(
      builder: (final AddProductController controller) {
        return controller.arrBulkAmount.isEmpty
            ? GestureDetector(
                onTap: () {
                  FocusScope.of(Get.context!).unfocus();
                  openCreateUnitBottomSheet();
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12.0),
                  color: AppColors.colorB1D2E3,
                  strokeWidth: 2,
                  dashPattern: <double>[4, 6],
                  padding: EdgeInsets.zero,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppColors.colorD0E4EE.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            Assets.svg.icAddSubImage,
                            colorFilter: ColorFilter.mode(
                                AppColors.color8ABCD5, BlendMode.srcIn),
                          ),
                          Gap(12.0),
                          Text(
                            'Click here to add unit with price'.tr,
                            style: mullerW400.copyWith(
                                fontSize: 12, color: AppColors.color8ABCD5),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.start,
                children: [
                  ...controller.arrBulkAmount.map<Widget>(
                    (final ProductSizeModel item) {
                      return GestureDetector(
                        onTap: () => openCreateUnitBottomSheet(
                          sizeData: item,
                          index: controller.arrBulkAmount.indexOf(item),
                        ),
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: AppColors.colorB1D2E3),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                item.unit ?? '',
                                style: mullerW400.copyWith(
                                    fontSize: 16, color: AppColors.color12658E),
                              ),
                              Gap(12),
                              Text(
                                item.getAmount(),
                                style: mullerW400.copyWith(
                                    fontSize: 16, color: AppColors.color12658E),
                              ),
                              InkWell(
                                  onTap: () {
                                   controller.onTapDeleteSizeData(item);
                                  },
                                  child: Icon(Icons.delete_outline))
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  GestureDetector(
                    onTap: () => openCreateUnitBottomSheet(),
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: AppColors.colorB1D2E3),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add,
                          ),
                          Gap(3),
                          Text(
                            'Add New'.tr,
                            style: mullerW400.copyWith(
                                fontSize: 16, color: AppColors.color12658E),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }

  void openCreateUnitBottomSheet(
      {final int? index, final ProductSizeModel? sizeData}) {
    Get.bottomSheet(
      CreateUnitPriceBottomSheet(
        index: index,
        sizeData: sizeData,
      ),
      isScrollControlled: true,
    );
  }
}
