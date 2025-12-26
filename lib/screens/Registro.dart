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

Widget formulario(context) {
  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  return Container(
    height: 200,
    child: Column(
      children: [
        TextField(
          controller: correo,
          decoration: InputDecoration(label: Text('Ingresar Correo')),
        ),
        TextField(
          controller: contrasena,
          decoration: InputDecoration(label: Text('Ingresar Contraseña')),
        ),
        ElevatedButton(
            onPressed: () => login(correo.text, contrasena.text, context),
            child: Text('Iniciar sesión')),
      ],
    ),
  );
}

void mostrarAlerta(BuildContext context, String titulo, String mensaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(mensaje),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
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
      mostrarAlerta(context, "Error", "No se encontró usuario con ese correo.");
    } else if (e.code == 'wrong-password') {
      mostrarAlerta(context, "Error", "Contraseña incorrecta.");
    } else if (e.code == 'email-already-in-use') {
      mostrarAlerta(context, "Error", "El correo ya está registrado.");
    } else if (e.code == 'weak-password') {
      mostrarAlerta(context, "Error", "La contraseña es muy débil.");
    } else {
      mostrarAlerta(context, "Error", e.message ?? "Ocurrió un error desconocido.");
    }
  }
}