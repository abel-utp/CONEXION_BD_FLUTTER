import 'package:flutter/material.dart';
import 'package:prueba_lunes_17/registro_2_asistencia.dart';
import 'package:prueba_lunes_17/registro_3_asistio.dart';
import 'package:prueba_lunes_17/registro_3_justifico.dart';
import 'package:prueba_lunes_17/registro_3_no_asistio.dart';
import 'package:prueba_lunes_17/registro_3_tardanza.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EstudiantesScreen(),
    );
  }
}

class EstudiantesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AttendanceScreen()),
            );
          },
        ),
        title: Text(
          'Lista de estudiantes',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
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

                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),

                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            StudentListScreen_asistio(),
                                  ),
                                );
                              },
                              child: Text('Asistió'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            StudentListScreen_noasistio(),
                                  ),
                                );
                              },
                              child: Text('No Asistió'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            StudentListScreen_tardanza(),
                                  ),
                                );
                              },
                              child: Text('Tardanza'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            StudentListScreen_justifico(),
                                  ),
                                );
                              },
                              child: Text('Justificación'),
                            ),
                          ],

                          /* actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ver todos'),
                                  ),
                                ],*/
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.filter_list,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),

                /* Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                ),*/
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                EstudianteCard(
                  nombre: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  telefono: '+51 943359596',
                  fecha: '15 de febrero de 2025',
                  hora: '14:50',
                ),
                SizedBox(height: 16),
                EstudianteCard(
                  nombre: 'María Lopez',
                  email: 'mari.lopez@gmail.com',
                  telefono: '+51 957316458',
                  fecha: '15 de febrero de 2025',
                  hora: '15:04',
                ),
                SizedBox(height: 16),
                EstudianteCard(
                  nombre: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  telefono: '+51 943359596',
                  fecha: '15 de febrero de 2025',
                  hora: '14:50',
                ),
                SizedBox(height: 16),
                EstudianteCard(
                  nombre: 'Luis Mendoza',
                  email: 'luis.mendoza@gmail.com',
                  telefono: '+51 943359596',
                  fecha: '15 de febrero de 2025',
                  hora: '14:50',
                ),
                SizedBox(height: 16),
                EstudianteCard(
                  nombre: 'María Lopez',
                  email: 'mari.lopez@gmail.com',
                  telefono: '+51 957316458',
                  fecha: '15 de febrero de 2025',
                  hora: '15:04',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EstudianteCard extends StatelessWidget {
  final String nombre;
  final String email;
  final String telefono;
  final String fecha;
  final String hora;

  const EstudianteCard({
    required this.nombre,
    required this.email,
    required this.telefono,
    required this.fecha,
    required this.hora,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nombre,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(email, style: TextStyle(fontSize: 14, color: Colors.grey)),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text(telefono, style: TextStyle(fontSize: 14)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(fecha, style: TextStyle(fontSize: 14)),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(hora, style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
