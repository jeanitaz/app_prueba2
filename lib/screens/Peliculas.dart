import 'package:flutter/material.dart';
import 'dart:convert';

class Peliculas extends StatelessWidget {
  const Peliculas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Películas")),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Puntuacion"),
              onTap: () => Navigator.pushNamed(context, '/puntuacion'),
            ),
            ListTile(
              title: const Text("Peliculas"),
              onTap: () => Navigator.pushNamed(context, '/peliculas'),
            ),
          ],
        ),
      ),
      body: const ListarPeliculas(),
    );
  }
}

class ListarPeliculas extends StatefulWidget {
  const ListarPeliculas({super.key});

  @override
  State<ListarPeliculas> createState() => _ListarPeliculasState();
}

class _ListarPeliculasState extends State<ListarPeliculas> {
  Future<List> leerJsonLocal(BuildContext context) async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/Peliculas.json');
    final data = json.decode(jsonString);
    return data['peliculas'];
  }

  void mostrarAlerta(BuildContext context, Map item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item['titulo']),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  item['enlaces']['image'],
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image),
                ),
                SizedBox(height: 10),
                Text('Año: ${item['anio']}'),
                SizedBox(height: 10),
                Text('Descripción: ${item['descripcion']}'),
                SizedBox(height: 10),
                Text('Director: ${item['detalles']['director']}'),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: leerJsonLocal(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return ListTile(
                title: Text(item['titulo']),
                onTap: () => mostrarAlerta(context, item),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}