import "package:delivery_autonoma/utils/constants/colors_delivery.dart";
import "package:flutter/material.dart";

class TCircleLogin extends StatelessWidget {
  const TCircleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor,

      ),
      

    
    );

    
  }
}

