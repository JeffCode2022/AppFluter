import 'dart:convert';
import 'package:delivery_autonoma/src/models/mercado_pago_card_token.dart';
import 'package:delivery_autonoma/src/models/mercado_pago_document_type.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/mercado_pago_provider.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

class ClientPaymetsCreateControllers extends GetxController {
  BuildContext? context;
  Function? refreshPage;

  GlobalKey<FormState> keyform = GlobalKey();
  TextEditingController documentNumberController = TextEditingController();

  String? cardNumber = '';
  String? expiryDate = '';
  String? cardHolderName = '';
  String? cvvCode = '';
  bool isCvvFocused = false;

  User? user = User();

  SharedPref sharedPref = SharedPref();

  List<MercadoPagoDocumentType> documentTypesList = [];
  MercadoPagoProvider mercadoPagoProvider = MercadoPagoProvider();

  String typeDocument = 'DNI';
  String? expirationYear;
  int? expirationMonth;

  MercadoPagoCardToken? cardToken;

  Future init(BuildContext context, Function refreshPage) async {
    this.context = context;
    this.refreshPage = refreshPage;
    mercadoPagoProvider.init(context, user!);
    user = User.fromJson(await sharedPref.read('user'));

    getIdetificationTypes();
  }

  void getIdetificationTypes() async {
    documentTypesList = await mercadoPagoProvider.getIdentificationTypes();

    documentTypesList.forEach((document) {
      print('Documento: ${document.toJson()}');
    });

    refreshPage!();
  }

  void onCreditCardWidgetChange(CreditCardModel creditCardModel) {
    cardNumber = creditCardModel.cardNumber;
    expiryDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
    refreshPage!();
    // ignore: avoid_print
    print(CreditCardModel);
  }

   void createCardToken() async {

    String documentNumber = documentNumberController.text;

    if (cardNumber!.isEmpty) {
      return;
    }

    if (expiryDate!.isEmpty) {
      MySnackBar.warningSnackBar(title: 'Error', message: 'Ingresa la fecha de expiracion de la tarjeta');
      return;
    }

    if (cvvCode!.isEmpty) {
      MySnackBar.warningSnackBar(title: 'Error', message: 'Ingresa el codigo de seguridad de la tarjeta');
      return;
    }

    if (cardHolderName!.isEmpty) {
      MySnackBar.warningSnackBar(title: 'Error', message: 'Ingresa el nombre del titular de la tarjeta');
      return;
    }

    if (documentNumber.isEmpty) {
      MySnackBar.warningSnackBar(title: 'Error', message: 'Ingresa el numero de documento');
      return;
    }
    
    if (expiryDate != null) {
      List<String> list = expiryDate!.split('/');
      if (list.length == 2) {
        expirationMonth = int.parse(list[0]);
        expirationYear = '20${list[1]}';
      }
      else {
        MySnackBar.show(context!, 'Error en la fecha de expiracion');
        return;
      }
    }

    if (cardNumber != null) {
      cardNumber = cardNumber!.replaceAll(RegExp(' '), '');
    }

    print('CVV: $cvvCode');
    print('Card Number: $cardNumber');
    print('cardHolderName: $cardHolderName');
    print('documentId: $typeDocument');
    print('documentNumber: $documentNumber');
    print('expirationYear: $expirationYear');
    print('expirationMonth: $expirationMonth');

    Response response = await mercadoPagoProvider.createCardToken(
      cvv: cvvCode!,
      cardNumber: cardNumber!,
      cardHolderName: cardHolderName!,
      documentId: typeDocument,
      documentNumber: documentNumber,
      expirationYear: expirationYear!,
      expirationMonth: expirationMonth!,
    );

    if (response != null) {
      final data = json.decode(response.body);

      if (response.statusCode == 201) {
        cardToken =  MercadoPagoCardToken.fromJsonMap(data);
        print('TOKEN DE LA TARJETA: ${cardToken!.toJson()}');
         Navigator.pushNamed(context!, 'client/payments/installments', arguments: {
        'identification_type': typeDocument,
        'identification_number': documentNumber,
        'card_token': cardToken!.toJson(),
        });

      }
      else {
        print('HUBO UN ERROR GENERANDO EL TOKEN DE LA TARJETA');
        int? status = int.tryParse(data['cause'][0]['code'] ?? data['status']);
        String message = data['message'] ?? 'Error al registrar la tarjeta';
        MySnackBar.show(context!, message);
      }
    }

  }
}