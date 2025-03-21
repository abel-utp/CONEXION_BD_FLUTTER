import 'package:flutter/material.dart';
import 'package:prueba_lunes_17/registro_2_ver_todos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:
            Colors.grey[200], // Fondo gris para toda la app
      ),
      home: const StudentListScreen_asistio(),
    );
  }
}

class StudentListScreen_asistio extends StatelessWidget {
  const StudentListScreen_asistio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EstudiantesScreen()),
            );
          },
        ),
        title: const Text(
          'Lista de estudiantes',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda y filtro
          /*Container(
            color: Colors.white, // Contenedor blanco
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.filter_list, color: Colors.grey),
                ),
              ],
            ),
          ),*/
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Lista de estudiantes
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                StudentCard(
                  name: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  phone: '+51 943345658',
                  date: '15 de febrero de 2025',
                  time: '15:50',
                ),
                StudentCard(
                  name: 'Maria Lopez',
                  email: 'maria.lopez@gmail.com',
                  phone: '+51 987356456',
                  date: '15 de febrero de 2025',
                  time: '15:04',
                ),
                StudentCard(
                  name: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  phone: '+51 943345658',
                  date: '15 de febrero de 2025',
                  time: '15:50',
                ),
                StudentCard(
                  name: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  phone: '+51 943345658',
                  date: '15 de febrero de 2025',
                  time: '15:50',
                ),
                StudentCard(
                  name: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  phone: '+51 943345658',
                  date: '15 de febrero de 2025',
                  time: '15:50',
                ),
                StudentCard(
                  name: 'Maria Lopez',
                  email: 'maria.lopez@gmail.com',
                  phone: '+51 987356456',
                  date: '15 de febrero de 2025',
                  time: '15:04',
                ),
                StudentCard(
                  name: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  phone: '+51 943345658',
                  date: '15 de febrero de 2025',
                  time: '15:50',
                ),
                StudentCard(
                  name: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  phone: '+51 943345658',
                  date: '15 de febrero de 2025',
                  time: '15:50',
                ),
                StudentCard(
                  name: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  phone: '+51 943345658',
                  date: '15 de febrero de 2025',
                  time: '15:50',
                ),
                StudentCard(
                  name: 'Maria Lopez',
                  email: 'maria.lopez@gmail.com',
                  phone: '+51 987356456',
                  date: '15 de febrero de 2025',
                  time: '15:04',
                ),
                StudentCard(
                  name: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  phone: '+51 943345658',
                  date: '15 de febrero de 2025',
                  time: '15:50',
                ),
                StudentCard(
                  name: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  phone: '+51 943345658',
                  date: '15 de febrero de 2025',
                  time: '15:50',
                ),
                StudentCard(
                  name: 'Maria Lopez',
                  email: 'maria.lopez@gmail.com',
                  phone: '+51 987356456',
                  date: '15 de febrero de 2025',
                  time: '15:04',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String date;
  final String time;

  const StudentCard({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: Colors.white, // Tarjeta blanca
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        phone,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Asistió',
                style: TextStyle(color: Colors.green[800], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
