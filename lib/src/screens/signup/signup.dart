import 'package:delivery_autonoma/src/screens/login/login_screen.dart';
import 'package:delivery_autonoma/src/screens/signup/signup_controllers.dart';
import 'package:delivery_autonoma/src/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/text_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors_delivery.dart';
import '../../../utils/constants/sizes.dart';
import '../login/widgets/circle_login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpControllers _contr = SignUpControllers();
        bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _contr.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              const Positioned(top: -90, left: -90, child: TCircleLogin()),
              Positioned(
                  top: 50,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () => Get.to(() => const LoginPage(),
                              transition: Transition.rightToLeft),
                          icon: const Icon(Icons.arrow_back,
                              color: MyColors.white, size: TSizes.iconMd)),
                      const Text(
                        'REGISTRO',
                        style: TextStyle(
                            color: MyColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              const SizedBox(height: TSizes.defaultSpace),
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 120),
                      child: _imageUser(),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                     Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _contr.nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: MyColors.lightRed.withOpacity(0.1),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: TTexts.firstName,
                      prefixIcon: const Icon(Iconsax.user),
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwInputFields),
                Expanded(
                  child: TextFormField(
                    controller: _contr.lastNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: MyColors.lightRed.withOpacity(0.1),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: TTexts.lastName,
                      prefixIcon: const Icon(Iconsax.user),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _contr.emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: MyColors.lightRed.withOpacity(0.1),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                labelText: TTexts.email,
                prefixIcon: const Icon(Iconsax.direct),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              controller: _contr.phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\+]')),
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: MyColors.lightRed.withOpacity(0.1),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                labelText: TTexts.phone,
                prefixIcon: const Icon(Iconsax.call),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            _buildPasswordTextField(
              controller: _contr.passwordController,
              labelText: TTexts.password,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            _buildPasswordTextField(
              controller: _contr.confirmPasswordController,
              labelText: TTexts.confirmPassword,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            const TTermsAndConditionCheckbox(),
            const SizedBox(height: TSizes.defaultSpace),
            _buildRegisterButton(),    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed:_contr.isEnable ? _contr.signup : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          side: BorderSide.none,
        ),
        child: const Text(
          TTexts.registerButton,
          style: TextStyle(color: MyColors.white),
        ),
      ),
    );
  }


  Widget _buildPasswordTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColors.lightRed.withOpacity(0.1),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelText: labelText,
        prefixIcon: const Icon(Iconsax.password_check),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Iconsax.eye_slash : Iconsax.eye,
          ),
        ),
      ),
    );
  }




void refresh() {
  setState(() {});
}
Widget _imageUser() {
  return GestureDetector(
    onTap: () => _contr.showAlertDialog(),
    child: CircleAvatar(
      backgroundImage: _contr.imageFile != null
        ? FileImage(_contr.imageFile!)
        : Image.asset(TImages.user).image,                                                          
      radius: 60,
      backgroundColor: Colors.grey[200],
    ),
  );
}





}
