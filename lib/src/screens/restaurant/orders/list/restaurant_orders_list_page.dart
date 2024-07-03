import 'package:delivery_autonoma/common/containers/primary_header_container.dart';
import 'package:delivery_autonoma/common/containers/rounder_container.dart';
import 'package:delivery_autonoma/common/widgets/appbar/tabbar.dart';
import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/screens/restaurant/orders/list/restaurant_orders_list_controllers.dart';
import 'package:delivery_autonoma/src/widgets/no_data_widget.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class RestaurantOrderListPage extends StatefulWidget {
  const RestaurantOrderListPage({
    super.key,
  });

  @override
  State<RestaurantOrderListPage> createState() =>
      _RestaurantOrderListPageState();
}

class _RestaurantOrderListPageState extends State<RestaurantOrderListPage> {
  final RestaurantProductsListControllers _contr =
      RestaurantProductsListControllers();


  final _advancedDrawerController = AdvancedDrawerController();


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
      length: _contr.status.length,
      child: AdvancedDrawer(
        openRatio: 0.5,
        backdropColor: MyColors.primary.withOpacity(0.5),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInQuad,
        animationDuration: const Duration(milliseconds: 300),
        drawer: _drawer(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Scaffold(
            key: _contr.key,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: AppBar(
                automaticallyImplyLeading: false,
                actions: const [],
                flexibleSpace: Column(
                  children: [
                    const SizedBox(height: 20),
                    _menuDrawer(),
                  ],
                ),
                bottom: _contr.status.isNotEmpty
                    ? TTabBar(
                        tabs: List<Widget>.generate(_contr.status.length, (index) {
                          return Tab(
                            child: Text(_contr.status[index]),
                          );
                        }),
                      )
                    : null,
              ),
            ),
            drawer: _drawer(),
            body: _contr.status.isNotEmpty
                ? TabBarView(
                    children: _contr.status.map((String status) {
                      return FutureBuilder<List<Order>>(
                        future: _contr.getOrders(status),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return NoDataWidget(text: 'Error loading orders');
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (_, index) {
                                return _orderCard(snapshot.data![index]);
                              },
                            );
                          } else {
                            return NoDataWidget(text: 'No hay ordenes disponibles');
                          }
                        },
                      );
                    }).toList(),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }

  Widget _orderCard(Order order) {
    return GestureDetector(
      onTap: () {
        _contr.openBottomSheet(context, order, () {
          refresh();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: MyColors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: 200,
        margin: const EdgeInsets.all(20),
        child: TRoundedConatiner(
          showBorder: true,
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: MyColors.grey.withOpacity(0.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //---------------------ROW- 1-------
              Row(
                children: [
                  //-----icon
                  const Icon(Iconsax.ship),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),

                  //--- status & date

                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' ${order.client?.name ?? ''} ${order.client?.lastname ?? ''}',
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: MyColors.primary),
                        ),
                        Text(
                          'Entregar en: ${order.address?.address ?? ''}',
                          style: const TextStyle(
                              fontSize: 15, color: MyColors.grey),
                        ),
                      ],
                    ),
                  ),

                  //---- Icon
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.arrow_right_34,
                          color: MyColors.primary, size: TSizes.iconSm)),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              //---------------------ROW 2--------
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        //-----icon
                        const Icon(Iconsax.tag),
                        const SizedBox(width: TSizes.spaceBtwItems / 2),

                        //--- status & date

                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              Text('[# ${order.id}]',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        //-----icon
                        const Icon(Iconsax.calendar),
                        const SizedBox(width: TSizes.spaceBtwItems / 2),

                        //--- status & date

                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Shopping Date',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              Text(' ${_formatDateTime(order.timestamp)}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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

  Widget _drawer() {
    return SafeArea(
      child: TPrimaryHeaderContainer(
        child: ListView(padding: EdgeInsets.zero, 
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.transparent, // Color de fondo del encabezado
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contenido principal del Drawer
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
              ],
            ),
          ),
          // Opciones de navegación del Drawer
          ListTile(
            title: const Text('Crear Categoría', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Iconsax.category, size: 30, color: Colors.white),
            onTap: _contr.goToCategoriesCreate,
          ),
          ListTile(
            title: const Text('Crear producto', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Iconsax.box_add, size: 30, color: Colors.white),
            onTap: _contr.goToProductsCreate,
          ),
          _contr.user != null && _contr.user!.roles.length > 1
              ? ListTile(
                  onTap: _contr.goToRoles,
                  title: const Text('Seleccionar Rol',style: TextStyle(color: Colors.white)),
                  trailing:  const Icon(Iconsax.user_octagon, size: 30, color: Colors.white),
                )
              : Container(),
          ListTile(
            title: const Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Iconsax.logout, size: 30, color: Colors.white),
            onTap: _contr.logout,
          ),
          // Pie de página del Drawer con información adicional
          const SizedBox(height: 390),
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
        ]),
      ),
    );
  }


  String _formatDateTime(int? timestamp) {
    if (timestamp == null) return 'Fecha no disponible';

    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(dateTime);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}
