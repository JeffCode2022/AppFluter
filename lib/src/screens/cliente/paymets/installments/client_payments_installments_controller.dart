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
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientPaymentsInstallmentsControllers extends GetxController {
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
    // ignore: use_build_context_synchronously

    cardToken = MercadoPagoCardToken.fromJsonMap(arguments['card_token']);
    identificationType = arguments['identification_type'];
    identificationNumber = arguments['identification_number'];

    // ignore: use_build_context_synchronously
    progressDialog = ProgressDialog(context: context);

    selectedProducts =
        Product.fromJsonList(await sharedPref.read('order')).toList();
    user = User.fromJson(await sharedPref.read('user'));

    address = Address.fromJson(await sharedPref.read('address'));

    // ignore: use_build_context_synchronously
    _mercadoPagoProvider.init(context, user!);

    getTotal();
    getInstallments();
  }

  void getInstallments() async {
    installments = await _mercadoPagoProvider.getInstallments(
        cardToken!.firstSixDigits!, totalPymets);
    print('OBJECT INSTALLMENTS: ${installments?.toJson()}');

    installmentsList = installments!.payerCosts;
    issuer = installments?.issuer;

    refreshPage!();
  }

  void getTotal() {
    totalPymets = 0;
    // ignore: avoid_function_literals_in_foreach_calls
    selectedProducts.forEach((product) {
      totalPymets = totalPymets + (product.quantity! * product.price!);
    });
    refreshPage!();
  }

  void createPay() async {
    if (selectedInstallment == null) {
      MySnackBar.show(context!, 'Debes seleccionar el numero de coutas');
      return;
    }

    Order order = Order(
        idAddress: address!.id, idClient: user!.id, products: selectedProducts);

    progressDialog!.show(max: 100, msg: 'Realizando transaccion');

    http.Response? response = await _mercadoPagoProvider.createPayment(
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
        order: order);

    progressDialog!.close();

    if (response != null) {
      print('SE GENERO UN PAGO antes - Código de estado: ${response.statusCode}, Cuerpo de la respuesta: ${response.body}');

      if (response.body.isNotEmpty) {
        try {
          final data = json.decode(response.body);

          if (response.statusCode == 201) {
            print('SE GENERO UN PAGO ${response.body}');

            creditCardPayment = MercadoPagoPayment.fromJsonMap(data);

            Navigator.pushNamedAndRemoveUntil(
                context!, 'client/payments/status', (route) => false,
                arguments: creditCardPayment!.toJson());
            print('CREDIT CART PAYMENT ${creditCardPayment!.toJson()}');
          } else if (response.statusCode == 501) {
            if (data['err']['status'] == 400) {
              badRequestProcess(data);
            } else {
              badTokenProcess(data['status'], installments!);
            }
          } else {
            MySnackBar.show(context!, 'Error desconocido: ${response.statusCode}');
          }
        } catch (e) {
          print('Error al decodificar la respuesta: $e');
          MySnackBar.show(context!, 'Error al procesar el pago. Inténtalo de nuevo.');
        }
      } else {
        print('La respuesta está vacía.');
        MySnackBar.show(context!, 'Error al procesar el pago. La respuesta está vacía.');
      }
    } else {
      print('La respuesta de la API es nula.');
      MySnackBar.show(context!, 'Error al procesar el pago. La respuesta de la API es nula.');
    }
  }

  ///SI SE RECIBE UN STATUS 400
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
      print('ENTRO IF');
      errorMessage = paymentErrorCodeMap['${data['err']['cause'][0]['code']}'];
    } else {
      errorMessage = 'No pudimos procesar tu pago';
    }
    MySnackBar.show(context!, errorMessage!);
    // Navigator.pop(context);
  }

  void badTokenProcess(
      String status, MercadoPagoPaymentMethodInstallments installments) {
    Map<String, String> badTokenErrorCodeMap = {
      '106': 'No puedes realizar pagos a usuarios de otros paises.',
      '109':
      '${installments.paymentMethodId} no procesa pagos en ${selectedInstallment} cuotas',
      '126': 'No pudimos procesar tu pago.',
      '129':
      '${installments.paymentMethodId} no procesa pagos del monto seleccionado.',
      '145': 'No pudimos procesar tu pago',
      '150': 'No puedes realizar pagos',
      '151': 'No puedes realizar pagos',
      '160': 'No pudimos procesar tu pago',
      '204':
      '${installments.paymentMethodId} no está disponible en este momento.',
      '801':
      'Realizaste un pago similar hace instantes. Intenta nuevamente en unos minutos',
    };
    String? errorMessage;
    if (badTokenErrorCodeMap.containsKey(status.toString())) {
      errorMessage = badTokenErrorCodeMap[status];
    } else {
      errorMessage = 'No pudimos procesar tu pago';
    }
    MySnackBar.show(context!, errorMessage!);
    // Navigator.pop(context);
  }
}
