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
<<<<<<< HEAD
      margin: const EdgeInsets.only(bottom:70),
=======
      margin: const EdgeInsets.only(bottom: 80),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
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
<<<<<<< HEAD
            style: Theme.of(context).textTheme.titleLarge,
            
=======
            style: Theme.of(context).textTheme.bodyLarge,
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
          ),
        ],
      ),
    );
  }
}
