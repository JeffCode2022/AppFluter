import 'package:delivery_autonoma/common/widgets/appbar/appbar.dart';
import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/screens/restaurant/orders/detail/restaurant_orders_detail_controllers.dart';
import 'package:delivery_autonoma/src/widgets/no_data_widget.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/relative_time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RestaurantOrderDetailPage extends StatefulWidget {
  final Order order;

  const RestaurantOrderDetailPage({super.key, required this.order});

  @override
  State<RestaurantOrderDetailPage> createState() =>
      _RestaurantOrderDetailPageState();
}

class _RestaurantOrderDetailPageState extends State<RestaurantOrderDetailPage> {
  final RestaurantOrderDetailController _con =
      RestaurantOrderDetailController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _con.init(context, refresh, widget.order);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.90,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Orden ${_con.order?.id ?? ''}',
              style: const TextStyle(color: Colors.white)),
          showBackArrow: true,
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 10, right: 10),
              child: Text(
                'Total: S/.${_con.total}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: MyColors.dark),
              ),
            ),
          ],
        ),
        body: _con.order != null && _con.order!.products.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _con.order?.products.length ?? 0,
                      itemBuilder: (context, index) {
                        return _cardProduct(_con.order!.products[index]);
                      },
                    ),
                  ),
                  _bottomDetails(),
                  _buttonNext(),
                ],
              )
            : Center(child: NoDataWidget(text: 'Ningún producto agregado...')),
      ),
    );
  }

  Widget _bottomDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(color: Colors.grey[400], endIndent: 30, indent: 30),
          const SizedBox(height: 5), // Reducir el espacio
          _textDescription(),
          _dropDown(_con.users),
          _textData('Cliente:',
              '${_con.order?.client?.name ?? ''} ${_con.order?.client?.lastname ?? ''}'),
          _textData('Entregar en:', _con.order?.address?.address ?? ''),
          _textData('Fecha de pedido:',
              RelativeTimeUtil.getRelativeTime(_con.order?.timestamp ?? 0)),
          const SizedBox(height: 10), // Agregar espacio al final
        ],
      ),
    );
  }

  Widget _buttonNext() {
    return Container(
      margin: const EdgeInsets.all(20), // Ajustar los márgenes
      child: ElevatedButton(
        onPressed: _con.updateOrder,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 60,
                alignment: Alignment.center,
                child: const Text(
                  'DESPACHAR ORDEN',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 50,
                margin: const EdgeInsets.only(right: 40),
                child: Image.asset(
                  TImages.imgReparto,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Row(
        children: [
          _imageProduct(product),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text('Cantidad: ${product.quantity}'),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Column(
            children: [_textPrice(product)],
          ),
        ],
      ),
    );
  }

  Widget _textPrice(Product product) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        'S/. ${(product.price ?? 0) * (product.quantity ?? 0)}',
        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.grey[200],
      ),
      child: FadeInImage(
        image: product.image1 != null
            ? NetworkImage(product.image1!)
            : const AssetImage(TImages.noData) as ImageProvider,
        fit: BoxFit.contain,
        fadeInDuration: const Duration(milliseconds: 50),
        placeholder: const AssetImage(TImages.noData),
      ),
    );
  }

  Widget _textData(String title, String content) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          content,
          maxLines: 2,
        ),
      ),
    );
  }

  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        _con.order?.status == 'PAGADO'
            ? 'Asignar repartidor'
            : 'Repartidor asignado',
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          color: MyColors.primaryColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _dropDown(List<User> users) {
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton<String>(
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
                    'Seleccionar repartidor',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  items: _dropDownItems(users),
                  value: _con.idDelivery,
                  onChanged: (String? option) {
                    setState(() {
                      print('Reparidor selecciondo $option');
                      _con.idDelivery = option;
                      // Lógica para manejar el cambio de opción
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<User> users) {
    List<DropdownMenuItem<String>> list = [];
    for (var user in users) {
      list.add(DropdownMenuItem(
        value: user.id,
        child: Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: FadeInImage(
                image: user.image != null
                    ? NetworkImage(user.image!)
                    : const AssetImage(TImages.noData) as ImageProvider,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 50),
                placeholder: const AssetImage(TImages.noData),
              ),
            ),
            const SizedBox(width: 5),
            Text(user.name!)
          ],
        ),
      ));
    }

    Widget deliveryData() {
      return Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: FadeInImage(
              image: _con.order!.delivery!.image != null
                  ? NetworkImage(_con.order!.delivery!.image!)
                  : const AssetImage(TImages.noData) as ImageProvider,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 50),
              placeholder: const AssetImage(TImages.noData),
            ),
          ),
          const SizedBox(width: 5),
          Text('${_con.order!.delivery!.name!} ${_con.order!.delivery!.lastname!}'),
        ],
      );
     }

    return list;
  }

  void refresh() {
    setState(() {});
  }
}
