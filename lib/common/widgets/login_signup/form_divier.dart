import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TFormDivider extends StatelessWidget {
  const TFormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark =THelperFunctions.isDarkMode(context);
    return Row (
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Flexible(child: Divider (color: dark ? MyColors.darkerGrey : MyColors.darkGrey.withOpacity(0.5), thickness: 0.5, indent:60 ,endIndent: 5,)),
          Text(dividerText, style: Theme.of(context).textTheme.bodyMedium),
          Flexible(child: Divider (color: dark ? MyColors.darkerGrey : MyColors.darkGrey.withOpacity(0.5), thickness: 0.5, indent:5,endIndent: 60,)),

        ]
    );
  }
}
