<<<<<<< HEAD
import 'package:delivery_autonoma/common/containers/primary_header_container.dart';
import 'package:delivery_autonoma/common/containers/rounder_container.dart';
import 'package:delivery_autonoma/common/containers/shearch_container.dart';
=======
import 'package:delivery_autonoma/common/containers/rounder_container.dart';
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
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
<<<<<<< HEAD
import 'package:lottie/lottie.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
=======
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db

class ClienteProductsListPage extends StatefulWidget {
  const ClienteProductsListPage({super.key});

  @override
  State<ClienteProductsListPage> createState() =>
      _ClienteProductsListPageState();
}

class _ClienteProductsListPageState extends State<ClienteProductsListPage> {
  final ClientProductsListControllers _contr = ClientProductsListControllers();
<<<<<<< HEAD
  final _advancedDrawerController = AdvancedDrawerController();
=======
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _contr.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _contr.categories.length,
<<<<<<< HEAD
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
=======
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
                  const SizedBox(height: 50),
                  _menuDrawer(),
                  const SizedBox(height: TSizes.defaultSpace),
                  _texFieldSearch(),
                ],
              ),
              // ------------------tabs for store

              bottom: TTabBar(
                tabs: List<Widget>.generate(_contr.categories.length, (index) {
                  return Tab(
                    child: Text(
                      _contr.categories[index].name ?? '',
                    ),
                  );
                }),
              ),
            )),
        drawer: _drawer(),
        body: TabBarView(
          children: _contr.categories.map((Category category) {
            return FutureBuilder(
                future: _contr.getProducts(category.id!),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return GridView.builder(
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return _cadProductVertical(snapshot.data![index]);
<<<<<<< HEAD
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
=======
                          });
                    } else {
                      return NoDataWidget(text: 'No hay productos disponibles');
                    }
                  } else {
                    return NoDataWidget(text: 'No hay productos disponibles');
                  }
                });
          }).toList(),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
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
<<<<<<< HEAD
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
                  "${_contr.selectedProducts.length ?? 0}",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: MyColors.white, fontSizeFactor: 0.8),
                ),
              ),
            ),
          )
=======
          Container(
            margin: const EdgeInsets.only(right: 20, top: 15),
            child: const Icon(
              Iconsax.shopping_bag,
              color: Colors.black,
              size: 30,
            ),
          ),
          Positioned(
              right: 18,
              top: 20,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                    color: Colors.blueGrey, shape: BoxShape.circle),
              ))
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
        ],
      ),
    );
  }

<<<<<<< HEAD
  ///----------------- textfield search -----------------
  Widget _texFieldSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: const TSearchContainer(
        text: 'Buscar en la tienda',
        showBorder: true,
        showBackground: false,
        padding: EdgeInsets.zero,
=======
////----------------- textfield search -----------------
  Widget _texFieldSearch() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar',
          suffixIcon: Icon(Iconsax.search_favorite, color: Colors.cyan[300]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.cyan, width: 2),
          ),
        ),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
      ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
<<<<<<< HEAD
      onTap: () => _advancedDrawerController.showDrawer(),
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 5),
        alignment: Alignment.centerLeft,
        child: Lottie.asset(
          'assets/json/icons8-menu.json',
          width: 50,
          height: 50,
=======
      onTap: _contr.openDrawer,
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 5),
        alignment: Alignment.centerLeft,
        child: Image.asset(
          TImages.imgHome,
          width: 30,
          height: 30,
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
        ),
      ),
    );
  }

  ///----------------- Drawer -----------------
<<<<<<< HEAD
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

