import 'package:delivery_autonoma/common/widgets/appbar/appbar.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/screens/cliente/orders/create/client_orders_create_controllers.dart';
import 'package:delivery_autonoma/src/widgets/no_data_widget.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:delivery_autonoma/utils/constants/image_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ClientOrdersCreatePage extends StatefulWidget {
  const ClientOrdersCreatePage({super.key});

  @override
  State<ClientOrdersCreatePage> createState() => _ClientOrdersCreatePageState();
}

class _ClientOrdersCreatePageState extends State<ClientOrdersCreatePage> {
  final ClientOrdersCreateController _con = ClientOrdersCreateController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi orden',
          style: TextStyle(fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAndToNamed('cliente/products/list');
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.235,
        child: Column(
          children: [
            Divider(
              color: Colors.grey[400],
              endIndent: 30, // DERECHA
              indent: 30, //IZQUIERDA
            ),
            _textTotalPrice(),
            _buttonNext()
          ],
        ),
      ),
      body: _con.selectedProducts.isNotEmpty
          ? ListView(
              children: _con.selectedProducts.map((Product product) {
                return _cardProduct(product);
              }).toList(),
            )
          : Container(
              padding: const EdgeInsets.only(
                  top: 50, bottom: 50, left: 20, right: 20),
              alignment: Alignment.center,
              margin: const EdgeInsets.all(20),
              child: NoDataWidget(text: 'Ningún producto agregado...'),
            ),
    );
  }

  Widget _buttonNext() {
    return Container(
      margin: const EdgeInsets.only(left: 50, right: 50, top: 30, bottom: 30),
      child: ElevatedButton(
        onPressed: _con.gotoAddressList,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: MyColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'CONTINUAR',
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
                margin: const EdgeInsets.only(left: 70, top: 9, bottom: 9),
                height: 30,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.lightGreen[400],
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          const SizedBox(width: 10),
          Column(
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
              const SizedBox(height: 10),
              _addOrRemoveItem(product)
            ],
          ),
          const Spacer(),
          Column(
            children: [_textPrice(product), _iconDelete(product)],
          )
        ],
      ),
    );
  }

  Widget _iconDelete(Product product) {
    return IconButton(
      onPressed: () {
        _con.deleteItem(product);
      },
      icon: const Icon(
        Icons.delete,
        color: MyColors.primaryColor,
      ),
    );
  }

  Widget _textTotalPrice() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Text(
            'S/.${_con.total}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget _textPrice(Product product) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        'S/. ${product.price! * product.quantity!}',
        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return Container(
      width: 90,
      height: 90,
      padding: const EdgeInsets.all(10),
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

  Widget _addOrRemoveItem(Product product) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _con.removeItem(product);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
                color: Colors.grey[200]),
            child: const Text('-'),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          color: Colors.grey[200],
          child: Text('${product.quantity ?? 0}'),
        ),
        GestureDetector(
          onTap: () {
            _con.addItem(product);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                color: Colors.grey[200]),
            child: const Text('+'),
          ),
        ),
      ],
    );
  }

  refresh() {
    setState(() {});
  }
}
