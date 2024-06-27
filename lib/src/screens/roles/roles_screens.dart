import 'dart:ui';

import 'package:delivery_autonoma/src/models/rol.dart';
import 'package:delivery_autonoma/src/screens/roles/roles_controller.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rive/rive.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  final RolesController _con = RolesController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              "assets/img/rm222-mind-20.jpg",
              fit: BoxFit.cover,
            ),
          ),
          // Blur effect over the entire screen
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(color: Colors.black.withOpacity(0)),
            ),
          ),
          // Cubes
          const Positioned(
            top: 50,
            left: 30,
            child: SizedBox(
              width: 250,
              height: 250,
              child: RiveAnimation.asset("assets/json/3d_cube_effect.riv"),
            ),
          ),
          const Positioned(
            bottom: 50,
            right: 30,
            child: SizedBox(
              width: 250,
              height: 250,
              child: RiveAnimation.asset("assets/json/3d_cube_effect.riv"),
            ),
          ),
          const Positioned(
            top: 300,
            left: 100,
            child: SizedBox(
              width: 250,
              height: 250,
              child: RiveAnimation.asset("assets/json/3d_cube_effect.riv"),
            ),
          ),
          const Positioned(
            bottom: 300,
            right: 100,
            child: SizedBox(
              width: 250,
              height: 250,
              child: RiveAnimation.asset("assets/json/3d_cube_effect.riv"),
            ),
          ),
           Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(color: Colors.white.withOpacity(0.5)),
            ),
          ),
          // Welcome text
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(30.0),
              color: Colors.transparent,
              child: Column(
                children: [
                  const Text(
                    'Bienvenido!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: MyColors.dark,
                    ),
                  ),
                  Text(
                    '${_con.user?.name ?? ''} ' '${_con.user?.lastname}',
                    style:  const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: MyColors.primary,
                    ),
                  ),
                  const Text(
                    'Selecciona un rol: ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: MyColors.dark,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ListView with role cards
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            child: ListView(
              children: _con.user != null
                  ? _con.user!.roles.map((Rol rol) {
                      return _cardRol(rol);
                    }).toList()
                  : const [],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: () {
        _con.goToPage(rol.route!);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 60.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent),
          child: Column(
            children: [
              const SizedBox(height: TSizes.spaceBtwInputFields),
              ClipRRect(
                
                child: SizedBox(
                  width: 130,
                  height: 130,
                  child: rol.image != null && rol.image!.isNotEmpty
                      ? FadeInImage(
                          image: NetworkImage(rol.image!),
                          placeholder: const AssetImage(TImages.defaultImage),
                          fit: BoxFit.contain,
                          fadeInDuration: const Duration(milliseconds: 50),
                        )
                      : const Image(
                          image: AssetImage(TImages.defaultImage),
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  rol.name ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: MyColors.black,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
