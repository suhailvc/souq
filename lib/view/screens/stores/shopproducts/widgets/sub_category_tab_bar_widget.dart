import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class SubCategoryTabBarWidget extends StatelessWidget {
  const SubCategoryTabBarWidget({
    super.key,
    required this.onTap,
    required this.tabController,
    required this.arrTabs,
    this.isScrollable,
    this.selectedColor,
    this.unSelectedColor,
    this.borderRadius,
    this.indicatorColor,
    required this.selectedTabIndex,
  });

  final List<Category> arrTabs;
  final Function(int) onTap;
  final TabController tabController;
  final bool? isScrollable;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final Color? indicatorColor;
  final BorderRadiusGeometry? borderRadius;
  final int selectedTabIndex;

  @override
  Widget build(final BuildContext context) {
    return Stack(fit: StackFit.loose, children: <Widget>[
      TabBar(
        controller: tabController,
        isScrollable: isScrollable ?? false,
        physics: const BouncingScrollPhysics(),
        tabAlignment: (isScrollable ?? false) ? TabAlignment.start : null,
        onTap: (final int index) {
          onTap.call(index);
        },
        labelColor: selectedColor ?? AppColors.color2E236C,
        unselectedLabelColor: unSelectedColor ?? AppColors.color94ACB5,
        indicatorWeight: 0.2,
        dividerColor: AppColors.colorDFE6E9,
        dividerHeight: 2,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          borderRadius: borderRadius ?? null,
          border: Border(
            bottom: BorderSide(
                width: 2, color: indicatorColor ?? AppColors.color2E236C),
          ),
        ),
        tabs: getTabs(),
      ),
    ]);
  }

  List<Tab> getTabs() {
    final List<Tab> tabs = <Tab>[];
    for (int i = 0; i < arrTabs.length; i++) {
      tabs.add(Tab(
        child: Text(
          _getTabTitle(i),
          style: mullerW500.copyWith(),
        ),
      ));
    }

    return tabs;
  }

  String _getTabTitle(final int index) {
    final String tabName = arrTabs[index].getName();
    return tabName;
  }
}
