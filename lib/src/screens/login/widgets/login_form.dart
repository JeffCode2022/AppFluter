<<<<<<< HEAD

=======
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
import 'package:delivery_autonoma/src/screens/login/login_controllers.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:delivery_autonoma/utils/constants/text_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  State<TLoginForm> createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  // ignore: unnecessary_new
<<<<<<< HEAD
  final LoginControllers _contr = new LoginControllers();
  bool _obscureText = true;
=======
   final LoginControllers _contr = new LoginControllers();
     bool _obscureText = true;
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _contr.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
<<<<<<< HEAD
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
=======
        padding: const EdgeInsets.all(TSizes.defaultSpace),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
        child: Column(
          children: [
            //----------------- Email -----------------
            TextFormField(
              controller: _contr.emailController,
              keyboardType: TextInputType.emailAddress,
<<<<<<< HEAD
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: 'Email',
                labelStyle: TextStyle(
                    color:
                        Colors.grey), // Color del label cuando no está enfocado
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0), // Color del borde cuando está enfocado
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 2.0), // Color del borde cuando no está enfocado
                ),
=======
              decoration: InputDecoration(
                filled: true,
                fillColor: MyColors.lightRed.withOpacity(0.1),
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                prefixIcon: const Icon(Iconsax.direct_right,
                    color: MyColors.primaryColor),
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: MyColors.primaryColor.withOpacity(0.8)),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
              ),
            ),

            const SizedBox(height: 16),

            //----------------- Password -----------------
            TextFormField(
              controller: _contr.passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscureText,
              decoration: InputDecoration(
<<<<<<< HEAD
                prefixIcon: const Icon(
                  Iconsax.password_check,
                ),
                labelText: 'Password',
                labelStyle: const TextStyle(
                    color:
                        Colors.grey), // Color del label cuando no está enfocado
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
=======
                  filled: true,
                  fillColor: MyColors.lightRed.withOpacity(0.1),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  prefixIcon: const Icon(
                    Iconsax.password_check,
                    color: MyColors.primaryColor,
                  ),
                  labelText: 'Password',
                  labelStyle:
                      TextStyle(color: MyColors.primaryColor.withOpacity(0.8)),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                      color: MyColors.primaryColor.withOpacity(0.8),
                    )
                  )
            ),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
            ),

            //----------------------remember me & forget password

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(
                      TTexts.rememberMe,
<<<<<<< HEAD
                      style: TextStyle(color: MyColors.dark),
=======
                      style: TextStyle(color: MyColors.lightRed),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    TTexts.forgotPasswordTitle,
<<<<<<< HEAD
                    style: TextStyle(fontSize: 10, color: MyColors.dark),
=======
                    style: TextStyle(fontSize: 10, color: MyColors.lightRed),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
                  ),
                ),
              ],
            ),

<<<<<<< HEAD
            const SizedBox(height: 5),

            //----------------------Login Button

            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                  bottom: 20, left: 10, right: 10, top: 20),
              child: ElevatedButton(
                onPressed: _contr.login,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: MyColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Iniciar sesión',
                ),
              ),
            ),

            const SizedBox(height: 5),

            //----------------------register button
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                bottom: 20,
                left: 10,
                right: 10,
              ),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: _contr.goToSignUp,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: MyColors
                              .primary), // Establece el color del borde del botón
                    ),
                    child: const Text(TTexts.signUp,
                        style: TextStyle(color: MyColors.primary))),
              ),
=======
            const SizedBox(height: 12),

            //----------------------Login Button

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _contr.login,
                
                style: ElevatedButton.styleFrom(
                  
                    backgroundColor: MyColors.primaryColor.withOpacity(0.8)),
                child: const Text('Iniciar Sesión',
                    style: TextStyle(color: MyColors.white, fontSize: 18)),
              ),
            ),

            const SizedBox(height: 12),

            //----------------------register button
            SizedBox(
              width: double.infinity,
              
              child: OutlinedButton(
                  onPressed: _contr.goToSignUp,
                  
                  style: OutlinedButton.styleFrom(
                    
                  
                    
                    side: const BorderSide(
                        color: MyColors
                            .lightRed), // Establece el color del borde del botón
                  ),
                  child: const Text(TTexts.signUp,
                      style: TextStyle(color: MyColors.lightRed))),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
            )
          ],
        ),
      ),
    );
  }
}
