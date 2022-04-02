import 'dart:async';
import 'dart:convert';
import 'package:bd_usuarios/api/album.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {

  late Future<List<Album>> futureAlbum;

  Future<List<Album>> fetchAlbums() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    List lista = jsonDecode(response.body);
    return List.generate(
        lista.length, (index) {
        return Album(
          userId: lista[index]["userId"],
          id: lista[index]["id"],
          title: lista[index]["title"],
        );
      }
    );
  }

  Future<Album> fetchAlbum() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    print(response.body);
    if(response.statusCode == 200){
      return Album.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load album');
    }
  }

  Future<http.Response> deleteAlbum(String id) async  {
    http.Response response = await http.delete(
        Uri.parse("https://jsonplaceholder.typicode.com/albums/$id"),
        headers: <String, String>{
          'Content-Type' : 'application/json; charset=UTF-8',
        }
    );

    return response;
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api'),
      ),
      body: Center(
        child: FutureBuilder<List<Album>>(
          future: futureAlbum,
          builder: (context, snapshot){
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                  itemBuilder: (contex, index) => Card(
                    child: ListTile(
                      leading: Icon(Icons.newspaper),
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].id.toString()),
                    ),
                  )
              );

            }else if(snapshot.hasError){
              return Text("${snapshot.error}");
            }

            return const CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}
