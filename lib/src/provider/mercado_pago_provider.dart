import 'dart:convert';
import 'package:delivery_autonoma/src/api/enviroment.dart';
import 'package:delivery_autonoma/src/models/mercado_pago_document_type.dart';
import 'package:delivery_autonoma/src/models/mercado_pago_payment_method_installments.dart';
import 'package:delivery_autonoma/src/models/order.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/utils/constants/my_snackbar.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MercadoPagoProvider {
  final String? urlMercadoPago = 'api.mercadopago.com';
  final _url = Environment.API_DELIVERY;
  final _mercadoPagoCredentials = Environment.mercadoPagoCredentials;

  final SharedPref sharedPref = SharedPref();
  
  BuildContext? context;
  User? user;
  Order? order;

  Future<void> init(BuildContext context, User user) async {
    this.context = context;
    this.user = user;
  }

  Future<List<MercadoPagoDocumentType>> getIdentificationTypes() async {
    try {
      final url = Uri.https(urlMercadoPago!, '/v1/identification_types', {
        'access_token': _mercadoPagoCredentials.accessToken,
      });

      final res = await http.get(url);
      final data = json.decode(res.body);
      final result = MercadoPagoDocumentType.fromJsonList(data);

      return result.documentTypeList;
    } catch (e) {
      print('Error: $e');
      return <MercadoPagoDocumentType>[];
    }
  }

  Future<MercadoPagoPaymentMethodInstallments> getInstallments(
      String bin, double amount) async {
    try {
      final url =
          Uri.https(urlMercadoPago!, '/v1/payment_methods/installments', {
        'access_token': _mercadoPagoCredentials.accessToken,
        'bin': bin,
        'amount': '$amount'
      });

      final res = await http.get(url);
      final data = json.decode(res.body);
      print('DATA INSTALLMENTS: $data');

      final result = MercadoPagoPaymentMethodInstallments.fromJsonList(data);

      return result.installmentList.first;
    } catch (e) {
      print('Error: $e');
      return MercadoPagoPaymentMethodInstallments();
    }
  }

Future<http.Response?> createCardToken({
  String? cvv,
  String? expirationYear,
  int? expirationMonth,
  String? cardNumber,
  String? documentNumber,
  String? documentId,
  String? cardHolderName,
}) async {
  try {
    final url = Uri.https(urlMercadoPago!, '/v1/card_tokens', {
      'public_key': _mercadoPagoCredentials.publicKey,
    });

    final body = {
      'security_code': cvv,
      'expiration_year': expirationYear,
      'expiration_month': expirationMonth,
      'card_number': cardNumber,
      'cardholder': {
        'identification': {
          'number': documentNumber,
          'type': documentId,
        },
        'name': cardHolderName,
      },
    };

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',  // Asegúrate de solicitar JSON como respuesta
      },
      body: json.encode(body),
    );

    // Imprimir el cuerpo de la respuesta para depuración
    print('Card Token Response body: ${res.body}');

    return res;
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}


  Future<http.Response?> createPayment({
    String? cardId,
    double? transactionAmount,
    int? installments,
    String? paymentMethodId,
    String? paymentTypeId,
    String? issuerId,
    String? emailCustomer,
    String? cardToken,
    String? identificationType,
    String? identificationNumber,
    Order? order,
  }) async {
    try {
      final url = Uri.http(_url, '/api/payments/createPay');

      Map<String, dynamic> body = {
        'order': order?.toJson(),  // Asegúrate de que Order tenga un método toJson()
        'card_id': cardId,
        'description': 'Flutter Delivery Autonoma',
        'transaction_amount': transactionAmount,
        'installments': installments,
        'payment_method_id': paymentMethodId,
        'payment_type_id': paymentTypeId,
        'token': cardToken,
        'issuer_id': issuerId,
        'payer': {
          'email': emailCustomer,
          'identification': {
            'type': identificationType,
            'number': identificationNumber,
          }
        }
      };

      print('PARAMS: $body');

      String bodyParams = json.encode(body);

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': user!.sessionToken!,
        'Accept': 'application/json',  // Asegúrate de solicitar JSON como respuesta
      };

      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        MySnackBar.warningSnackBar(title: 'Sesión expirada');
        SharedPref().logout(context!, user!.id);
        return null;
      }

      if (res.statusCode != 200 && res.statusCode != 201) {
        print('Error en createPayment: ${res.statusCode} ${res.body}');
        MySnackBar.show(context!, 'Error: ${res.statusCode}');
        return null;
      }

      // Imprimir el cuerpo de la respuesta
      print('Payment Response body: ${res.body}');

      return res;
    } catch (e) {
      print('Error en createPayment: $e');
      MySnackBar.show(context!, 'Error al procesar el pago. Inténtalo de nuevo.');
      return null;
    }
  }
}
