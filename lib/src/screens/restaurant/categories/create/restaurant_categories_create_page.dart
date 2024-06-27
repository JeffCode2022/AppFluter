import 'package:delivery_autonoma/common/widgets/appbar/appbar.dart';
import 'package:delivery_autonoma/src/screens/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:delivery_autonoma/utils/constants/text_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';

class RestaurantCategoriesCreatePage extends StatefulWidget {
  const RestaurantCategoriesCreatePage({super.key});

  @override
  State<RestaurantCategoriesCreatePage> createState() =>
      _RestaurantCategoriesCreatePageState();
}

class _RestaurantCategoriesCreatePageState
    extends State<RestaurantCategoriesCreatePage> {
  final RestaurantCategoriesCreateController _contr =
      RestaurantCategoriesCreateController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _contr.init(context, refreshMethod);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Nuevas Categorias',
            style: TextStyle(
              color: MyColors.dark,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: TSizes.defaultSpace*2),
            _formCategori(),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            _buttomCreateCategories(),
          ],
        ),
      ),
    );
  }

  void refreshMethod() {
    setState(() {});
  }

  /// Botón para crear categorías
  _buttomCreateCategories() {
    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: ElevatedButton(
        onPressed: _contr.createCategory,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          TTexts.categories,
          style: TextStyle(color: MyColors.white, fontSize: 20),
        ),
      ),
    );
  }

  /// Formulario para crear categorías
  Widget _formCategori() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          TextFormField(
            controller: _contr.nameController,
            decoration:  InputDecoration(
         
              
              labelText: TTexts.categoryName,
              prefixIcon: const Icon(Iconsax.text_block, color: MyColors.dark),
              labelStyle: TextStyle(color: MyColors.primary.withOpacity(0.7)),
              focusedBorder:  const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0), // Color del borde cuando está enfocado
                ),
                enabledBorder:  const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 2.0), // Color del borde cuando no está enfocado
                ),
             
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Description de la categoría
          TextFormField(
            maxLength: 255,
            maxLines: 5,
            controller: _contr.descriptionController,
            decoration:  InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              labelText: 'Descripción de la categoría',
              prefixIcon: const Icon(Iconsax.archive, color: MyColors.dark),
              labelStyle: TextStyle(color: MyColors.primary.withOpacity(0.7)),
             focusedBorder:  const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0), // Color del borde cuando está enfocado
                ),
                enabledBorder:  const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 2.0), // Color del borde cuando no está enfocado
                ),
            ),
          ),
        ],
      ),
    );
  }
}
