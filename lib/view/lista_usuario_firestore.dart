import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListaUsuarioFirestore extends StatefulWidget {
  const ListaUsuarioFirestore({Key? key}) : super(key: key);

  @override
  State<ListaUsuarioFirestore> createState() => _ListaUsuarioFirestoreState();
}

class _ListaUsuarioFirestoreState extends State<ListaUsuarioFirestore> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('usuarios').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Erro ao exibir os dados!');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['nome']),
              subtitle: Text(data['email']),
            );
          }).toList(),
        );
      },
    );
  }
}
