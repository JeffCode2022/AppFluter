import 'package:delivery_autonoma/common/containers/circular_container.dart';
import 'package:delivery_autonoma/common/containers/curved_edges/curved_edges_widget.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:flutter/material.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      
        child: Container(
      color: Colors.transparent,

      //IF [SIZE.ISINFINITE : IS NOT TRUE.IN STACK ] ERROR OCCURS -> READ README.MD FILE AT

      child: Stack(
        children: [
          // ---BACKGROUND CUSTOM SHAPES---
          Positioned(
              top: 0,
              right: -200,
              child: TCircularConatiner(
                  backgroundColor: MyColors.white.withOpacity(0.1))),
          Positioned(
              top: 170,
              right: -200,
              child: TCircularConatiner(
                  backgroundColor: MyColors.white.withOpacity(0.1))),
          child,
        ],
      ),
    ));
  }
}
