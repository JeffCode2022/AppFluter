import 'package:delivery_autonoma/common/widgets/appbar/appbar.dart';
import 'package:delivery_autonoma/src/models/rol.dart';
import 'package:delivery_autonoma/src/screens/roles/roles_controller.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
        appBar: const TAppBar(
            title: Center(
                child: Text('Selecciona un rol',
                    style: TextStyle(color: Colors.white)))),
        body: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
          child: ListView(
            children: _con.user != null
                ? _con.user!.roles.map((Rol rol) {
                    return _cardRol(rol);
                  }).toList()
                : const [],
          ),
        ));
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: () {
        _con.goToPage(rol.route!);
      },
      child: Column(
        children: [
          SizedBox(
            height: 100,
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
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Text(
            rol.name ?? '',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
