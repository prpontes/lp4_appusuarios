import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lp4_appusuarios/model/endereco.dart';


class EnderecoProvider extends ChangeNotifier {

  String nomeTabela = "endereco";


  List<Endereco> enderecoFirebase = [];


  addEndereco(Endereco e) async {
    DocumentReference endereco = FirebaseFirestore.instance.collection(
        'endereco').doc(e.id);
    await endereco.set({
      'rua': e.rua,
      'bairro': e.bairro,
      'numero': e.numero,
      'complemento': e.complemento,
      'cep': e.cep,
      'referencia': e.referencia,
      'cidade': e.cidade,
      'cpfcliente': e.cpfcliente,
    });}

    listarEndereco() async {
      CollectionReference enderecos = FirebaseFirestore.instance.collection(
          'endereco');
      if (enderecoFirebase.isNotEmpty) enderecoFirebase.clear();

      await enderecos.orderBy('cep').get().then((value) {
        for (var usr in value.docs) {
          enderecoFirebase.add(
            Endereco(
              id: usr.id,
              rua: usr["rua"],
              bairro: usr["bairro"],
              numero: usr["numero"],
              complemento: usr["complemento"],
              cep: usr["cep"],
              cidade: usr["cidade"],
              cpfcliente: usr["cpfcliente"],

            ),
          );
        }
      });
      notifyListeners();
    }

    editarEndereco(Endereco e) async {
      CollectionReference endereco = FirebaseFirestore.instance.collection(
          'endereco');
      await endereco.doc(e.id).update({
        'rua': e.rua,
        'bairro': e.bairro,
        'numero': e.numero,
        'complemento': e.complemento,
        'cep': e.cep,
        'referencia': e.referencia,
        'cidade': e.cidade,
        'cpfcliente': e.cpfcliente,
      });
      await listarEndereco();
    }

    deletarEndereco(Endereco e) async {
      CollectionReference endereco = FirebaseFirestore.instance.collection(
          'endereco');
      await endereco.doc(e.id).delete();
      await listarEndereco();
    }


}
