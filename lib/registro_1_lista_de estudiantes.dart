import 'package:flutter/material.dart';
import 'package:prueba_lunes_17/registro_principal.dart';
import 'registro_2_asistencia.dart'; // Asegúrate de importar el archivo de destino

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.black,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MasterPromoLiderApp()),
            );
          },
        ),

        title: Text(
          'Lista de estudiantes',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        children: [
          // Barra de búsqueda y filtro
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                // Campo de búsqueda
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AttendanceScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Desarrollo Web Frontend',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                // Botón de filtro
                Icon(Icons.filter_list, color: Colors.grey),
              ],
            ),
          ),
          // Lista de estudiantes
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12),
              children: [
                studentCard(
                  name: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  phone: '+1123456789',
                  date: '15 de febrero de 2025',
                  time: '14:30',
                  imagePath: 'hombre',
                ),
                SizedBox(height: 12),
                studentCard(
                  name: 'Maria Lopez',
                  email: 'mari.lopez@gmail.com',
                  phone: '+1123457456',
                  date: '15 de febrero de 2025',
                  time: '15:34',
                  imagePath: 'mujer',
                ),
                SizedBox(height: 12),
                studentCard(
                  name: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  phone: '+1123456789',
                  date: '15 de febrero de 2025',
                  time: '14:30',
                  imagePath: 'hombre',
                ),
                SizedBox(height: 12),
                studentCard(
                  name: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  phone: '+1123456789',
                  date: '15 de febrero de 2025',
                  time: '14:30',
                  imagePath: 'hombre',
                ),
                SizedBox(height: 12),
                studentCard(
                  name: 'Maria Lopez',
                  email: 'mari.lopez@gmail.com',
                  phone: '+1123457456',
                  date: '15 de febrero de 2025',
                  time: '15:34',
                  imagePath: 'mujer',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget studentCard({
    required String name,
    required String email,
    required String phone,
    required String date,
    required String time,
    required String imagePath,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Información del estudiante
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre y correo
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(email, style: TextStyle(color: Colors.grey, fontSize: 14)),
                SizedBox(height: 8),
                // Teléfono
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: Colors.grey),
                    SizedBox(width: 6),
                    Text(
                      phone,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                // Fecha
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    SizedBox(width: 6),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                // Hora
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                    SizedBox(width: 6),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Imagen de perfil
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  imagePath == 'hombre'
                      ? 'assets/registro_alumno.jpg'
                      : 'assets/registro_alumno_mujer.jpg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
