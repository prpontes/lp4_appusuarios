import 'dart:async';
import 'dart:convert';
import 'package:lp4_appusuarios/api/album.dart';
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
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      onTap: (){
                        Navigator.pushNamed(
                            context,
                            "/detalhealbum",
                          arguments: Album(
                            id: snapshot.data![index].id,
                            userId: snapshot.data![index].userId,
                            title: snapshot.data![index].title,
                          )
                        );
                      },
                      leading: const Icon(Icons.newspaper, color: Colors.blue,),
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
