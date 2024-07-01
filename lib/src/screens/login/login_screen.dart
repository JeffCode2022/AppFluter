<<<<<<< HEAD
import 'package:delivery_autonoma/common/styles/spacing_styles.dart';
import 'package:delivery_autonoma/common/widgets/login_signup/form_divier.dart';
import 'package:delivery_autonoma/common/widgets/login_signup/social_buttons.dart';
=======
import 'package:delivery_autonoma/common/widgets/login_signup/form_divier.dart';
import 'package:delivery_autonoma/common/widgets/login_signup/social_buttons.dart';
import 'package:delivery_autonoma/src/screens/login/widgets/circle_login.dart';
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
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

<<<<<<< HEAD
=======
  

>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
<<<<<<< HEAD
             
=======
              const Positioned(top: -90, left: -90, child: TCircleLogin()),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
              const Positioned(
                top: 50,
                left: 30,
                child: Text(
                  'LOGIN',
                  style: TextStyle(
<<<<<<< HEAD
                      color: MyColors.dark,
=======
                      color: MyColors.white,
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
<<<<<<< HEAD
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
=======
              Column(
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
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
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
<<<<<<< HEAD
    margin: const EdgeInsets.only(top: 130),
=======
    margin: const EdgeInsets.only(top:130),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
    child: Lottie.asset(TImages.imgDelivery2,
        width: 250, height: 250, fit: BoxFit.fill),
  );
}
