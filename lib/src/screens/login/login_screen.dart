import 'package:delivery_autonoma/common/styles/spacing_styles.dart';
import 'package:delivery_autonoma/common/widgets/login_signup/form_divier.dart';
import 'package:delivery_autonoma/common/widgets/login_signup/social_buttons.dart';
import 'package:delivery_autonoma/src/screens/login/widgets/login_form.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:delivery_autonoma/utils/constants/text_delivery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
             
              const Positioned(
                top: 50,
                left: 30,
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      color: MyColors.dark,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: TSpacingStyles.paddingWithAppBarHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // CIRCULO DE LOGIN
                    _lottieAnimation(),

                    // Formulario de login
                    const TLoginForm(),

                    //--separador

                    TFormDivider(
                      dividerText: TTexts.orSignInWith.capitalize!,
                    ),

                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Botones de redes sociales

                    const TSocialButtons(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _lottieAnimation() {
  return Container(
    margin: const EdgeInsets.only(top: 130),
    child: Lottie.asset(TImages.imgDelivery2,
        width: 250, height: 250, fit: BoxFit.fill),
  );
}
