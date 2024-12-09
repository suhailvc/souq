import 'package:atobuy_vendor_flutter/utils/app_enums.dart';

class SortModel {
  SortModel({required this.title, required this.isSelected, this.value});
  String title;
  String? value;
  bool isSelected;
}

class ProductSortModel {
  ProductSortModel({required this.isSelected, required this.type});
  bool isSelected;
  SortOptions type;
}
