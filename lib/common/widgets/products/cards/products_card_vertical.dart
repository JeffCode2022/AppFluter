import 'package:delivery_autonoma/common/containers/rounder_container.dart';
import 'package:delivery_autonoma/common/widgets/images/t_rounded_image.dart';
import 'package:delivery_autonoma/common/widgets/text/product_price_title.dart';
import 'package:delivery_autonoma/common/widgets/text/t_brand_title_text_with_verification.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:delivery_autonoma/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/image_delivery.dart';
import '../../../styles/shadows.dart';
import '../../icons/t_circle_icon.dart';
import '../../text/t_product_title_text.dart';


class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});
  

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: (){} ,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productItemRadius),
          color: dark ? MyColors.darkerGrey : MyColors.white,
        ),
        child: Column(
          children: [
            // thumbnail, whishlist button, discount tad

            TRoundedConatiner(
              height: 180,
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? MyColors.dark : MyColors.white,
              child: Stack(
                children: [
                  // ------------Thumbnail Image
                  const TRoundedImage(
                      imageUrl: TImages.product1, applyImageRadius: true),
                      
                      

                  //--------------Sale Tag

                  Positioned(
                    top: 12,
                    child: TRoundedConatiner(
                      radius: TSizes.sm,
                      backgroundColor: MyColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text('20%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: MyColors.black)),
                    ),
                  ),

                  //------------------------favorite button
                  const Positioned(
                      top: 0,
                      right: 0,
                      child: TCircularIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                        backgroundColor: Colors.transparent,
                      ))
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            //-------------------DETAILS
            const Padding(
                padding: EdgeInsets.only(left: TSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //---------------product name
                    TProductTitleText(
                      title: 'Apple Watch Serie 5',
                      smallSize: true,
                    ),

                    SizedBox(height: TSizes.spaceBtwItems / 2),

                    TBrandTitleWithVerifiedIcon(
                    ),
                  ],
                )),

            const Spacer(),

            //---------PRICE ROW

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: TSizes.sm),
                  child: TProductoPriceText(price: '499'),
                ),

                //---- add cart
                Container(
                  decoration: const BoxDecoration(
                    color: MyColors.dark,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(TSizes.cardRadiusMd),
                        bottomRight: Radius.circular(TSizes.productItemRadius)),
                  ),
                  child: const SizedBox(
                      width: TSizes.iconLg * 1.2,
                      height: TSizes.iconLg * 1.2,
                      child: Icon(
                        Iconsax.add,
                        color: MyColors.white,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
