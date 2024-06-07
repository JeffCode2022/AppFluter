import 'package:delivery_autonoma/common/widgets/appbar/tabbar.dart';
import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/screens/restaurant/orders/list/restaurant_orders_list_controllers.dart';
import 'package:delivery_autonoma/src/widgets/no_data_widget.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class RestaurantOrderListPage extends StatefulWidget {
  const RestaurantOrderListPage({
    super.key,
  });

  @override
  State<RestaurantOrderListPage> createState() => _RestaurantOrderListPageState();
}

class _RestaurantOrderListPageState extends State<RestaurantOrderListPage> {
  final RestaurantProductsListControllers _contr = RestaurantProductsListControllers();

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
      child: Scaffold(
        key: _contr.key,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: AppBar(
            automaticallyImplyLeading: false,
            actions: [],
            flexibleSpace: Column(
              children: [
                const SizedBox(height: 50),
                _menuDrawer(),
              ],
            ),
            bottom: _contr.status.isNotEmpty
                ? TTabBar(
                    tabs: List<Widget>.generate(_contr.status.length, (index) {
                      return Tab(
                        child: Text(_contr.status[index] ?? ''),
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
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return _cardOrder(snapshot.data![index]);
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
    );
  }

  Widget _cardOrder(Order order) {
    return GestureDetector(
      onTap: () {
        _contr.openBottomShet(order);
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(20),
        child: Card(
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Order N°${order.id}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SFProDisplay',
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40, left: 20, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pedido: ${_formatDateTime(order.timestamp)}',
                      style: const TextStyle(fontSize: 20),
                      maxLines: 1,
                    ),
                    Text(
                      'Cliente: ${order.client?.name ?? ''} ${order.client?.lastname ?? ''}',
                      style: const TextStyle(fontSize: 20),
                      maxLines: 1,
                    ),
                    Text(
                      'Entregar en: ${order.address?.address ?? ''}',
                      style: const TextStyle(fontSize: 20),
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _contr.openDrawer,
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset(TImages.imgHome, width: 30, height: 30),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            gradient: MyColors.warmGrey,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_contr.user?.name ?? ''} ${_contr.user?.lastname ?? ''}',
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
              Text(
                _contr.user?.email ?? '',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                maxLines: 1,
              ),
              Text(
                _contr.user?.phone ?? '',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
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
          title: const Text('Crear Categoría'),
          trailing: Image.asset(TImages.categoria, width: 30, height: 30),
          onTap: _contr.goToCategoriesCreate,
        ),
        ListTile(
          title: const Text('Crear producto'),
          trailing: Image.asset(TImages.addProduct, width: 30, height: 30),
          onTap: _contr.goToProductsCreate,
        ),
        _contr.user != null && _contr.user!.roles.length > 1
            ? ListTile(
                onTap: _contr.goToRoles,
                title: const Text('Seleccionar Rol'),
                trailing: Image.asset(TImages.roles, width: 30, height: 30),
              )
            : Container(),
        ListTile(
          title: const Text('Cerrar Sesión'),
          trailing: Image.asset(TImages.logout, width: 30, height: 30),
          onTap: _contr.logout,
        ),
      ]),
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
