import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Puntuacion extends StatelessWidget {
  const Puntuacion({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar:  AppBar(title: Text("Puntuación"),),
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
      body: formulario()
    );
  }
}

Widget formulario(){

TextEditingController id = TextEditingController();
TextEditingController nombre = TextEditingController();
TextEditingController puntuacion = TextEditingController();
  return Column(
    children:[
      TextField(
        controller: id,
        decoration: InputDecoration(
          label: Text('Ingresar ID')
        ),
      ),
      TextField(
        controller: nombre,
        decoration: InputDecoration(
          label: Text('Ingresar nombre')
        ),
      ),
      TextField(
        controller: puntuacion,
        decoration: InputDecoration(
          label: Text('Ingresar puntuacion')
        ),
      ),
      FilledButton(onPressed: ()=> guardarPelicula(id.text, nombre.text, puntuacion.text), child: Text('Guardar')),
    ],
  );
}

Future<void> guardarPelicula(id, nombre, puntuacion) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("peliculas/$id");

await ref.set({
  "titulo": nombre,
  "puntuacion": puntuacion,
});
}