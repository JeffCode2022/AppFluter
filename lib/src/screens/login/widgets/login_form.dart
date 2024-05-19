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
   final LoginControllers _contr = new LoginControllers();
     bool _obscureText = true;

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
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            //----------------- Email -----------------
            TextFormField(
              controller: _contr.emailController,
              keyboardType: TextInputType.emailAddress,
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
              ),
            ),

            const SizedBox(height: 16),

            //----------------- Password -----------------
            TextFormField(
              controller: _contr.passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscureText,
              decoration: InputDecoration(
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
                      style: TextStyle(color: MyColors.lightRed),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    TTexts.forgotPasswordTitle,
                    style: TextStyle(fontSize: 10, color: MyColors.lightRed),
                  ),
                ),
              ],
            ),

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
            )
          ],
        ),
      ),
    );
  }
}
