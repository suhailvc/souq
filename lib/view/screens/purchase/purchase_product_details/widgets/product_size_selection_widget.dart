import 'package:atobuy_vendor_flutter/data/request_model/product_bulk_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class ProductSizeSelectionWidget extends StatelessWidget {
  const ProductSizeSelectionWidget({
    super.key,
    this.onSelect,
    required this.sizeData,
    this.selectedSize,
  });

  final Function(ProductSizeModel? sizeData)? onSelect;
  final List<ProductSizeModel> sizeData;
  final ProductSizeModel? selectedSize;
  @override
  Widget build(final BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      children: <Widget>[
        ...sizeData.map<Widget>(
          (final ProductSizeModel item) {
            final bool isSelected = selectedSize?.id == item.id;
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  onSelect?.call(null);
                } else {
                  onSelect?.call(item);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.color1679AB : AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        isSelected ? Colors.transparent : AppColors.colorB1D2E3,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        item.unit ?? '',
                        style: mullerW400.copyWith(
                            fontSize: 12,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.color2E236C),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ],
    );
  }
}
