import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UserDefaultAvatar extends StatelessWidget {
  const UserDefaultAvatar({super.key, this.border});

  final BoxBorder? border;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.all(border != null ? 4 : 0),
      width: border == null ? 48 : 70,
      height: border == null ? 48 : 70,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: border,
        borderRadius: BorderRadius.circular(border == null ? 8 : 20),
      ),
      child: UserDefaultIcon(
        size: 48,
      ),
    );
  }
}

class UserDefaultIcon extends StatelessWidget {
  const UserDefaultIcon({super.key, required this.size});

  final double size;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Icon(
        Icons.person,
        color: AppColors.color94ACB5,
        size: size,
      ),
    );
  }
}
