// ignore_for_file: constant_identifier_names

import 'package:delivery_autonoma/src/models/mercado_pago_credentials.dart';

class Environment {
  static const String API_DELIVERY = '192.168.18.14:3000';
  static const String API_KEY_MAPS = 'AIzaSyBdU65VGFhO-oeBEyMEiY8G7azYr_qkJQU';

  static MercadoPagoCredentials mercadoPagoCredentials = MercadoPagoCredentials(
    publicKey: 'TEST-73e02516-7291-4d8a-bd7b-e2785461e7a8',
    accessToken: 'TEST-3921421188842968-062113-4e9e43a5be051df8d17481be8c1d656f-1797189366',
  );
}
