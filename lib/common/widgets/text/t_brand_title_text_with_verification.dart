import 'package:delivery_autonoma/common/widgets/text/t_brand_title_text.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/enums.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';



class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({
    super.key, 
    this.textColor, 
    this.maxLines = 1, 
    required this.title, 
    this.iconColor = MyColors.primary, 
    this.textAlign = TextAlign.center, 
    this.brandTextSize = TextSizes.small,
  });


  final String title;
  final int maxLines;
  final Color? textColor, iconColor; 
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,

      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          
          ),

        ),   
        const SizedBox(width: TSizes.xs),
        const Icon(Iconsax.verify5, color: MyColors.primary, size: TSizes.iconXs),
      ],
    );
  }
}