// ignore_for_file: non_constant_identifier_names, file_names
class User {
  User({this.id, this.qtd_play, this.qtd_vida, this.money, this.token_premium, this.nome, this.cpf, this.email});
  int? id;
  int? qtd_play;
  int? qtd_vida;
  int? money;
  String? token_premium;
  String? email;
  String? nome;
  String? cpf;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'money': money,
      'qtd_play': qtd_play,
      'qtd_vida': qtd_vida,
      'token_premium': token_premium,
      // 'pix_date': pix_date != null ? pix_date!.toIso8601String() : null,
      // 'pix_qrcode': pix_qrcode,
      // 'paymentID': paymentID,
      'email': email,
      'nome': nome,
      'cpf': cpf,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    money = map['money'];
    qtd_play = map['qtd_play'];
    qtd_vida = map['qtd_vida'];
    token_premium = map['token_premium'];
    // pix_date = map['pix_date'] == null ? DateTime(2000) : DateTime.tryParse(map['pix_date']);
    // pix_qrcode = map['pix_qrcode'];
    // paymentID = map['paymentID'];
    email = map['email'];
    nome = map['cpf'];
    nome = map['cpf'];
  }
}
