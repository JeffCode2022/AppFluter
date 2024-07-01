import 'package:delivery_autonoma/src/models/mercado_pago_payment.dart';
import 'package:delivery_autonoma/src/models/user.dart';
import 'package:delivery_autonoma/src/provider/users_provider.dart';
import 'package:delivery_autonoma/utils/constants/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ClientPaymentsStatusController extends GetxController {
  Function? refreshPage;
  BuildContext? context;

  MercadoPagoPayment? mercadoPagoPayment;

  String? errorMessage;

  User user = User();
  final SharedPref _sharedPref = SharedPref();
  final UsersProvider usersProvider = UsersProvider();
  List<String> tokens = [];

  Future init(BuildContext context, Function refreshPage) async {
    this.context = context;
    this.refreshPage = refreshPage;

    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    user = User.fromJson(await _sharedPref.read('user'));
    usersProvider.init(context, sessionUser: user);
  }





   void finishShopping() {
    Navigator.pushNamedAndRemoveUntil(context!, 'client/products/list', (route) => false);
  }

  void  createErrorMessage() {
    if (mercadoPagoPayment!.statusDetail == 'cc_rejected_bad_filled_card_number') {
      errorMessage = 'Revisa el número de tarjeta';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_bad_filled_date') {
      errorMessage = 'Revisa la fecha de vencimiento';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_bad_filled_other') {
      errorMessage = 'Revisa los datos de la tarjeta';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_bad_filled_security_code') {
      errorMessage = 'Revisa el código de seguridad de la tarjeta';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_blacklist') {
      errorMessage = 'No pudimos procesar tu pago';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_call_for_authorize') {
      errorMessage = 'Debes autorizar ante ${mercadoPagoPayment!.paymentMethodId} el pago de este monto.';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_card_disabled') {
      errorMessage = 'Llama a ${mercadoPagoPayment!.paymentMethodId} para activar tu tarjeta o usa otro medio de pago';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_card_error') {
      errorMessage = 'No pudimos procesar tu pago';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_card_error') {
      errorMessage = 'No pudimos procesar tu pago';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_duplicated_payment') {
      errorMessage = 'Ya hiciste un pago por ese valor';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_high_risk') {
      errorMessage = 'Elige otro de los medios de pago, te recomendamos con medios en efectivo';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_insufficient_amount') {
      errorMessage = 'Tu ${mercadoPagoPayment!.paymentMethodId} no tiene fondos suficientes';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_invalid_installments') {
      errorMessage = '${mercadoPagoPayment!.paymentMethodId} no procesa pagos en ${mercadoPagoPayment!.installments} cuotas.';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_max_attempts') {
      errorMessage = 'Llegaste al límite de intentos permitidos';
    }
    else if (mercadoPagoPayment!.statusDetail == 'cc_rejected_other_reason') {
      errorMessage = 'Elige otra tarjeta u otro medio de pago';
    }
  }
}
