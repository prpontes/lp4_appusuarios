class Endereco {
  // model endereco
  int? id;
  String? rua;
  String? bairro;
  String? numero;
  String? complemento;
  String? referencia;
  String? cep;
  String? cidade;
  String? idcliente;

  Endereco({
    this.id,
    this.rua,
    this.bairro,
    this.numero,
    this.complemento,
    this.referencia,
    this.cep,
    this.cidade,
    this.idcliente,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "rua": rua,
      "bairro": bairro,
      "cep": cep,
      "complemento": complemento,
      "numero": numero,
      "referencia": referencia,
      "idcliente": idcliente,
      "cidade": cidade,



    };
  }

  @override
  String toString() {
    return 'Endereco{id: $id, rua: $rua, bairro: $bairro, cep: $cep, cidade : $cidade, complemento: $complemento, numero: $numero,referencia: $referencia, idcliente: $idcliente}';
  }
}
