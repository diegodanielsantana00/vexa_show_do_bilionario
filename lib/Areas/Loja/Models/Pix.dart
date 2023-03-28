// ignore_for_file: non_constant_identifier_names, file_names
class Pix {
  Pix({this.id, this.pix_date, this.pix_qrcode, this.paymentID, this.email, this.status});
  int? id;
  DateTime? pix_date;
  String? pix_qrcode;
  String? paymentID;
  String? email;
  String? status;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'pix_date': pix_date != null ? pix_date!.toIso8601String() : null,
      'pix_qrcode': pix_qrcode,
      'paymentID': paymentID,
      'email': email,
      'status': status,

    };
    return map;
  }

  Pix.fromMap(Map<String, dynamic> map) {
    id = map['id'];

    pix_date = map['pix_date'] == null ? DateTime(2000) : DateTime.tryParse(map['pix_date']);
    pix_qrcode = map['pix_qrcode'];
    paymentID = map['paymentID'];
    email = map['email'];
    status = map['status'];

  }
}
