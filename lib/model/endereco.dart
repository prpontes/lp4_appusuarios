class Endereco {
  // model endereco
  int? id;
  String? rua;
  String? bairro;
  String? numero;
  String? complemento;
  String? referencia;
  String? cep;


  Endereco({
    this.id,
    this.rua,
    this.bairro,
    this.numero,
    this.complemento,
    this.referencia,
    this.cep
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


    };
  }

  @override
  String toString() {
    return 'Endereco{id: $id, rua: $rua, bairro: $bairro, cep: $cep, complemento: $complemento, numero: $numero,referencia: $referencia}';
  }
}
