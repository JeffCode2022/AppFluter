import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:lottie/lottie.dart'; // Asegúrate de agregar esta dependencia en tu pubspec.yaml

import 'package:delivery_autonoma/src/screens/cliente/paymets/status/client_payments_status_controllers.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';

class ClientPaymentsStatusPage extends StatefulWidget {
  const ClientPaymentsStatusPage({super.key});

  @override
  State<ClientPaymentsStatusPage> createState() =>
      _ClientPaymentsStatusPageState();
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _clipPathOval(), // Lottie animation
          _textPaymentSuccessful(),
          SizedBox(height: 300),
           // Payment success message
           _buttonNext(),
        ],
      ),
      // Button to navigate to the product list
    );
  }

  Widget _textPaymentSuccessful() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Text(
        'Tu orden fue procesada exitosamente usando (${controller.mercadoPagoPayment?.paymentMethodId?.toUpperCase() ?? ''} **** ${controller.mercadoPagoPayment?.card?.lastFourDigits ?? ''})',
        style: const TextStyle(fontSize: 17),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _clipPathOval() {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        height: 350,
        width: double.infinity,
        color: MyColors.primary,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/json/Animation - 1719869551239.json',height: 200), // Asegúrate de tener este archivo en tu carpeta de assets
              const SizedBox(height: 16), // Espacio entre animación y mensaje
              const Text(
                'Gracias por tu compra',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center, // Centra el texto
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonNext() {
    return Container(
      margin: const EdgeInsets.all(30),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'cliente/products/list');
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
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
