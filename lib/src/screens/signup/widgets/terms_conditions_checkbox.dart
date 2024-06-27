import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:delivery_autonoma/utils/constants/text_delivery.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/helpers/helper_functions.dart';

class TTermsAndConditionCheckbox extends StatelessWidget {
  const TTermsAndConditionCheckbox({
    super.key,
   
  });



  @override
  Widget build(BuildContext context) {
        final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                // ignore: unnecessary_string_interpolations
                TextSpan(
                    // ignore: unnecessary_string_interpolations
                    text: '${TTexts.iAgreeTo}',
                    style:
                        Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text: TTexts.privacyPolicy,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(
                          color: dark
                              ? MyColors.white
                              : MyColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: dark
                              ? MyColors.white
                              : MyColors.primary,
                        )),
                // ignore: unnecessary_string_interpolations
                TextSpan(
                    // ignore: unnecessary_string_interpolations
                    text: '${TTexts.and}',
                    style:
                        Theme.of(context).textTheme.bodySmall),
        
                TextSpan(
                    text: TTexts.termOfUse,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(
                          color: dark
                              ? MyColors.white
                              : MyColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: dark
                              ? MyColors.white
                              : MyColors.primary,
                        )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

