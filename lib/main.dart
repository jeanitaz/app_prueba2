import 'package:app_prueba2/firebase_options.dart';
import 'package:app_prueba2/screens/Login.dart';
import 'package:app_prueba2/screens/Peliculas.dart';
import 'package:app_prueba2/screens/Puntuacion.dart';
import 'package:app_prueba2/screens/Registro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
runApp(const Prueba2());
}

class Prueba2 extends StatelessWidget {
  const Prueba2({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes:{
        '/login':(context)=>Login(),
        '/registro':(context)=>Registro(),
        '/puntuacion':(context)=>Puntuacion(),
        '/peliculas':(context)=>Peliculas(),
      },
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('Jean Carlos Itaz'),
          Text('GitHub: jeanitaz'),
          FilledButton(onPressed: () => Navigator.pushNamed(context, '/login') , child: Text('Iniciar sesión')),
          FilledButton(onPressed: () => Navigator.pushNamed(context, '/registro') , child: Text('Registrarse')),
        ],
      ),
    );
  }
}