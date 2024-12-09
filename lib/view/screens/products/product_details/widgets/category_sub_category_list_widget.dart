import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategorySubCategoryWidget extends StatelessWidget {
  const CategorySubCategoryWidget({
    super.key,
    required this.category,
    required this.title,
  });

  final Category? category;
  final String title;

  @override
  Widget build(final BuildContext context) {
    return category != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: mullerW400.copyWith(
                  color: AppColors.color677A81,
                  fontSize: 16,
                ),
              ),
              Gap(16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.colorB1D2E3,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  category?.getName() ?? '',
                  style: mullerW400.copyWith(
                    fontSize: 12,
                    color: AppColors.color2E236C,
                  ),
                ),
              ),
              Gap(16),
              Divider(
                color: AppColors.colorB1D1D3,
                height: 1,
              ),
              Gap(16),
            ],
          )
        : SizedBox();
  }
}
