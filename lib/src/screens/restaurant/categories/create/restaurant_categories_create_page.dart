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
              color: MyColors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: TSizes.spaceBtwInputFields),
            _formCategori()
          ],
        ),
      ),
      bottomNavigationBar: _buttomCreateCategories(),
    );
  }

  void refreshMethod() {
    setState(() {});
  }

  /// Botón para crear categorías
  _buttomCreateCategories() {
    return Container(
      height: 130,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: ElevatedButton(
        onPressed: _contr.createCategory,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
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
            decoration: InputDecoration(
              filled: true,
              fillColor: MyColors.lightRed.withOpacity(0.1),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              labelText: TTexts.categoryName,
              labelStyle: TextStyle(color: MyColors.primaryColor.withOpacity(0.7)),
              suffixIcon: const Icon(Iconsax.note_favorite, color: MyColors.primaryColor),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Description de la categoría
          TextFormField(
            maxLength: 255,
            maxLines: 5,
            controller: _contr.descriptionController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              filled: true,
              fillColor: MyColors.lightRed.withOpacity(0.1),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              labelText: 'Descripción de la categoría',
              labelStyle: TextStyle(color: MyColors.primaryColor.withOpacity(0.7)),
              suffixIcon: const Icon(Icons.description, color: MyColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
