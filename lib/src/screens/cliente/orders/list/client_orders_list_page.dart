import 'package:delivery_autonoma/common/containers/rounder_container.dart';
import 'package:delivery_autonoma/common/widgets/appbar/tabbar.dart';
import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/screens/cliente/orders/list/client_orders_list_controller.dart';
import 'package:delivery_autonoma/src/widgets/no_data_widget.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ClientOrdersListPage extends StatefulWidget {
  const ClientOrdersListPage({
    super.key,
  });

  @override
  State<ClientOrdersListPage> createState() => _ClientOrdersListPageState();
}

class _ClientOrdersListPageState extends State<ClientOrdersListPage> {
  final ClientOrdersListControllers _contr = ClientOrdersListControllers();

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
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            title: const Text('Mis Ordenes',
                style: TextStyle(
                    color: MyColors.dark,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
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
    );
  }

  String _formatDateTime(int? timestamp) {
    if (timestamp == null) return 'Fecha no disponible';

    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(dateTime);
  }

  Widget _orderCard(Order order) {
    return GestureDetector(
      onTap: () {
        _contr.openBottomSheet(context, order, () {
          // Actualiza la UI después de cerrar el modal si es necesario.
          setState(() {});
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: MyColors.grey.withOpacity(0.5),
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
          backgroundColor: MyColors.darkGrey.withOpacity(0.1),
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
                          ' ${order.status}',
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: MyColors.primary),
                        ),
                        Text(
                          ' ${order.address?.address ?? 'Dirección no disponible'} ',
                          style: const TextStyle(
                              fontSize: 15, color: MyColors.dark),
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
              const SizedBox(height: TSizes.spaceBtwItems / 2),

              //---------------------ROW- 2-------
              /// datos del repartidor
              Row(
                children: [
                  //-----icon
                  const CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage(TImages.imgReparto),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),

                  //--- status & date
                  Expanded(
                    child: Text(
                      ' Repartidor:  ${order!.delivery?.name ?? 'Repartidor no asignado'} ${order!.delivery?.lastname ?? ''} ',
                      style:
                          const TextStyle(fontSize: 15, color: MyColors.dark),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.defaultSpace),

              //---------------------ROW 3--------
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        //-----icon
                        const Icon(Iconsax.tag),
                        const SizedBox(width: TSizes.spaceBtwItems / 1),

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

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}
