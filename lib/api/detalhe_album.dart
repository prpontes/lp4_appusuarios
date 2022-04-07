import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lp4_appusuarios/api/album.dart';
import 'package:flutter/material.dart';

class DetalheAlbum extends StatefulWidget {
  const DetalheAlbum({Key? key}) : super(key: key);

  @override
  State<DetalheAlbum> createState() => _DetalheAlbumState();
}

class _DetalheAlbumState extends State<DetalheAlbum> {
  late Album album = ModalRoute.of(context)!.settings.arguments as Album;
  late Future<Album> _futureAlbum = fetchAlbum(album.id.toString());

  Future<Album> fetchAlbum(String id) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'));

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Album> deleteAlbum(String id) async {
    http.Response response = await http.delete(
        Uri.parse("https://jsonplaceholder.typicode.com/albums/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      debugPrint("album deletado: ${response.body}");
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Falha ao deletar album.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhe do album"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _futureAlbum = deleteAlbum(album.id.toString());
              });
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text("Id album: ${snapshot.data!.id}"),
                      Text("Id user: ${snapshot.data!.userId}"),
                      Text("Titulo: ${snapshot.data!.title}"),
                    ],
                  );
                } else {
                  return const Text("Nenhum dado para exibir!");
                }
              }

              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
