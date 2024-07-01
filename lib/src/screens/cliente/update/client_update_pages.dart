import 'package:delivery_autonoma/common/widgets/appbar/appbar.dart';
import 'package:delivery_autonoma/src/screens/cliente/update/client_update_controller.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/text_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors_delivery.dart';
import '../../../../utils/constants/sizes.dart';

class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({super.key});

  @override
  State<ClientUpdatePage> createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {
  final ClienteUpdateController _contr = ClienteUpdateController();

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
      appBar: const TAppBar(
<<<<<<< HEAD
        title: Text(TTexts.updateProfile, style: TextStyle(fontSize: 20)),
=======
        title:
            Text(TTexts.updateProfile, style: TextStyle(color: MyColors.white)),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            _imageUser(),
            const SizedBox(height: 30),
            _form(),
          ],
        ),
      ),
      bottomNavigationBar: _buildRegisterButton(),
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: ElevatedButton(
        onPressed: _contr.isEnable ? _contr.update : null,
        style: ElevatedButton.styleFrom(
          elevation: 5,
          shadowColor: MyColors.black,
          padding: const EdgeInsets.symmetric(
              vertical: 15, horizontal: 20), // Ajusta el padding del botón
<<<<<<< HEAD
          backgroundColor: MyColors.primary,
=======
          backgroundColor: MyColors.darkerGrey,
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
          side: BorderSide.none,
          enableFeedback: true,
          splashFactory: InkRipple.splashFactory,
        ),
        child: const Text(
          TTexts.updateButton,
          style: TextStyle(
            color: MyColors.white,
            fontSize: 20, // Ajusta el tamaño del texto
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
            : _contr.user?.image != null
                ? NetworkImage(_contr.user!.image!)
<<<<<<< HEAD
                : Image.asset(TImages.user).image,
=======
                :  Image.asset(TImages.user).image,
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget _form() {
    return Padding(
<<<<<<< HEAD
      padding: const EdgeInsets.symmetric(horizontal: 50),
=======
      padding: const EdgeInsets.all(32),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
      child: Column(
        children: [
          TextFormField(
            controller: _contr.nameController,
            keyboardType: TextInputType.name,
<<<<<<< HEAD
            decoration: const InputDecoration(
              filled: false,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              labelText: TTexts.firstName,
              labelStyle: TextStyle(color: Colors.blue),
              prefixIcon: Icon(Iconsax.user_tick),
=======
            decoration: InputDecoration(
              filled: true,
              fillColor: MyColors.grey.withOpacity(0.3),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              labelText: TTexts.firstName,
              prefixIcon: const Icon(Iconsax.user),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: _contr.lastNameController,
            keyboardType: TextInputType.name,
<<<<<<< HEAD
            decoration: const InputDecoration(
              filled: false,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              labelText: TTexts.lastName,
              labelStyle: TextStyle(color: Colors.blue),
              prefixIcon: Icon(Iconsax.user_tag),
=======
            decoration: InputDecoration(
              filled: true,
              fillColor: MyColors.grey.withOpacity(0.3),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              labelText: TTexts.lastName,
              prefixIcon: const Icon(Iconsax.user),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: _contr.phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9\+]')),
            ],
<<<<<<< HEAD
            decoration: const InputDecoration(
              filled: false,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              labelText: TTexts.phone,
              labelStyle: TextStyle(color: Colors.blue),
              prefixIcon: Icon(Iconsax.call),
=======
            decoration: InputDecoration(
              filled: true,
              fillColor: MyColors.grey.withOpacity(0.3),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              labelText: TTexts.phone,
              prefixIcon: const Icon(Iconsax.call),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
            ),
          ),
        ],
      ),
    );
  }
}
