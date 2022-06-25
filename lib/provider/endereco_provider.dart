// import 'package:flutter/widgets.dart';
// import 'package:lp4_appusuarios/model/endereco.dart';


// class EnderecoProvider extends ChangeNotifier {
//   // Database db = DatabaseSingleton.instance.db;
//   String nomeTabela = "endereco";


//   List<Endereco> endereco = [];


//   Future<List<Endereco>> listarEndereco( {String? cpf}) async {
//     List lista = await db.query(nomeTabela,
//         where:cpf== null ? null : "idcliente=?",
//         whereArgs: cpf == null ? null : [cpf]);


//     endereco = List.generate(lista.length, (index) {
//       return Endereco(
//         id: lista[index]["id"],
//         rua: lista[index]["rua"],
//         bairro: lista[index]["bairro"],
//         numero: lista[index]["numero"],
//         complemento: lista[index]["complemento"],
//         cep: lista[index]["cep"],
//         referencia: lista[index]["referencia"],
//         cidade: lista[index]["cidade"],

//       );
//     });
//     notifyListeners();
//     return endereco;
//   }
//   Future<List<Endereco>> listarTodosEndereco( ) async {
//     List lista = await db.query(nomeTabela);


//     endereco = List.generate(lista.length, (index) {
//       return Endereco(
//         id: lista[index]["id"],
//         rua: lista[index]["rua"],
//         bairro: lista[index]["bairro"],
//         numero: lista[index]["numero"],
//         complemento: lista[index]["complemento"],
//         cep: lista[index]["cep"],
//         referencia: lista[index]["referencia"],
//         cidade: lista[index]["cidade"],

//       );
//     });
//     notifyListeners();
//     return endereco;
//   }


//   Future<int> inserirEndereco(Endereco enderecos) async {
//     int id = await db.insert(nomeTabela, enderecos.toMap());
//     enderecos.id = id;
//     endereco.add(enderecos);
//     notifyListeners();
//     return id;
//   }

//   Future<int> editarEndereco(Endereco enderecos) async {
//     int id = await db.update(nomeTabela, enderecos.toMap(),
//         where: "id = ?", whereArgs: [enderecos.id]);
//     debugPrint(id.toString());
//     notifyListeners();
//     return id;
//   }

//   Future<int> deletarEndereco(Endereco enderecos) async {
//     int id =
//     await db.delete(nomeTabela, where: "id = ?", whereArgs: [enderecos.id]);
//     endereco.remove(enderecos);
//     notifyListeners();
//     return id;
//   }
// }
