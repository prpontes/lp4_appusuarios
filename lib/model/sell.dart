// ignore_for_file: non_constant_identifier_names

class Sell {
  // model venda
  int? id;
  String? date;
  int? id_user;

  Sell({
    this.id,
    this.date,
    this.id_user,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date,
      "id_user": id_user,
    };
  }

  @override
  String toString() {
    return 'Usuario{id: $id, date: $date, id_user: $id_user}';
  }
}