=======

  Widget _drawer() {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: const BoxDecoration(gradient: MyColors.warmGrey),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_contr.user?.name ?? ''} ${_contr.user?.lastname ?? ''}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
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
              ClipOval(
                child: Container(
                  height: 60,
                  margin: const EdgeInsets.only(top: 5),
                  child: _contr.user?.image != null
                      ? FadeInImage(
                          image: NetworkImage(_contr.user!.image!),
                          fit: BoxFit.contain,
                          fadeInDuration: const Duration(milliseconds: 50),
                          placeholder: const AssetImage(TImages.user),
                        )
                      : const Image(
                          image: AssetImage(TImages.user),
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: const Text('Editar Perfil'),
          trailing: Image.asset(TImages.editPerfil, width: 30, height: 30),
          onTap: _contr.goToUpdate,
        ),
        ListTile(
          title: const Text('Mis Pedidos'),
          trailing: Image.asset(TImages.pedidos, width: 30, height: 30),
          onTap: () {},
        ),
        _contr.user != null
            ? _contr.user!.roles.length > 1
                ? ListTile(
                    onTap: _contr.goToRoles,
                    title: const Text('Seleccionar Rol'),
                    trailing: Image.asset(TImages.roles, width: 30, height: 30))
                : Container()
            : Container(),
        ListTile(
          title: const Text('Cerrar Sesión'),
          trailing: Image.asset(TImages.logout, width: 30, height: 30),
          onTap: _contr.logout,
        ),
      ]),
    );
  }

  void refresh() {
    setState(() {});
  }

>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
  ///////////////////////////  CARD PRODUCT VERTICAL  ///////////////////////////
  Widget _cadProductVertical(Product product) {
    return GestureDetector(
      onTap: () {
        _contr.openBottomSheet(product);
      },
      child: Card(
        elevation: 3.0,
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
<<<<<<< HEAD
            boxShadow: [TShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(TSizes.productItemRadius),
            color: MyColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // thumbnail, whishlist button, discount tag
=======
              boxShadow: [TShadowStyle.verticalProductShadow],
              borderRadius: BorderRadius.circular(TSizes.productItemRadius),
              color: MyColors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // thumbnail, whishlist button, discount tad

>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
              TRoundedConatiner(
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
                        placeholder:
                            const AssetImage('assets/img/pngwing.com (2).png'),
                      ),
                    ),

                    //--------------Sale Tag
<<<<<<< HEAD
=======

>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
                    Positioned(
                      top: 12,
                      child: TRoundedConatiner(
                        radius: TSizes.sm,
                        backgroundColor: MyColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
<<<<<<< HEAD
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
=======
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text('20%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: MyColors.black)),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
                      ),
                    ),

                    //------------------------favorite button
                    const Positioned(
<<<<<<< HEAD
                      top: 0,
                      right: 0,
                      child: TCircularIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                        backgroundColor: Colors.transparent,
                      ),
                    )
=======
                        top: 0,
                        right: 0,
                        child: TCircularIcon(
                          icon: Iconsax.heart5,
                          color: Colors.red,
                          backgroundColor: Colors.transparent,
                        ))
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),

              //-------------------DETAILS
              Padding(
<<<<<<< HEAD
                padding: const EdgeInsets.only(left: TSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //---------------product name
                    TProductTitleText(
                      title: product.name ?? '',
                      smallSize: true,
                    ),
                    const TBrandTitleWithVerifiedIcon(
                      title: 'Autonoma ',
                    ),
                  ],
                ),
              ),
=======
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //---------------product name
                      TProductTitleText(
                        title: product.name ?? '',
                        smallSize: true,
                      ),
                      const TBrandTitleWithVerifiedIcon(
                        title: 'Autonoma ',
                      ),
                    ],
                  )),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db

              const Spacer(),

              //---------PRICE ROW
<<<<<<< HEAD
=======

>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.md),
                    child: TProductoPriceText(price: '${product.price ?? 0}'),
                  ),

                  //---- add cart
                  Container(
<<<<<<< HEAD
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
=======
                    decoration: const BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(TSizes.cardRadiusMd),
                          bottomRight:
                              Radius.circular(TSizes.productItemRadius)),
                    ),
                    child: const SizedBox(
                        width: TSizes.iconLg * 1.2,
                        height: TSizes.iconLg * 1.2,
                        child: Icon(
                          Iconsax.add,
                          color: MyColors.white,
                        )),
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD

  void refresh() {
    if (!mounted) return;
    setState(() {});
  }
=======
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
}
