// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:delivery_autonoma/src/models/mercado_pago_document_type.dart';
import 'package:delivery_autonoma/src/screens/cliente/paymets/create/client_paymets_create_controllers.dart';
import 'package:delivery_autonoma/utils/constants/colors_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

class ClientPaymetsCreatePage extends StatefulWidget {
  const ClientPaymetsCreatePage({super.key});

  @override
  State<ClientPaymetsCreatePage> createState() =>
      _ClientPaymetsCreatePageState();
}

class _ClientPaymetsCreatePageState extends State<ClientPaymetsCreatePage> {
  final controller = Get.put(ClientPaymentsCreateController());

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagos'),
      ),
      body: ListView(
        children: [
          CreditCardWidget(
            cardNumber: controller.cardNumber!,
            expiryDate: controller.expiryDate!,
            cardHolderName: controller.cardHolderName!,
            cvvCode: controller.cvvCode!,
            showBackView: controller.isCvvFocused,
            onCreditCardWidgetChange: (CreditCardBrand) {},
            bankName: 'AMERICAN EXPRESS',
            floatingConfig: const FloatingConfig(
              isGlareEnabled: true,
              isShadowEnabled: true,
              shadowConfig: FloatingShadowConfig(),
            ),
            textStyle: const TextStyle(color: Colors.white, fontFamily: 'JetBrainsMono', fontSize: 19),
            labelValidThru: 'VALID\nTHRU',
            obscureCardNumber: true,
            obscureInitialCardNumber: false,
            obscureCardCvv: true,
            isHolderNameVisible: true,
            isChipVisible: false,
          ),
          CreditCardForm(
            formKey: controller.keyForm, // Required
            cardNumber: '', // Required
            expiryDate: '', // Required
            cardHolderName: '', // Required
            cvvCode: '', // Required
            onCreditCardModelChange:
                controller.onCreditCardWidgetChange, // Required
            obscureCvv: true,
            obscureNumber: true,
            isHolderNameVisible: true,
            isCardNumberVisible: true,
            isExpiryDateVisible: true,
            enableCvv: true,

            cvvValidationMessage: 'Please input a valid CVV',
            dateValidationMessage: 'Please input a valid date',
            numberValidationMessage: 'Please input a valid number',
            cardNumberValidator: (String? cardNumber) {},
            expiryDateValidator: (String? expiryDate) {},
            cvvValidator: (String? cvv) {},
            cardHolderValidator: (String? cardHolderName) {},
            onFormComplete: () {
              // callback to execute at the end of filling card data
            },
            autovalidateMode: AutovalidateMode.always,
            disableCardNumberAutoFillHints: false,
            inputConfiguration: const InputConfiguration(
              cardNumberDecoration: InputDecoration(
                fillColor: Colors.black12,
                filled: true,
                border: OutlineInputBorder(),
                labelText: 'Numero de la tarjeta',
                hintText: 'XXXX XXXX XXXX XXXX',
              ),
              expiryDateDecoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'fecha de expiracion',
                hintText: 'XX/XX',
              ),
              cvvCodeDecoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CVV',
                hintText: 'XXX',
              ),
              cardHolderDecoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre del titula',
              ),
              cardNumberTextStyle: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              cardHolderTextStyle: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              expiryDateTextStyle: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              cvvCodeTextStyle: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          _documentInfo(),
          _buttonNext(),
        ],
      ),
    );
  }

  Widget _buttonNext() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed:controller.createCardToken,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primary.withOpacity(0.8),
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 50, top: 9),
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

  Widget _documentInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Material(
              elevation: 2.0,
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButton(
                        underline: Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.arrow_drop_down_circle,
                            color: MyColors.primary,
                          ),
                        ),
                        elevation: 3,
                        isExpanded: true,
                        hint: const Text(
                          'Tipo doc',
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                        items: _dropDownItems(controller.documentTypesList),
                        value: controller.typeDocument,
                        onChanged: (option) {
                          setState(() {
                            // ignore: avoid_print
                            print('Reparidor selecciondo $option');
                            controller.typeDocument = option
                                as String; // ESTABLECIENDO EL VALOR SELECCIONADO
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Flexible(
            
            flex: 4,
            child: TextField(
              controller: controller.documentNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Numero de documento'),
            ),
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(
      List<MercadoPagoDocumentType> documentType) {
    List<DropdownMenuItem<String>> list = [];
    for (var document in documentType) {
      list.add(DropdownMenuItem(
        value: document.id,
        child: Container(
          margin: const EdgeInsets.only(top: 7),
          child: Text(document.name!),
        ),
      ));
    }

    return list;
  }

  void refresh() {
    setState(() {});
  }
}
