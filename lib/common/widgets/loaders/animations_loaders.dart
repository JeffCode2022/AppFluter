// ignore_for_file: depend_on_referenced_packages

import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
      this.showAction = false,
      this.actionText,
      this.onActionPressed});

  final String animation;
  final String text;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Lottie.asset(animation, width:MediaQuery.of(context).size.width * 0.8),
         const SizedBox(height: TSizes.defaultSpace),
         Text(text, style: Theme.of(context).textTheme.bodyMedium,
         textAlign: TextAlign.center
         ),

         const SizedBox(height: TSizes.defaultSpace),
         showAction ? 
         SizedBox(
          width: 250,
          child: OutlinedButton(
            onPressed: onActionPressed,
            style: OutlinedButton.styleFrom(backgroundColor: MyColors.dark), 
            child: Text(actionText!, style: Theme.of(context).textTheme.bodyMedium!.apply(color: MyColors.white))
          ),
          ):
          const SizedBox(),
        

        ]
        ),
    );
  }
}
