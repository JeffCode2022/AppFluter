import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:delivery_autonoma/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';



class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key, 
   required this.width , 
    required this.height, 
    this.overlayColor, 
    this.backgroundColor, 
    required this.image, 
    this.fit = BoxFit.cover, 
    this.padding = TSizes.sm,
    this.isNetworkImage = false, 

  });

    final BoxFit? fit;
    final String image;
    final bool isNetworkImage;
    final Color? overlayColor;
    final Color? backgroundColor;
    final double width, height,padding;







  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding:  EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (THelperFunctions.isDarkMode(context) ? MyColors.black : MyColors.white),
        borderRadius: BorderRadius.circular(100)),
    
        child: ClipOval(
          child: Image(
            fit: fit,
            image:isNetworkImage ? NetworkImage(image):   AssetImage(image) as ImageProvider,
            color: overlayColor,
            ),
        ),
        
    );
  }
}