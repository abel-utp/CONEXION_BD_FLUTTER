import 'package:flutter/material.dart';
import 'menu.dart'; // Importa la página del menú

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PromoLiderCalendar(),
    );
  }
}

class PromoLiderCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
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
                  /*  Container(
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
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        child: Image.asset(
                          'assets/promolider_logo.png',
                          height: 32, // Ajusta el tamaño según sea necesario
                        ),
                      ),
                    ],
                  ),

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

            // Contenido del calendario
            Expanded(
              child: Container(
                color: Color(0xFFF5F5F5),
                child: Column(
                  children: [
                    // Cabecera del mes con navegación
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Mes y año
                          Text(
                            "Febrero 2025",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // Botones de navegación
                          Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300,
                                ),
                                child: Icon(Icons.chevron_left, size: 20),
                              ),
                              SizedBox(width: 8),
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300,
                                ),
                                child: Icon(Icons.chevron_right, size: 20),
                              ),
                              SizedBox(width: 8),
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Icon(Icons.add, size: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Días de la semana
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          weekDayItem("D"),
                          weekDayItem("L"),
                          weekDayItem("M"),
                          weekDayItem("M"),
                          weekDayItem("J"),
                          weekDayItem("V"),
                          weekDayItem("S"),
                        ],
                      ),
                    ),

                    // Días del mes (primera fila)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dateItem("1"),
                          dateItem("2", isSelected: true),
                          dateItem("3"),
                          dateItem("4"),
                          dateItem("5"),
                          dateItem("6"),
                          dateItem("7"),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Búsqueda
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Fecha seleccionada
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "3 de Febrero, 2025",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // Reunión 1
                    meetingCard(
                      title: "Reunión Tal",
                      person: "Luis Martinez (Estoy Presente)",
                      date: "3 de febrero de 2025 | Semana 01",
                      time: "8:00 a.m",
                    ),

                    SizedBox(height: 12),

                    // Reunión 2
                    meetingCard(
                      title: "Reunión Don",
                      person: "Carlos Desantos (Estoy Presente)",
                      date: "3 de febrero de 2025 | Semana 01",
                      time: "9:00 a.m",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para los días de la semana
  Widget weekDayItem(String day) {
    return Container(
      width: 30,
      alignment: Alignment.center,
      child: Text(
        day,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade700,
          fontSize: 14,
        ),
      ),
    );
  }

  // Widget para los días del mes
  Widget dateItem(String date, {bool isSelected = false}) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.green : Colors.transparent,
      ),
      child: Text(
        date,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  // Widget para las tarjetas de reunión
  Widget meetingCard({
    required String title,
    required String person,
    required String date,
    required String time,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Icon(Icons.more_vert),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                person,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                date,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              Spacer(),
              Text(
                time,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
