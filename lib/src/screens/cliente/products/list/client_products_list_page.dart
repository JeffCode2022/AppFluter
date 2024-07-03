import 'package:delivery_autonoma/common/containers/primary_header_container.dart';
import 'package:delivery_autonoma/common/containers/rounder_container.dart';
import 'package:delivery_autonoma/common/containers/shearch_container.dart';
import 'package:delivery_autonoma/common/styles/shadows.dart';
import 'package:delivery_autonoma/common/widgets/appbar/tabbar.dart';
import 'package:delivery_autonoma/common/widgets/icons/t_circle_icon.dart';
import 'package:delivery_autonoma/common/widgets/text/product_price_title.dart';
import 'package:delivery_autonoma/common/widgets/text/t_brand_title_text_with_verification.dart';
import 'package:delivery_autonoma/common/widgets/text/t_product_title_text.dart';
import 'package:delivery_autonoma/src/models/category.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/screens/cliente/products/list/cliente_products_list_controllers.dart';
import 'package:delivery_autonoma/src/widgets/no_data_widget.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

// ignore: must_be_immutable
class ClienteProductsListPage extends StatefulWidget {
  
  const ClienteProductsListPage({
    super.key,
    
  });

  @override
  State<ClienteProductsListPage> createState() =>
      _ClienteProductsListPageState();
}

