// import 'package:lp4_appusuarios/components/search_user_delegate.dart';
// import 'package:flutter/material.dart';
// import 'package:lp4_appusuarios/provider/usuario_provider.dart';
// import 'package:provider/provider.dart';

// import '../components/mutate_customer.dialog.dart';

// class TelaCliente extends StatefulWidget {
//   const TelaCliente({Key? key}) : super(key: key);

//   @override
//   State<TelaCliente> createState() => _TelaClienteState();
// }

// class _TelaClienteState extends State<TelaCliente> {
//   late UsuarioProvider usuarioProvider;

//   @override
//   void initState() {
//     super.initState();
//     usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
//     usuarioProvider.listarUsuarioFirestore();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Lista de clientes"),
//         // input Search bar on changed
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: SearchUserDelegate(),
//               );
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.location_on),
//             onPressed: () {
//               Navigator.pushNamed(context, "/telaendereco");
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Consumer<UsuarioProvider>(
//               builder: (BuildContext context, value, Widget? child) {
//                 final clientes = value.usuarios;
//                 return ListView.builder(
//                   itemCount: clientes.length,
//                   itemBuilder: (context, index) {
//                     if (clientes.isNotEmpty == true) {
//                       final cliente = clientes[index];
//                       return Card(
//                         child: ListTile(
//                           leading: cliente.avatar == ""
//                               ? const Icon(
//                                   Icons.account_circle,
//                                   color: Colors.blue,
//                                   size: 50,
//                                 )
//                               : SizedBox(
//                                   width: 50,
//                                   height: 50,
//                                   child: CircleAvatar(
//                                     backgroundImage: NetworkImage(
//                                       cliente.avatar,
//                                     ),
//                                   ),
//                                 ),
//                           title: Text(cliente.nome!),
//                           subtitle: Text(cliente.email!),
//                           onTap: () {
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (BuildContext context) =>
//                             //         DetailsUserDialog(
//                             //       usuario: cliente,
//                             //     ),
//                             //     fullscreenDialog: true,
//                             //   ),
//                             // );
//                           },
//                         ),
//                       );
//                     } else {
//                       return const Text("nenhum usuário");
//                     }
//                   },
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (BuildContext context) => const MutateCustomerDialog(),
//               fullscreenDialog: true,
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
