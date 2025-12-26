import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: formulario(context),
    );
  }
}

Widget formulario(BuildContext context) {
  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  return Column(
    children: [
      TextField(
        controller: correo,
        decoration: const InputDecoration(label: Text('Ingresar Correo')),
      ),
      TextField(
        controller: contrasena,
        obscureText: true, 
        decoration: const InputDecoration(label: Text('Ingresar Contraseña')),
      ),
      ElevatedButton(
        onPressed: () => login(correo.text, contrasena.text, context),
        child: const Text('Iniciar sesión'),
      ),
    ],
  );
}

Future<void> login(String correo, String contrasena, BuildContext context) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: correo,
      password: contrasena,
    );

    if (context.mounted) {
      Navigator.pushNamed(context, '/puntuacion');
    }

  } on FirebaseAuthException catch (e) {
    String mensaje = "Ocurrió un error";

    if (e.code == 'user-not-found') {
      mensaje = "No existe un usuario con ese correo.";
    } else if (e.code == 'wrong-password') {
      mensaje = "Contraseña incorrecta.";
    } else if (e.code == 'invalid-email') {
      mensaje = "El formato del correo no es válido.";
    } else {
      mensaje = e.message ?? "Error desconocido";
    }

    if (context.mounted) {
      mostrarAlerta(context, mensaje);
    }
  }
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Error de acceso"),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}