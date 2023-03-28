// ignore_for_file: non_constant_identifier_names, file_names
class Pix {
  Pix({this.id, this.pix_date, this.pix_qrcode, this.paymentID});
  int? id;
  DateTime? pix_date;
  String? pix_qrcode;
  String? paymentID;
  String? email;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'pix_date': pix_date != null ? pix_date!.toIso8601String() : null,
      'pix_qrcode': pix_qrcode,
      'paymentID': paymentID,
      'email': email,

    };
    return map;
  }

  Pix.fromMap(Map<String, dynamic> map) {
    id = map['id'];

    pix_date = map['pix_date'] == null ? DateTime(2000) : DateTime.tryParse(map['pix_date']);
    pix_qrcode = map['pix_qrcode'];
    paymentID = map['paymentID'];

  }
}
