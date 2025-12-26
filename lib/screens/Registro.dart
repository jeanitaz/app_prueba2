import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: formulario(context),
    );
  }
}

Widget formulario(context){

  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  return Container(
    height: 200,
    child: Column(
      children: [
        TextField(
          controller: correo,
          decoration: InputDecoration(
            label: Text('Ingresar Correo')
          ),
        ),
        TextField(
          controller: contrasena,
          decoration: InputDecoration(
            label: Text('Ingresar Contraseña')
          ),
        ),
    
        ElevatedButton(onPressed: ()=>login(correo.text, contrasena.text, context), child: Text('Iniciar sesión')),
      ],
    ),
  );
}

Future<void> login(correo, contrasena, context) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: correo,
      password: contrasena,
    );
    Navigator.pushNamed(context, '/login');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}