import 'package:flutter/material.dart';

import '../../utils/constants/colors_delivery.dart';
import '../../utils/constants/sizes.dart';


class TRoundedConatiner extends StatelessWidget {
  const TRoundedConatiner({
    super.key,
    this.child,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.showBorder = false,
    this.backgroundColor = MyColors.white,
    this.radius = TSizes.cardRadiusMd,
    this.borderColor = MyColors.grey,
  });
  
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor): null,
      ),
      child: child,
      
    );
  }
}