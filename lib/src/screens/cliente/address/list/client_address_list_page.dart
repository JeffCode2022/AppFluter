import 'package:delivery_autonoma/common/widgets/appbar/appbar.dart';
import 'package:delivery_autonoma/src/models/address.dart';
import 'package:delivery_autonoma/src/widgets/no_data_widget.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'client_address_list_controllers.dart';

class ClientAddressListPage extends StatefulWidget {
  const ClientAddressListPage({super.key});

  @override
  State<ClientAddressListPage> createState() => _ClientAddressListPageState();
}

class _ClientAddressListPageState extends State<ClientAddressListPage> {
  final ClientAddressListController _contr = ClientAddressListController();

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
      appBar: TAppBar(
        title: const Text('Direcciones', style: TextStyle(color: Colors.white)),
        showBackArrow: true,
        actions: [_iconAdd()],
      ),
      body: Stack(
        children: [
          Positioned(top: 0, child: _textSelectAddress()),
          Container(margin: const EdgeInsets.only(top: 50), child: _listAddress())
        ],
      ),
      bottomNavigationBar: _buttonAccept(),
    );
  }

  Widget _noAddress() {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
          alignment: Alignment.center,
          margin: const EdgeInsets.all(20),
          child: NoDataWidget(text: 'No tienes ninguna direccion '),
        ),
        _buttonNewAddress()
      ],
    );
  }

  Widget _buttonNewAddress() {
    return SizedBox(
      child: TextButton(
        onPressed: _contr.addAddress,
        child: const Text('Agregar una direccion'),
      ),
    );
  }

  Widget _buttonAccept() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: MyColors.primaryColor),
        child: const Text('ACEPTAR'),
      ),
    );
  }

  Widget _listAddress() {
    return FutureBuilder(
        future: _contr.getAddress(),
        builder: (context, AsyncSnapshot<List<Address>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (_, index) {
                    return _radioSelectAddress(snapshot.data![index], index);
                  });
            } else {
              return _noAddress();
            }
          } else {
            return _noAddress();
          }
        });
  }

  Widget _radioSelectAddress(Address address, int index) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: index,
                  groupValue: _contr.radioValue,
                  onChanged: (int? value) {
                    _contr.handleRadioValueChange(value ?? 0);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.address ?? '',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      address.neighborhood ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    // quiero obtener la referencia de la direccion latitude y longitud para mostrar en la lista  pero  que este en texto asi como la direccion y el distrito
                    Text(
                      address.lat.toString(),                      
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    
                                        
                    
                    
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.grey[400],
            )
          ],
        ));
  }

  Widget _textSelectAddress() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: const Text(
        'Elige donde recibir tus compras',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _iconAdd() {
    return IconButton(
        onPressed: _contr.addAddress,
        icon: const Icon(Icons.add, color: Colors.white));
  }

  void refresh() {
    setState(() {});
  }
}
