import 'package:delivery_autonoma/common/containers/curved_edges/curved_edge.dart';
import 'package:flutter/material.dart';


class TCurvedEdgeWidget extends StatelessWidget {
  const TCurvedEdgeWidget({
    super.key, this.child,
  });

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      
      clipper: TCustomCurvedEdge(),
      child: child,
    );
  }
}