import 'package:flutter/material.dart';
import 'package:prueba_lunes_17/menu.dart';
import 'package:prueba_lunes_17/registro_1_calendario.dart';
import 'package:prueba_lunes_17/registro_1_lista_de%20estudiantes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MasterPromoLiderApp(),
    );
  }
}

class MasterPromoLiderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior con logo y menú
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Imagen de perfil
                  /* Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                    ),
                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),*/
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/usuario.jpg'),
                    radius: 20,
                  ),

                  // Logo Promolider
                  Image.asset('assets/promolider_logo.png', width: 100),

                  // Menú hamburguesa
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                    child: Icon(Icons.menu, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Contenido principal
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Selector de masterclass
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFF2D3142),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Selecciona una masterclass",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Icon(Icons.keyboard_arrow_down, color: Colors.white),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // Botón de Lista de estudiantes
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentListScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.people, color: Colors.white, size: 32),
                          SizedBox(height: 8),
                          Text(
                            "Lista de estudiantes",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Botón de Calendario
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PromoLiderCalendar(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Calendario",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
