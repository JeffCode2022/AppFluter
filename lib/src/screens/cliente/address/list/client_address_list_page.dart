import 'package:delivery_autonoma/common/widgets/appbar/appbar.dart';
import 'package:delivery_autonoma/src/models/address.dart';
import 'package:delivery_autonoma/src/widgets/no_data_widget.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/sizes.dart';
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
        title: const Text(
          'Direcciones',
          style: TextStyle(fontSize: 20),
        ),
        showBackArrow: true,
        actions: [_iconAdd()],
      ),
      body: Stack(
        children: [
          Positioned(top: 0, child: _textSelectAddress()),
          Container(
              margin: const EdgeInsets.only(top: 50), child: _listAddress())
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
            child: NoDataWidget(text: 'No tienes ninguna direccion ')),
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
      margin: const EdgeInsets.only(
        bottom: 70,
        left: 60,
        right: 60,
      ),
      child: ElevatedButton(
        onPressed: _contr.createOrder,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: MyColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 25,
          ),
          textStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          elevation: 5,
        ),
        child: const Text(
          'Aceptar',
        ),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.address ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      address.neighborhood ?? '',
                      style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Divider(
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }

  Widget _textSelectAddress() {
    return Container(
      alignment: Alignment.centerLeft,
      margin:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Reducido
      child: const Text(
        'Elige donde recibir tus compras',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold), // Tamaño reducido
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Widget _iconAdd() {
    return IconButton(
        onPressed: _contr.addAddress,
        icon: const Icon(Icons.add, color: Colors.black));
  }

  void refresh() {
    setState(() {});
  }
}
