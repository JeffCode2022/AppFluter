import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/device/devices_utility.dart';
import 'package:delivery_autonoma/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.showBackArrow = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return AppBar(
      elevation: 5,
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Iconsax.arrow_left,
                  color: dark ? MyColors.white : MyColors.white),
            )
          : leadingIcon != null
              ? IconButton(
                  onPressed: leadingOnPressed,
                  icon: Icon(leadingIcon),
                )
              : null,
      title: title,
      actions: actions,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: MyColors.warmGrey,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
