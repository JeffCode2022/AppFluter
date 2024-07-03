import 'package:delivery_autonoma/src/models/mercado_pago_credit_cart.dart';
import 'package:delivery_autonoma/src/models/mercado_pago_customer.dart';
import 'package:delivery_autonoma/src/models/mercado_pago_tax.dart';
import 'package:delivery_autonoma/src/models/mercado_pago_transaction_detail.dart';

class MercadoPagoPayment {
  String? id;
  DateTime? dateCreated;
  DateTime? dateApproved;
  DateTime? dateLastUpdated;
  DateTime? dateOfExpiration;
  DateTime? moneyReleaseDate;
  String? operationType;
  String? issuerId;
  String? paymentMethodId;
  String? paymentTypeId;
  String? status;
  String? statusDetail;
  String? currencyId;
  String? description;
  bool liveMode = false;
  String? sponsorId;
  String? authorizationCode;
  String? moneyReleaseSchema;
  double? taxesAmount;
  String? counterCurrency;
  double? shippingAmount;
  String? posId;
  String? storeId;
  String? integratorId;
  String? platformId;
  String? corporationId;
  String? collectorId;
  MercadoPagoCustomer? payer;
  String? marketplaceOwner;
  dynamic metadata;
  String? availableBalance;
  String? nsuProcessadora;
  dynamic order;
  String? externalReference;
  double? transactionAmount;
  double? netAmount;
  List<MercadoPagoTax> taxes = [];
  double? transactionAmountRefunded;
  double? couponAmount;
  String? differentialPricingId;
  String? deductionSchema;
  String? callBackUrl;
  MercadoPagoTransactionDetail? transactionDetails;
  List<dynamic> feeDetails = [];
  bool? captured;
  bool? binaryMode;
  String? callForAuthorizeId;
  String? statementDescriptor;
  int? installments;
  MercadoPagoCreditCard? card;
  String? notificationUrl;
  List<dynamic> refunds = [];
  String? processingMode;
  String? merchantAccountId;
  String? acquirer;
  String? merchantNumber;
  List<dynamic> acquirerReconciliation = [];

  List<MercadoPagoPayment> creditPaymentList = [];

