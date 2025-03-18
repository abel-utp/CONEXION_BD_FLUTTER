import 'package:flutter/material.dart';
import 'package:prueba_lunes_17/main.dart';
//import 'package:flutter_application_1/main.dart'; // Importa la pantalla principal

// La función main() es el punto de inicio de todas las aplicaciones Flutter
void main() {
  runApp(const MyApp());
}

// MyApp es un StatelessWidget que representa toda la aplicación
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MaterialApp es el widget raíz que proporciona muchas funcionalidades básicas
    return MaterialApp(
      title: 'Promolider App',
      debugShowCheckedModeBanner: false, // Quita el banner de "debug"
      home: const PromoLiderScreen(), // Mostramos nuestra pantalla simple
    );
  }
}

// Pantalla simple que muestra solo el logo centrado
class PromoLiderScreen extends StatefulWidget {
  const PromoLiderScreen({Key? key}) : super(key: key);

  @override
  _PromoLiderScreenState createState() => _PromoLiderScreenState();
}

class _PromoLiderScreenState extends State<PromoLiderScreen> {
  @override
  void initState() {
    super.initState();
    // Navega a la pantalla principal después de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El cuerpo de la pantalla
      body: Container(
        width: double.infinity, // Ocupa todo el ancho disponible
        height: double.infinity, // Ocupa todo el alto disponible
        color: const Color.fromRGBO(
          32,
          35,
          41,
          1,
        ), // Color de fondo oscuro como en la imagen
        // Centra el contenido horizontalmente y verticalmente
        child: Center(
          // Envuelve el logo en un GestureDetector para detectar clics
          child: GestureDetector(
            onTap: () {
              // Navega a la pantalla principal (main.dart) al hacer clic
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: Image.asset(
              'assets/promolider_logo.png', // Ruta a la imagen del logo
              width: 200, // Puedes ajustar el tamaño según necesites
            ),
          ),
        ),
      ),
    );
  }
}
