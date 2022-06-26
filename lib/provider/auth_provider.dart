import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lp4_appusuarios/model/usuarioFirebase.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';

class AuthProvider extends ChangeNotifier {
  UsuarioFirebase? _user;
  late final UsuarioProvider _usuarioProvider;

  UsuarioFirebase? get user => isLoggedIn ? _user! : null;

  AuthProvider({required UsuarioProvider usuarioProvider}) {
    _usuarioProvider = usuarioProvider;
  }

  bool get isLoggedIn => _user != null;

  login(User? userCredential) async {
    // _user = user;
    var doc = await FirebaseFirestore.instance.collection('usuarios').doc(userCredential!.uid).get();
    if (doc.exists) {
      _user = UsuarioFirebase.fromMap(doc.id, doc.data()!);
    } else {
      var collection = await FirebaseFirestore.instance.collection('usuarios').where('email', isEqualTo: userCredential.email).get();
      var doc = collection.docs.first;
      _user = UsuarioFirebase.fromMap(doc.id, doc.data());
      _user!.id = userCredential.uid;
      await _usuarioProvider.addUsuarioFirestore(_user!);
      for (var subDoc in (await FirebaseFirestore.instance.collection('usuarios').doc(doc.id).collection(_user!.cpf!).get()).docs) {
        await FirebaseFirestore.instance.collection('usuarios').doc(doc.id).collection(_user!.cpf!).doc(subDoc.id).delete();
      }
      await FirebaseFirestore.instance.collection('usuarios').doc(doc.id).delete();
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }
}
