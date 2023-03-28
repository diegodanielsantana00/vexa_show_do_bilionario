
class MercadoPagoPayment {
  MercadoPagoPayment(
      {this.id,
      this.dateApproved,
      this.paymentMethodId,
      this.paymentTypeId,
      this.status,
      this.statusDetail,
      this.transactionAmount,
      this.installments,
      this.description,
      this.statementDescriptor,
      this.notificationUrl,
      this.docNumber,
      this.contact,
      this.email,
      this.barCode,
      this.qrCode,
      this.qrCodeRender,
      this.firstName});

  int? id;
  DateTime? dateApproved;
  String? paymentMethodId;
  String? paymentTypeId;
  String? status;
  String? statusDetail;
  String? firstName;
  String? email;
  String? docNumber;
  String? contact;
  double? transactionAmount;
  int? installments;
  String? statementDescriptor;
  String? description;
  String? notificationUrl;
  String? barCode;
  String? qrCode;
  String? qrCodeRender;

  factory MercadoPagoPayment.fromJson(Map<String, dynamic> json,
          {bool ticket = false, bool pix = false}) =>
      MercadoPagoPayment(
          id: json["id"] ?? "",
          dateApproved: json["date_approved"] != null
              ? DateTime.parse(json["date_approved"])
              : null,
          paymentMethodId: json["payment_method_id"] ?? "",
          paymentTypeId: json["payment_type_id"] ?? "",
          status: json["status"] ?? "",
          statusDetail: json["status_detail"] ?? "",
          description: json["description"] ?? "",
          transactionAmount: (json["transaction_amount"]).toDouble() ?? 0.0,
          installments: json["installments"] ?? 1,
          statementDescriptor: json["statement_descriptor"] ?? "",
          notificationUrl: json["notification_url"] ?? "",
          contact: json["payer"]["phone"]["number"] ?? "",
          docNumber: json["payer"]["identification"]["number"] ?? "",
          email: json["payer"]["email"] ?? "",
          barCode: ticket ? json["barcode"]["content"] : "",
          qrCode: pix
              ? json["point_of_interaction"]["transaction_data"]["qr_code"]
              : "",
          qrCodeRender: pix
              ? json["point_of_interaction"]["transaction_data"]
                  ["qr_code_base64"]
              : "",
          firstName: (json["payer"]["first_name"]) ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_method_id": paymentMethodId,
        "payment_type_id": paymentTypeId,
        "status": status,
        "status_detail": statusDetail,
        "description": description,
        "transaction_amount": transactionAmount,
        "installments": installments,
        "statement_descriptor": statementDescriptor,
        "notification_url": notificationUrl,
        "payer": {
          "first_name": firstName,
          "email": email,
          "identification": {"number": docNumber, "type": "CPF"},
          "phone": {"area_code": "55", "number": contact}
        },
        "barcode": barCode,
        "qrCode": qrCode,
        "qrCodeRender": qrCodeRender
      };
}
