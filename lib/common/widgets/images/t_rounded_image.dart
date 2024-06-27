import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';




class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.border,
    this.padding,
    this.onPressed,
    this.height ,
    this.width,
    this.applyImageRadius = true,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.backgroundColor,
    this.isNetworkImage = false, 
    this.borderRadius = TSizes.md,
    
    
  });

  final double? height, width;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration( border: border, color: backgroundColor,borderRadius: BorderRadius.circular(borderRadius)),
        child: ClipRRect(
          borderRadius: applyImageRadius? BorderRadius.circular(borderRadius):BorderRadius.zero,
          child:  Image(fit:fit,image:isNetworkImage? NetworkImage(imageUrl): AssetImage(imageUrl) as ImageProvider)
          ),
      ),
    );
  }
}
