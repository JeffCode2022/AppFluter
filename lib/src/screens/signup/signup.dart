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
              Positioned(
                top: 50,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.to(() => const LoginPage(), transition: Transition.rightToLeft),
                      icon: const Icon(Icons.arrow_back, color: MyColors.dark, size: TSizes.iconMd),
                    ),
                    const Text(
                      'REGISTRO',
                      style: TextStyle(
                        color: MyColors.dark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
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

                        /// First Name
                        Expanded(
                          child: TextFormField(
                            controller: _contr.nameController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              labelText: TTexts.firstName,
                              prefixIcon: Icon(Iconsax.user),
                               focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0), // Color del borde cuando está enfocado
                ),
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 2.0), // Color del borde cuando no está enfocado
                ),
                            ),
                          ),
                        ),


                        const SizedBox(width: TSizes.spaceBtwInputFields),

                        /// Last Name
                        Expanded(
                          child: TextFormField(
                            controller: _contr.lastNameController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              labelText: TTexts.lastName,
                              prefixIcon: Icon(Iconsax.user),
                               focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0), // Color del borde cuando está enfocado
                ),
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 2.0), // Color del borde cuando no está enfocado
                ),
                            ),
                          ),
                        ),
                      ],
                    ),



                    /// Email
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _contr.emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: TTexts.email,
                        prefixIcon: Icon(Iconsax.direct),
                         focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0), // Color del borde cuando está enfocado
                ),
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 2.0), // Color del borde cuando no está enfocado
                ),
                      ),
                    ),

                    /// Phone
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: _contr.phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9\+]')),
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: TTexts.phone,
                        prefixIcon: Icon(Iconsax.call),
                         focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0), // Color del borde cuando está enfocado
                ),
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 2.0), // Color del borde cuando no está enfocado
                ),
                      ),
                    ),




                    /// Password
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
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _contr.isEnable ? _contr.signup : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primary,
          side: BorderSide.none,
        ),
        child: const Text(
          TTexts.registerButton,
          style: TextStyle(color: MyColors.white, fontSize: 20),
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
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
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
         focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0), // Color del borde cuando está enfocado
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 2.0), // Color del borde cuando no está enfocado
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