  MercadoPagoPayment({
    this.id,
    this.dateCreated,
    this.dateApproved,
    this.dateLastUpdated,
    this.dateOfExpiration,
    this.moneyReleaseDate,
    this.operationType,
    this.issuerId,
    this.paymentMethodId,
    this.paymentTypeId,
    this.status,
    this.statusDetail,
    this.currencyId,
    this.description,
    this.liveMode = false,
    this.sponsorId,
    this.authorizationCode,
    this.moneyReleaseSchema,
    this.taxesAmount,
    this.counterCurrency,
    this.shippingAmount,
    this.posId,
    this.storeId,
    this.integratorId,
    this.platformId,
    this.corporationId,
    this.collectorId,
    this.payer,
    this.marketplaceOwner,
    this.metadata,
    this.availableBalance,
    this.nsuProcessadora,
    this.order,
    this.externalReference,
    this.transactionAmount,
    this.netAmount,
    this.taxes = const [],
    this.transactionAmountRefunded,
    this.couponAmount,
    this.differentialPricingId,
    this.deductionSchema,
    this.callBackUrl,
    this.transactionDetails,
    this.feeDetails = const [],
    this.captured,
    this.binaryMode,
    this.callForAuthorizeId,
    this.statementDescriptor,
    this.installments,
    this.card,
    this.notificationUrl,
    this.refunds = const [],
    this.processingMode,
    this.merchantAccountId,
    this.acquirer,
    this.merchantNumber,
    this.acquirerReconciliation = const [],
  });
  MercadoPagoPayment.fromJsonMap(Map<String, dynamic> json) {
  id = json['id']?.toString();
  dateCreated = json['date_created'] != null ? DateTime.tryParse(json['date_created']) : null;
  dateApproved = json['date_approved'] != null ? DateTime.tryParse(json['date_approved']) : null;
  dateLastUpdated = json['date_last_updated'] != null ? DateTime.tryParse(json['date_last_updated']) : null;
  dateOfExpiration = json['date_of_expiration'] != null ? DateTime.tryParse(json['date_of_expiration']) : null;
  moneyReleaseDate = json['money_release_date'] != null ? DateTime.tryParse(json['money_release_date']) : null;
  operationType = json['operation_type'];
  issuerId = json['issuer_id'];
  paymentMethodId = json['payment_method_id'];
  paymentTypeId = json['payment_type_id'];
  status = json['status'];
  statusDetail = json['status_detail'];
  currencyId = json['currency_id'];
  description = json['description'];
  liveMode = json['live_mode'] ?? false;
  sponsorId = json['sponsor_id'];
  authorizationCode = json['authorization_code'];
  moneyReleaseSchema = json['money_release_schema'];
  taxesAmount = json['taxes_amount'] != null ? double.tryParse(json['taxes_amount'].toString()) : 0;
  counterCurrency = json['counter_currency'];
  shippingAmount = json['shipping_amount'] != null ? double.tryParse(json['shipping_amount'].toString()) : 0;
  posId = json['pos_id'];
  storeId = json['store_id'];
  integratorId = json['integrator_id'];
  platformId = json['platform_id'];
  corporationId = json['corporation_id'];
  collectorId = json['collector_id']?.toString();
  payer = json['payer'] != null ? MercadoPagoCustomer.fromJsonMap(json['payer']) : null;
  marketplaceOwner = json['marketplace_owner'];
  metadata = json['metadata'];
  availableBalance = json['available_balance'];
  nsuProcessadora = json['nsu_processadora'];
  order = json['order'] != null ? json['order'] : null;
  externalReference = json['external_reference'];
  transactionAmount = json['transaction_amount'] != null ? double.tryParse(json['transaction_amount'].toString()) : 0;
  netAmount = json['net_amount'] != null ? double.tryParse(json['net_amount'].toString()) : 0;
  taxes = json['taxes'] != null ? MercadoPagoTax.fromJsonList(json['taxes']).taxList : [];
  transactionAmountRefunded = json['transaction_amount_refunded'] != null ? double.tryParse(json['transaction_amount_refunded'].toString()) : 0;
  couponAmount = json['coupon_amount'] != null ? double.tryParse(json['coupon_amount'].toString()) : 0;
  differentialPricingId = json['differential_pricing_id'];
  deductionSchema = json['deduction_schema'];
  callBackUrl = json['callback_url'];
  transactionDetails = json['transaction_details'] != null ? MercadoPagoTransactionDetail.fromJsonMap(json['transaction_details']) : null;
  feeDetails = json['fee_details'] ?? [];
  captured = json['captured'];
  binaryMode = json['binary_mode'];
  callForAuthorizeId = json['call_for_authorized_id'];
  statementDescriptor = json['statement_descriptor'];
  installments = json['installments'] != null ? int.tryParse(json['installments'].toString()) : 0;
  card = json['card'] != null ? MercadoPagoCreditCard.fromJsonMap(json['card']) : null;
  notificationUrl = json['notification_url'];
  refunds = json['refunds'] ?? [];
  processingMode = json['processing_mode'];
  merchantAccountId = json['merchant_account_id'];
  acquirer = json['acquirer'];
  merchantNumber = json['merchant_number'];
  acquirerReconciliation = json['acquirer_reconciliation'] ?? [];
}

 
  Map<String, dynamic> toJson() => {
        'id': id,
        'date_created': dateCreated?.toIso8601String(),
        'date_approved': dateApproved?.toIso8601String(),
        'date_last_updated': dateLastUpdated?.toIso8601String(),
        'date_of_expiration': dateOfExpiration?.toIso8601String(),
        'money_release_date': moneyReleaseDate?.toIso8601String(),
        'operation_type': operationType,
        'issuer_id': issuerId,
        'payment_method_id': paymentMethodId,
        'payment_type_id': paymentTypeId,
        'status': status,
        'status_detail': statusDetail,
        'currency_id': currencyId,
        'description': description,
        'live_mode': liveMode,
        'sponsor_id': sponsorId,
        'authorization_code': authorizationCode,
        'money_release_schema': moneyReleaseSchema,
        'taxes_amount': taxesAmount,
        'counter_currency': counterCurrency,
        'shipping_amount': shippingAmount,
        'pos_id': posId,
        'store_id': storeId,
        'integrator_id': integratorId,
        'platform_id': platformId,
        'corporation_id': corporationId,
        'collector_id': collectorId,
        'payer': payer?.toJson(),
        'marketplace_owner': marketplaceOwner,
        'metadata': metadata,
        'available_balance': availableBalance,
        'nsu_processadora': nsuProcessadora,
        'order': order,
        'external_reference': externalReference,
        'transaction_amount': transactionAmount,
        'net_amount': netAmount,
        'taxes': taxes.map((tax) => tax.toJson()).toList(),
        'transaction_amount_refunded': transactionAmountRefunded,
        'coupon_amount': couponAmount,
        'differential_pricing_id': differentialPricingId,
        'deduction_schema': deductionSchema,
        'callback_url': callBackUrl,
        'transaction_details': transactionDetails?.toJson(),
        'fee_details': feeDetails,
        'captured': captured,
        'binary_mode': binaryMode,
        'call_for_authorized_id': callForAuthorizeId,
        'statement_descriptor': statementDescriptor,
        'installments': installments,
        'card': card?.toJson(),
        'notification_url': notificationUrl,
        'refunds': refunds,
        'processing_mode': processingMode,
        'merchant_account_id': merchantAccountId,
        'acquirer': acquirer,
        'merchant_number': merchantNumber,
        'acquirer_reconciliation': acquirerReconciliation,
      };
}
