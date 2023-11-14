import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';

class DefaultAppBar extends AppBar {
  DefaultAppBar({super.key});

  AppBar createAppbar({required VoidCallback callback}) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.white,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Divider(
          thickness: 1,
          height: 1,
          color: AppColors.black,
        ),
      ),
      automaticallyImplyLeading: false,
      title: SizedBox(
        height: 30,
        child: Image.asset("assets/images/app_logo.png"),
      ),
      actions: [
        IconButton(
            onPressed: callback,
            icon: Image.asset("assets/images/category_ic.png"))
      ],
    );
  }
}
