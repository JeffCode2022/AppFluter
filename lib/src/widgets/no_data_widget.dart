import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoDataWidget extends StatelessWidget {
  NoDataWidget({
    super.key,
    required this.text,
  });

  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            TImages.noData2,
            width: 250,
            height: 250,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
