class Endereco {
  // model endereco
  String? id;
  String? rua;
  String? bairro;
  String? numero;
  String? complemento;
  String? referencia;
  String? cep;
  String? cidade;
  String? cpfcliente;

  Endereco({
    this.id,
    this.rua,
    this.bairro,
    this.numero,
    this.complemento,
    this.referencia,
    this.cep,
    this.cidade,
    this.cpfcliente,
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
      "cpfcliente": cpfcliente,
      "cidade": cidade,



    };
  }
  factory Endereco.fromMap(String id, Map<String, dynamic> map) {
    return Endereco(
      id: id,
      rua: map["rua"],
      bairro: map["bairro"],
      cep: map["cep"],
      complemento: map["complemento"],
      numero: map["numero"],
      referencia: map["referencia"],
      cpfcliente: map["cpfcliente"],
      cidade: map["cidade"],
    );
  }

  @override
  String toString() {
    return 'Endereco{id: $id, rua: $rua, bairro: $bairro, cep: $cep, cidade : $cidade, complemento: $complemento, numero: $numero,referencia: $referencia, cpfcliente: $cpfcliente}';
  }
}

