import 'package:delivery_autonoma/src/screens/cliente/paymets/status/client_payments_status_controllers.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ClientPaymentsStatusPage extends StatefulWidget {
  const ClientPaymentsStatusPage({super.key});

  @override
  State<ClientPaymentsStatusPage> createState() => _ClientPaymentsStatusPageState();

}

class _ClientPaymentsStatusPageState extends State<ClientPaymentsStatusPage> {

  final controller = Get.put(ClientPaymentsStatusController());

    @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      controller.init(context, refresh);
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _clipPathOval(),
          _textCardDetail(),
          _textCardStatus()
        ],
      ),
      // ignore: sized_box_for_whitespace
      bottomNavigationBar: Container(
        height: 100,
        child: _buttonNext(),
      ),
    );
  }

  Widget _textCardDetail() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: controller.mercadoPagoPayment?.status == 'approved'
       ? Text(
       'Tu orden fue procesada exitosamente usando (${controller.mercadoPagoPayment?.paymentMethodId?.toUpperCase() ?? ''} **** ${controller.mercadoPagoPayment?.card?.lastFourDigits ?? ''})',
        style: const TextStyle(
          fontSize: 17
        ),
       textAlign: TextAlign.center,
     )
       : const Text(
         'Tu pago fue rechazado',
       style: TextStyle(
            fontSize: 17
        ),
        textAlign: TextAlign.center,
     ),
    );
  }

    Widget _textCardStatus() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: controller.mercadoPagoPayment?.status == 'approved'
      ? const Text(
        'Mira el estado de tu compra en la seccion de MIS PEDIDOS',
        style: TextStyle(
          fontSize: 17
        ),
        textAlign: TextAlign.center,
      )
      : Text(
        controller.errorMessage ?? '',
        style: const TextStyle(
            fontSize: 17
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

   Widget _clipPathOval() {
  return ClipPath(
    clipper: OvalBottomBorderClipper(),
    child: Container(
      height: 250,
      width: double.infinity,
      color: MyColors.primary,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.mercadoPagoPayment?.status == 'approved')
              const Icon(Icons.check_circle, color: Colors.green, size: 150)
            else
              const Icon(Icons.cancel, color: Colors.red, size: 150),
            const SizedBox(height: 16),  // Added space between icon and text
            Text(
              controller.mercadoPagoPayment?.status == 'approved'
                  ? 'Gracias por tu compra'
                  : 'Falló la transacción',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,  // Centered the text
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget  _buttonNext(){
    return Container(
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'cliente/products/list');
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'FINALIZAR COMPRA',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 50, top: 2),
                height: 30,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

   void refresh() {
    setState(() {});
  }
}

