// import 'package:diacritic/diacritic.dart';
// import 'package:flutter/material.dart';
// import 'package:lp4_appusuarios/components/details_address_dialog.dart';
// import 'package:lp4_appusuarios/components/details_user_dialog.dart';
// import 'package:lp4_appusuarios/provider/endereco_provider.dart';
// import 'package:lp4_appusuarios/provider/usuario_provider.dart';
// import 'package:provider/provider.dart';

// class SearchAddressDelegate extends SearchDelegate<String> {
//   SearchAddressDelegate() : super(searchFieldLabel: "Buscar Endereços");

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = "";
//         },
//       )
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         close(context, "");
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Container();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final enderecoProvider = Provider.of<EnderecoProvider>(context);
//     final enderecos = enderecoProvider.endereco;
//     final listarTodosEnderecos = query.isEmpty
//         ? enderecos
//         : enderecos
//             .where(
//               (p) =>
//                   removeDiacritics(p.cep!.toLowerCase())
//                       .contains(removeDiacritics(query.toLowerCase())) ||
//                   p.rua!.toLowerCase().contains(query.toLowerCase()) ||
//                   p.bairro!.toLowerCase().contains(query.toLowerCase()) ||
//                   p.idcliente!.toLowerCase().contains(query.toLowerCase()) ||
//                   p.cidade!.toLowerCase().contains(query.toLowerCase()),
//             )
//             .toList();

//     return ListView.builder(
//       itemCount: listarTodosEnderecos.length,
//       itemBuilder: (context, index) {
//         final endereco = listarTodosEnderecos[index];
//         return ListTile(
//           title: Text(endereco.rua!),
//           subtitle: Text(endereco.cidade!),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (BuildContext context) => DetailsAddressDialog(
//                   endereco: endereco,
//                 ),
//                 fullscreenDialog: true,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
