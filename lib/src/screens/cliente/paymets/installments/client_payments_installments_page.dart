import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:delivery_autonoma/common/widgets/appbar/appbar.dart';
import 'package:delivery_autonoma/src/models/mercado_pago_installment.dart';
import 'package:delivery_autonoma/src/screens/cliente/paymets/installments/client_payments_installments_controller.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';

class ClientPaymentsInstallmentsPage extends StatefulWidget {
  const ClientPaymentsInstallmentsPage({Key? key}) : super(key: key);

  @override
  State<ClientPaymentsInstallmentsPage> createState() =>
      _ClientPaymentsInstallmentsPageState();
}

class _ClientPaymentsInstallmentsPageState
    extends State<ClientPaymentsInstallmentsPage> {
  final controller = Get.put(ClientPaymentsInstallmentsControllers());

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
      appBar: const TAppBar(
        title: Text('Cuotas'),
        showBackArrow: true,
      ),
      body: Column(
        children: [
          _textDescription(),
          _dropDownInstallments(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 140,
        child: Column(
          children: [
            _textTotalPrice(),
            _buttonNext(),
          ],
        ),
      ),
    );
  }

  Widget _textDescription() {
    return Container(
      margin: const EdgeInsets.all(30),
      child: const Text(
        'En cuantas cuotas?',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _textTotalPrice() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total a pagar:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          GetBuilder<ClientPaymentsInstallmentsControllers>(
            builder: (controller) => Text(
              'S/${controller.totalPymets}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonNext() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: controller.createPay,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'CONFIRMAR PAGO',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 50, top: 9),
                height: 30,
                child: const Icon(
                  Icons.attach_money,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDownInstallments() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: GetBuilder<ClientPaymentsInstallmentsControllers>(
            builder: (controller) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton(
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
                      'Seleccionar número de cuotas',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    items: _dropDownItems(controller.installmentsList),
                    value: controller.selectedInstallment,
                    onChanged: (option) {
                      setState(() {
                        controller.selectedInstallment = option as String?;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(
      List<MercadoPagoInstallment> installmentsList) {
    return installmentsList.map((installment) {
      return DropdownMenuItem(
        value: '${installment.installments}',
        child: Container(
          margin: const EdgeInsets.only(top: 7),
          child: Text('${installment.installments}'),
        ),
      );
    }).toList();
  }

  void refresh() {
    setState(() {});
  }
}
