import 'package:delivery_autonoma/src/screens/delivery/orders/list/delivery_orders_list_controller.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';

class DeliveryOrderListPage extends StatefulWidget {
  const DeliveryOrderListPage({super.key});

  @override
  State<DeliveryOrderListPage> createState() => _DeliveryOrderListPageState();
}

class _DeliveryOrderListPageState extends State<DeliveryOrderListPage> {
  final DeliveryOrdersListController _contr = DeliveryOrdersListController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _contr.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _contr.key,
      drawer: _drawer(),
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        leading: _menuDrawer(),
      ),
      body: const Center(child: Text('Delivery Order List')),
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
          decoration: const BoxDecoration(color: MyColors.primaryColor),
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
                _contr.user?.email ??'',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                maxLines: 1,
              ),
              Text(
                _contr.user?.phone ??'',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                maxLines: 1,
              ),
               Container(
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
            ],
          ),
        ),
        _contr.user != null ?  
        _contr.user!.roles.length > 1 ?
         ListTile(
          onTap: _contr.goToRoles,
          title: const Text('Seleccionar Rol'),
          trailing: const Icon(Iconsax.user),
          
        ): Container(): Container(),
        ListTile(
          title: const Text('Cerrar Sesión'),
          trailing: const Icon(Iconsax.logout),
          onTap: _contr.logout,
        ),
      ]),
    );
  }
  void refresh(){
    setState(() {});
  }
}
