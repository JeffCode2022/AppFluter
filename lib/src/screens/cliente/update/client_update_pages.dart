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
        title:
            Text(TTexts.updateProfile, style: TextStyle(color: MyColors.white)),
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
          padding: const EdgeInsets.symmetric(
              vertical: 15, horizontal: 20), // Ajusta el padding del botón
          backgroundColor: MyColors.primaryColor,
          side: BorderSide.none,
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
                :  Image.asset(TImages.user).image,
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget _form() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          TextFormField(
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
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
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
        ],
      ),
    );
  }
}
