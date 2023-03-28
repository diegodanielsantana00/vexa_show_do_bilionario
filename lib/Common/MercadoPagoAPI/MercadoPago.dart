
import 'package:vexa_show_do_bilionario/Common/MercadoPagoAPI/MercadoPagoPayments.dart';
import 'package:vexa_show_do_bilionario/Common/MercadoPagoAPI/MercadoPagoRequest.dart';

class MercadoPago {
  late String acessToken;

  MercadoPago(this.acessToken);

  Future<String> SaveCard(
      {required String cardName,
      required String cpf,
      required String cardNumber,
      required int expirationMoth,
      required int expirationYear,
      required String securityCode,
      required String issuer}) async {
    try {
      final card = {
        'cardholder': {
          'identification': {
            'number': cpf,
            'type': 'CPF',
          },
          'name': cardName,
        },
        'cardNumber': cardNumber,
        'expirationMonth': expirationMoth,
        'expirationYear': expirationYear,
        'securityCode': securityCode,
        'issuer': issuer
      };

      final result = await MercadoPagoRequest().post(path: 'v1/card_tokens', acessToken: acessToken, data: card);
      final id = result['id'];

      print(id);
      return id;
    } catch (e) {
      return throw e;
    }
  }

  Future<String> SaveClient({
    required String default_card,
    required String identification,
    required String email,
  }) async {
    try {
      final card = {
        'email': email,
      };

      final result = await MercadoPagoRequest().post(path: '/v1/customers', acessToken: acessToken, data: card);
      final id = result['id'];

      print(id);
      return id;
    } catch (e) {
      return throw e;
    }
  }

  Future<String> SaveClientCard(String customer_id, String token) async {
    try {
      final card = {
        'token': token,
      };

      final result = await MercadoPagoRequest().post(path: 'v1/customers/${customer_id}/cards', acessToken: acessToken, data: card);
      final id = result['id'];

      print(id);
      return id;
    } catch (e) {
      return throw e;
    }
  }

  Future<MercadoPagoPayment> PaymentCreditCard(
      {String? clientId, required String tokenCard, required double amount, String? description, String? paymentMethodId, String? issuer, String? name, String? email, String? docNumber}) async {
    try {
      final payer = clientId != null
          ? {'type': "customer", 'id': clientId}
          : {
              "email": email,
              "first_name": name!.split(' ').first,
              "last_name": name.split(' ').last,
              "identification": {"type": 'CPF', "number": docNumber},
            };

      final obj = {'transaction_amount': amount, 'token': tokenCard, 'description': description, 'installments': 1, 'payment_method_id': paymentMethodId, 'issuer_id': issuer, 'payer': payer};

      final result = await MercadoPagoRequest().post(path: 'v1/payments', acessToken: acessToken, data: obj);

      final payment = MercadoPagoPayment.fromJson(result);
      return payment;
    } catch (e) {
      return MercadoPagoPayment(id: 0);
    }
  }

  Future<MercadoPagoPayment> PaymentCreditCardCVV(
      {String? clientId,
      required String cardID,
      required String cvv,
      required double amount,
      String? description,
      String? paymentMethodId,
      String? issuer,
      String? name,
      String? email,
      String? docNumber}) async {
    try {
      // String teste = await GetTokenCardSave(token: tokenCard, securityCode: cvv);
      final payer = clientId != null
          ? {'type': "customer", 'id': clientId}
          : {
              "email": email,
              "first_name": name!.split(' ').first,
              "last_name": name.split(' ').last,
              "identification": {"type": 'CPF', "number": docNumber},
            };

      print(clientId);
      String teste = await GetTokenCart(cardID, cvv);

      final obj = {'transaction_amount': amount, 'token': teste, 'description': description, 'installments': 1, 'payment_method_id': "master", 'issuer_id': issuer, 'payer': payer};

      final result = await MercadoPagoRequest().post(path: 'v1/payments', acessToken: acessToken, data: obj);

      final payment = MercadoPagoPayment.fromJson(result);
      return payment;
    } catch (e) {
      return MercadoPagoPayment(id: 0);
      // return throw e;
    }
  }

  Future<String> GetTokenCart(String card_id, String securityCode) async {
    try {
      final card = {
        'cardId': card_id,
        'securityCode': securityCode,
      };

      final result = await MercadoPagoRequest().post(path: 'v1/card_tokens', acessToken: acessToken, data: card);
      final id = result['id'];

      print(id);
      return id;
    } catch (e) {
      return throw e;
    }
  }

  Future<MercadoPagoPayment> CancelPaymentsMercadoPago(int? tokenPayment, double amount) async {
    try {
      final obj = {"amount": amount};

      final result = await MercadoPagoRequest().post(path: 'v1/payments/$tokenPayment/refunds', acessToken: acessToken, data: obj);

      return MercadoPagoPayment(id: 1);
    } catch (e) {
      return throw e;
    }
  }

  Future<MercadoPagoPayment> PaymentTicket({String? description, String? clientId, required double amount, required String name, required String email, required String docNumber}) async {
    final payer = clientId != null
        ? {'type': "customer", 'id': clientId}
        : {
            "email": email,
            "first_name": name.split(' ').first,
            "last_name": name.split(' ').last,
            "identification": {"type": 'CPF', "number": docNumber},
          };

    var data = {"transaction_amount": amount, "description": description ?? "", "payment_method_id": 'bolbradesco', "payer": payer};

    final result = await MercadoPagoRequest().post(path: 'v1/payments', acessToken: acessToken, data: data);

    final ticket = MercadoPagoPayment.fromJson(result, ticket: true);
    return ticket;
  }

  Future<MercadoPagoPayment> PaymentPix({String? description, String? clientId, required double amount, required String name, required String email, required String docNumber}) async {
    final payer = clientId != null
        ? {'type': "customer", 'id': clientId}
        : {
            "email": email,
            "first_name": name.split(' ').first,
            "last_name": name.split(' ').last,
            "identification": {"type": 'CPF', "number": docNumber},
          };

    final data = {"transaction_amount": amount, "description": description ?? "", "payment_method_id": 'pix', "payer": payer};

    final result = await MercadoPagoRequest().post(path: 'v1/payments', acessToken: acessToken, data: data);

    final pix = MercadoPagoPayment.fromJson(result, pix: true);
    return pix;
  }

  Future<MercadoPagoPayment> ConsultPayments({required String idPayments}) async {
    final result = await MercadoPagoRequest().get(path: 'v1/payments/$idPayments', acessToken: acessToken);
    final pix = MercadoPagoPayment.fromJson(result, pix: true);
    return pix;
  }
}
