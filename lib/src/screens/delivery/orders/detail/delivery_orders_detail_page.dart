import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/screens/delivery/orders/detail/delivery_orders_detail_controllers.dart';
import 'package:delivery_autonoma/src/widgets/no_data_widget.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:delivery_autonoma/utils/constants/relative_time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconsax/iconsax.dart';

class DeliveryOrderDetailPage extends StatefulWidget {
  final Order order;

  const DeliveryOrderDetailPage({super.key, required this.order});

  @override
  State<DeliveryOrderDetailPage> createState() =>
      _DeliveryOrderDetailPageState();
}

class _DeliveryOrderDetailPageState extends State<DeliveryOrderDetailPage> {
  final DeliveryOrderDetailController _con = DeliveryOrderDetailController();

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
      height: MediaQuery.of(context).size.height * 0.75,
      child: Scaffold(
        appBar: AppBar(
          title: Row(children: [
            const Icon(
              Iconsax.tag,
              color: MyColors.dark,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text('Orden [# ${_con.order?.id ?? ''}]',
                style: const TextStyle(color: Colors.black, fontSize: 15)),
          ]),
          actions: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 0, right: 20),
              child: Text(
                'Total: S/.${_con.total}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
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
                  _con.order!.status == 'DESPACHADO'
                      ? _buttonNext()
                      : _buttonNext(),
                  const SizedBox(height: 30),
                ],
              )
            : Center(
                child: NoDataWidget(
                    text: 'Aun no tienes pedido !! para despacho...')),
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
          _textData(
              iconData: Iconsax.user
            ,'Cliente:',
              '${_con.order?.client?.name ?? ''} ${_con.order?.client?.lastname ?? ''}',
              style: const TextStyle(color: MyColors.primary, fontSize: 16)),
          _textData(
              iconData: Iconsax.home,
            'Entregar en:', _con.order?.address?.address ?? ''),
          _textData(
              iconData: Iconsax.calendar,
            'Fecha de pedido:',
              RelativeTimeUtil.getRelativeTime(_con.order?.timestamp ?? 0)),
          const SizedBox(height: 30), // Agregar espacio al final
        ],
      ),
    );
  }

  Widget _buttonNext() {
  return Visibility(
    visible: _con.order?.status != 'ENTREGADO',
    child: Container(
      margin: const EdgeInsets.only(left: 40, right: 30, top: 5, bottom: 20),
      child: ElevatedButton(
        onPressed: _con.updateOrder,
        style: ElevatedButton.styleFrom(
            backgroundColor:
                _con.order?.status == 'DESPACHADO' ? Colors.blue : Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  _con.order?.status == 'DESPACHADO'
                      ? 'INICIAR ENTREGA'
                      : 'IR AL MAPA',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 50,
                margin: const EdgeInsets.only(left: 60),
                child: Image.asset(
                  TImages.imgReparto,
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ],
        ),
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

Widget _textData(String title, String content, {TextStyle? style, required IconData iconData}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: ListTile(
      leading: Icon(iconData), // Agregar icono como parte del ListTile
      title: Text(title),
      subtitle: Text(
        content,
        maxLines: 2,
        style: style,
      ),
    ),
  );
}



  Widget _textDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: const ListTile(
        title: Text('Detalles del pedido'),
      ),
    );
  }

  void refresh() {
    if (!mounted) return;
    setState(() {});
  }
}
