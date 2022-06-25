// import 'package:lp4_appusuarios/components/details_address_dialog.dart';
// import 'package:lp4_appusuarios/components/mutate_address_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:lp4_appusuarios/provider/endereco_provider.dart';
// import 'package:provider/provider.dart';
// import '../components/search_address_delegate.dart';

// class TelaEndereco extends StatefulWidget {
//   const TelaEndereco({Key? key}) : super(key: key);

//   @override
//   State<TelaEndereco> createState() => _TelaEnderecoState();
// }

// class _TelaEnderecoState extends State<TelaEndereco> {
//   late EnderecoProvider enderecoProvider;

//   @override
//   void initState() {
//     super.initState();
//     enderecoProvider = Provider.of<EnderecoProvider>(context, listen: false);
//     enderecoProvider.listarTodosEndereco();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Lista de Endereços"),
//         // input Search bar on changed
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: SearchAddressDelegate(),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Consumer<EnderecoProvider>(
//               builder: (BuildContext context, value, Widget? child) {
//                 final enderecos = value.endereco;
//                 return ListView.builder(
//                   itemCount: enderecos.length,
//                   itemBuilder: (context, index) {
//                     if (enderecos.isNotEmpty == true) {
//                       final endereco = enderecos[index];
//                       return Card(
//                         child: ListTile(


//                           title: Text(endereco.rua!),
//                           subtitle: Text(endereco.cidade!),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (BuildContext context) =>
//                                     DetailsAddressDialog(endereco: endereco
//                                     ),
//                                 fullscreenDialog: true,
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     } else {
//                       return const Text("nenhum endereço");
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
//               builder: (BuildContext context) => const MutateAddressDialog(),
//               fullscreenDialog: true,
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
