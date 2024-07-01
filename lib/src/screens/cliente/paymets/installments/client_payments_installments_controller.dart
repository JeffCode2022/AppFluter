import 'dart:convert';
import 'package:delivery_autonoma/src/models/address.dart';
import 'package:delivery_autonoma/src/models/mercado_pago_card_token.dart';
import 'package:delivery_autonoma/src/models/mercado_pago_installment.dart';
import 'package:delivery_autonoma/src/models/mercado_pago_issuer.dart';
import 'package:delivery_autonoma/src/models/mercado_pago_payment.dart';
import 'package:delivery_autonoma/src/models/mercado_pago_payment_method_installments.dart';
import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/models/product.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/mercado_pago_provider.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientPaymentsInstallmentsControllers  {
  BuildContext? context;
  Function? refreshPage;
  User? user = User();

  final MercadoPagoProvider _mercadoPagoProvider = MercadoPagoProvider();
  final SharedPref sharedPref = SharedPref();

  MercadoPagoCardToken? cardToken;
  List<Product> selectedProducts = [];
  double totalPymets = 0;
  MercadoPagoPaymentMethodInstallments? installments;
  List<MercadoPagoInstallment> installmentsList = [];
  MercadoPagoIssuer? issuer;
  MercadoPagoPayment? creditCardPayment;

  String? selectedInstallment;
  Address? address;
  ProgressDialog? progressDialog;
  String? identificationType;
  String? identificationNumber;
  
  Future init(BuildContext context, Function refreshPage) async {
    this.context = context;
    this.refreshPage = refreshPage;

    Map<String, dynamic> arguments =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    cardToken = MercadoPagoCardToken.fromJsonMap(arguments['card_token']);
    identificationType = arguments['identification_type'];
    identificationNumber = arguments['identification_number'];

    progressDialog = ProgressDialog(context: context);

    selectedProducts =
        Product.fromJsonList(await sharedPref.read('order')).toList();
    user = User.fromJson(await sharedPref.read('user'));
    address = Address.fromJson(await sharedPref.read('address'));

    _mercadoPagoProvider.init(context, user!);
    getTotal();
    getInstallments();
  }

  void getInstallments() async {
    installments = await _mercadoPagoProvider.getInstallments(cardToken!.firstSixDigits!, totalPymets);
    print('OBJECT INSTALLMENTS: ${installments?.toJson()}');

    if (installments != null) {
      installmentsList = installments!.payerCosts;
      issuer = installments!.issuer;
      refreshPage!();
    } else {
      MySnackBar.show(context!, 'Failed to fetch installments');
    }
  }

  void getTotal() {
    totalPymets = 0;
    selectedProducts.forEach((product) {
      totalPymets += (product.quantity! * product.price!);
    });
    refreshPage!();
  }

  void createPay() async {
    if (selectedInstallment == null) {
      MySnackBar.show(context!, 'Debes seleccionar el número de cuotas');
      return;
    }

    if (cardToken == null || address == null || user == null) {
      MySnackBar.show(context!, 'Missing necessary data');
      return;
    }

    Order order = Order(
      idAddress: address!.id,
      idClient: user!.id,
      products: selectedProducts
    );

    progressDialog?.show(max: 100, msg: 'Realizando transacción');

    Response? response = await _mercadoPagoProvider.createPayment(
        cardId: cardToken!.cardId,
        transactionAmount: totalPymets,
        installments: int.parse(selectedInstallment!),
        paymentMethodId: installments!.paymentMethodId,
        paymentTypeId: installments!.paymentTypeId,
        issuerId: installments!.issuer!.id,
        emailCustomer: user!.email,
        cardToken: cardToken!.id,
        identificationType: identificationType,
        identificationNumber: identificationNumber,
        order: order
    );
    progressDialog?.close();

    if (response != null) {
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        if (response.body.isNotEmpty) {
          try {
            final data = json.decode(response.body);
            creditCardPayment = MercadoPagoPayment.fromJsonMap(data);
            Navigator.pushNamedAndRemoveUntil(context!, 'client/payments/status', (route) => false, arguments: creditCardPayment?.toJson());
          } catch (e) {
            print('Error decoding JSON: $e');
            MySnackBar.show(context!, 'Payment successful, but there was an error processing the response');
          }
        } else {
          MySnackBar.show(context!, 'Payment successful, but no further information available');
          Navigator.pushNamedAndRemoveUntil(context!, 'client/payments/status', (route) => false, arguments: {'status': 'success'});
        }
      } else if (response.statusCode == 400) {
        final data = json.decode(response.body);
        badRequestProcess(data);
      } else if (response.statusCode == 401) {
        final data = json.decode(response.body);
        badTokenProcess(data['status'], installments!);
      } else {
        print('Unexpected status code: ${response.statusCode}');
        MySnackBar.show(context!, 'Unexpected error occurred. Please try again.');
      }
    } else {
      print('Response is null');
      MySnackBar.show(context!, 'Failed to connect to the server');
    }
  }

  void badRequestProcess(dynamic data) {
    Map<String, String> paymentErrorCodeMap = {
      '3034': 'Informacion de la tarjeta invalida',
      '205': 'Ingresa el número de tu tarjeta',
      '208': 'Digita un mes de expiración',
      '209': 'Digita un año de expiración',
      '212': 'Ingresa tu documento',
      '213': 'Ingresa tu documento',
      '214': 'Ingresa tu documento',
      '220': 'Ingresa tu banco emisor',
      '221': 'Ingresa el nombre y apellido',
      '224': 'Ingresa el código de seguridad',
      'E301': 'Hay algo mal en el número. Vuelve a ingresarlo.',
      'E302': 'Revisa el código de seguridad',
      '316': 'Ingresa un nombre válido',
      '322': 'Revisa tu documento',
      '323': 'Revisa tu documento',
      '324': 'Revisa tu documento',
      '325': 'Revisa la fecha',
      '326': 'Revisa la fecha'
    };
    String? errorMessage;
    print('CODIGO ERROR ${data['err']['cause'][0]['code']}');

    if (paymentErrorCodeMap.containsKey('${data['err']['cause'][0]['code']}')) {
      errorMessage = paymentErrorCodeMap['${data['err']['cause'][0]['code']}'];
    } else {
      errorMessage = 'No pudimos procesar tu pago';
    }
    MySnackBar.show(context!, errorMessage!);
  }

  void badTokenProcess(String status, MercadoPagoPaymentMethodInstallments installments) {
    Map<String, String> badTokenErrorCodeMap = {
      '106': 'No puedes realizar pagos a usuarios de otros paises.',
      '109': '${installments.paymentMethodId} no procesa pagos en ${selectedInstallment} cuotas',
      '126': 'No pudimos procesar tu pago.',
      '129': '${installments.paymentMethodId} no procesa pagos del monto seleccionado.',
      '145': 'No pudimos procesar tu pago',
      '150': 'No puedes realizar pagos',
      '151': 'No puedes realizar pagos',
      '160': 'No pudimos procesar tu pago',
      '204': '${installments.paymentMethodId} no está disponible en este momento.',
      '801': 'Realizaste un pago similar hace instantes. Intenta nuevamente en unos minutos',
    };
    String? errorMessage;
    if (badTokenErrorCodeMap.containsKey(status.toString())) {
      errorMessage = badTokenErrorCodeMap[status];
    } else {
      errorMessage = 'No pudimos procesar tu pago';
    }
    MySnackBar.show(context!, errorMessage!);
  }
}