class _ClienteProductsListPageState extends State<ClienteProductsListPage> {
  final ClientProductsListControllers _contr = ClientProductsListControllers();
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _contr.init(context, refresh );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _contr.categories.length,
      child: AdvancedDrawer(
        openRatio: 0.5,
        backdropColor: MyColors.primary.withOpacity(0.5),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInQuad,
        animationDuration: const Duration(milliseconds: 300),
        drawer: _buildDrawer(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Scaffold(
            key: _contr.key,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child: AppBar(
                automaticallyImplyLeading: false,
                actions: [
                  _shopinBag(),
                ],
                flexibleSpace: Column(
                  children: [
                    const SizedBox(height: 20),
                    _menuDrawer(),
                    const SizedBox(height: TSizes.defaultSpace),
                    _texFieldSearch(),
                  ],
                ),
                bottom: TTabBar(
                  tabs:
                      List<Widget>.generate(_contr.categories.length, (index) {
                    return Tab(
                      child: Text(
                        _contr.categories[index].name ?? '',
                      ),
                    );
                  }),
                ),
              ),
            ),
            body: TabBarView(
              children: _contr.categories.map((Category category) {
                return FutureBuilder(
                  future: _contr.getProducts(category.id!),
                  builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return _cardProductVertical(snapshot.data![index]);
                          },
                        );
                      } else {
                        return NoDataWidget(
                            text: 'No hay productos disponibles');
                      }
                    } else {
                      return NoDataWidget(text: 'No hay productos disponibles');
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  ///----------------- Widgets -----------------
  ///----------------- Shoping Bag -----------------
  Widget _shopinBag() {
    return GestureDetector(
      onTap: _contr.goToOrderBagg,
      child: Stack(
        children: [
          IconButton(
            onPressed: () => {_contr.goToOrderBagg()},
            icon: const Icon(Iconsax.shopping_bag),
          ),
          Positioned(
            right: 3,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: MyColors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  "${_contr.selectedProducts.length ?? ''}",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: MyColors.white, fontSizeFactor: 0.8),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///----------------- textfield search -----------------
  Widget _texFieldSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar en la tienda',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        onChanged: _contr.onChangeText,
      ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: () => _advancedDrawerController.showDrawer(),
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 5),
        alignment: Alignment.centerLeft,
        child: Lottie.asset(
          'assets/json/icons8-menu.json',
          width: 50,
          height: 50,
        ),
      ),
    );
  }

  ///----------------- Drawer -----------------
  Widget _buildDrawer() {
    return SafeArea(
      child: TPrimaryHeaderContainer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Encabezado del Drawer con imagen grande y bordes
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.transparent, // Color de fondo del encabezado
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen del usuario con bordes
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: _contr.user?.image != null
                          ? FadeInImage(
                              image: NetworkImage(_contr.user!.image!),
                              fit: BoxFit.cover,
                              placeholder: const AssetImage(TImages.user),
                            )
                          : const Image(
                              image: AssetImage(TImages.user),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  // Datos del usuario
                  Text(
                    '${_contr.user?.name ?? ''} ${_contr.user?.lastname ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _contr.user?.email ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                  // numero de telefono
                  Text(
                    _contr.user?.phone ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            // ListTile para opciones de Drawer
            ListTile(
              title: const Text('Editar Perfil',
                  style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.edit, color: Colors.white),
              onTap: _contr.goToUpdate,
            ),
            ListTile(
              title: const Text('Mis Pedidos',
                  style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.shopping_bag, color: Colors.white),
              onTap: _contr.goToMyOrders,
            ),
            if (_contr.user != null && _contr.user!.roles.length > 1)
              ListTile(
                onTap: _contr.goToRoles,
                title: const Text('Seleccionar Rol',
                    style: TextStyle(color: Colors.white)),
                trailing: const Icon(Iconsax.user_octagon, color: Colors.white),
              ),
            ListTile(
              title: const Text('Cerrar Sesión',
                  style: TextStyle(color: Colors.white)),
              trailing: const Icon(Iconsax.logout, color: Colors.white),
              onTap: _contr.logout,
            ),

            const SizedBox(height: 370),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 20.0),
                ClipRRect(
                  child: Image.asset(
                    TImages.google,
                    width: 20,
                    height: 20,
                  ),
                ),
                const SizedBox(width: 20.0),
                ClipRRect(
                  child: Image.asset(
                    TImages.facebook,
                    width: 20,
                    height: 20,
                  ),
                ),
                const SizedBox(width: 20.0),
                ClipRRect(
                  child: Image.asset(
                    TImages.instagram,
                    width: 20,
                    height: 20,
                  ),
                ),
                const SizedBox(width: 10.0),
                const Text(
                  'versión 1.0.0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///////////////////////////  CARD PRODUCT VERTICAL  ///////////////////////////
Widget _cardProductVertical(Product product) {
  return Card(
    elevation: 3.0,
    child: Container(
      width: 200,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [TShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productItemRadius),
        color: MyColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // thumbnail, wishlist button, discount tag
          GestureDetector(
            onTap: () {
              _contr.openBottomSheet(product);
            },
            child: TRoundedConatiner(
              height: 180,
              padding: const EdgeInsets.all(10),
              backgroundColor: MyColors.darkGrey.withOpacity(0.1),
              child: Stack(
                children: [
                  Container(
                    height: 180,
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: FadeInImage(
                      image: product.image1 != null
                          ? NetworkImage(product.image1!)
                          : const AssetImage(TImages.jugos)
                              as ImageProvider<Object>,
                      fit: BoxFit.contain,
                      fadeInDuration: const Duration(milliseconds: 50),
                      placeholder: const AssetImage('assets/img/noData.png'),
                    ),
                  ),

                  //--------------Sale Tag
                  Positioned(
                    top: 12,
                    child: TRoundedConatiner(
                      radius: TSizes.sm,
                      backgroundColor: MyColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.sm,
                        vertical: TSizes.xs,
                      ),
                      child: Text(
                        '20%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: MyColors.black),
                      ),
                    ),
                  ),

                  //------------------------favorite button
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: TCircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                      backgroundColor: Colors.transparent,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),

          //-------------------DETAILS
          Padding(
            padding: const EdgeInsets.only(left: TSizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //---------------product name
                TProductTitleText(
                  title: product.name ?? '',
                  smallSize: true,
                ),
                const TBrandTitleWithVerifiedIcon(),
              ],
            ),
          ),

          const Spacer(),

          //---------PRICE ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: TSizes.md),
                child: TProductoPriceText(price: '${product.price ?? 0}'),
              ),

              //---- add cart
              GestureDetector(
                onTap: () {
                  _contr.addToBag(product);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.primary.withOpacity(0.9),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productItemRadius),
                    ),
                  ),
                  child: const SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Icon(
                      Iconsax.add,
                      color: MyColors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}


  void refresh() {
    setState(() {});
  }
}
