import 'dart:io';
import 'package:delivery_autonoma/common/widgets/appbar/appbar.dart';
import 'package:delivery_autonoma/src/models/category.dart';
import 'package:delivery_autonoma/src/screens/restaurant/products/create/restaurant_products_create_crontrollers.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';

class RestaurantProductsCreatePage extends StatefulWidget {
  const RestaurantProductsCreatePage({super.key});

  @override
  State<RestaurantProductsCreatePage> createState() =>
      _RestaurantProductsCreatePageState();
}

class _RestaurantProductsCreatePageState
    extends State<RestaurantProductsCreatePage> {
  final RestaurantProductsCreateController _contr =
      RestaurantProductsCreateController();

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
        title: Text('Nuevos Poductos',
            style: TextStyle(
              color: MyColors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: TSizes.spaceBtwInputFields),
            _formProducts(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _cardImage(_contr.imageFile1, 1),
                _cardImage(_contr.imageFile2, 2),
                _cardImage(_contr.imageFile3, 3),
              ],
            ),
            _dorpDownCategories(_contr.categories),
          ],
        ),
      ),
      bottomNavigationBar: _buttomCreateProducts(),
    );
  }

  void refreshMethod() {
    setState(() {});
  }

  /// Formulario para crear productos
  Widget _formProducts() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          TextFormField(
            controller: _contr.nameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: MyColors.lightRed.withOpacity(0.1),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              labelText: 'Nombre del producto',
              labelStyle:
                  TextStyle(color: MyColors.primaryColor.withOpacity(0.7)),
              prefixIcon: const Icon(Iconsax.note_favorite,
                  color: MyColors.primaryColor),
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
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              labelText: 'Descripción de los productos',
              labelStyle:
                  TextStyle(color: MyColors.primaryColor.withOpacity(0.7)),
              prefixIcon:
                  const Icon(Iconsax.archive, color: MyColors.primaryColor),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///--precio
          TextFormField(
            keyboardType: TextInputType.number,
            controller: _contr.priceController,
            decoration: InputDecoration(
              filled: true,
              fillColor: MyColors.lightRed.withOpacity(0.1),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              labelText: 'Precio del producto',
              labelStyle:
                  TextStyle(color: MyColors.primaryColor.withOpacity(0.7)),
              prefixIcon: const Icon(Icons.monetization_on,
                  color: MyColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  /// Botón para crear categorías
  _buttomCreateProducts() {
    return Container(
      height: 130,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: ElevatedButton(
        onPressed: _contr.createProduct,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Crear producto',
          style: TextStyle(color: MyColors.white, fontSize: 20),
        ),
      ),
    );
  }

  //card image
  Widget _cardImage(File? imageFile, int numberFile) {
    // ignore: unnecessary_null_comparison
    return GestureDetector(
      onTap: () {
        _contr.showAlertDialog(numberFile);
      },
      child: imageFile != null
          ? Card(
              elevation: 3.0,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : const Card(
              elevation: 3.0,
              child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(image: AssetImage(TImages.imgProducts))),
            ),
    );
  }

  ///--- drop down
  Widget _dorpDownCategories(List<Category> categories) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Iconsax.global_search,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Categorías',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              //seleccion de categorias
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: const Text(
                    'Seleccionar categoria',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  items: _getDropDownItems(categories),
                  value: _contr.idCategory,
                  onChanged: (String? option) {
                    setState(() {
                      _contr.idCategory =
                          option; // ESTABLECIENDO EL VALOR SELECCIONADO
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getDropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    // ignore: avoid_function_literals_in_foreach_calls
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        value: category.id,
        child: Text(category.name!),
      ));
    });
    return list;
  }
}
