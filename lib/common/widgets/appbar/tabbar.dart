import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/device/devices_utility.dart';
import 'package:delivery_autonoma/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Material(
      color: dark ? MyColors.dark : MyColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
<<<<<<< HEAD
        indicatorColor: Colors.blue,
        labelColor: MyColors.primary.withOpacity(0.9), 
=======
        indicatorColor: Colors.red,
        labelColor: dark ? MyColors.white : MyColors.dark,
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
        unselectedLabelColor: MyColors.darkGrey,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
