import 'package:flutter/material.dart';
import 'package:prueba_lunes_17/registro_1_lista_de%20estudiantes.dart';
import 'package:prueba_lunes_17/registro_2_ver_todos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text('Registro de Asistencia'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentListScreen()),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sección del curso actual
                  Text(
                    'Curso actual',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    'Desarrollo Web',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Frontend',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text('Lunes, 15 Enero 2025', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 8),

                  // Barra de búsqueda y filtro
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.search,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),

                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                // title: Text('Ver todos'),
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
                                              (context) => EstudiantesScreen(),
                                        ),
                                      );
                                    },
                                    child: Text('Ver todos'),
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

                      /*GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Ver todos'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ver todos'),
                                  ),
                                ],
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
                      ),*/
                    ],
                  ),
                  SizedBox(height: 16),

                  // Lista de estudiantes
                  AttendanceItem(
                    name: 'Jhosep Francisco Principe Flores',
                    status: AttendanceStatus.present,
                    imagePath: 'assets/registro_alumno.jpg',
                  ),
                  Divider(),
                  AttendanceItem(
                    name: 'Kylie Dayana Azpilcueta Mendoza',
                    status: AttendanceStatus.late,
                    imagePath: 'assets/registro_alumno_mujer.jpg',
                  ),
                  Divider(),
                  AttendanceItem(
                    name: 'Lorena Melissa Suarez Lopez',
                    status: AttendanceStatus.absent,
                    imagePath: 'assets/registro_alumno.jpg',
                  ),
                  Divider(),
                  AttendanceItem(
                    name: 'Henderson Lard Perez Rodriguez',
                    status: AttendanceStatus.present,
                    imagePath: 'assets/registro_alumno_mujer.jpg',
                  ),
                  SizedBox(height: 16),

                  // Estado de asistencia
                  Text(
                    'Estado de Asistencia',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 16),

                  // Botones de estado
                  Row(
                    children: [
                      Expanded(
                        child: AttendanceStatusButton(
                          label: 'Presente',
                          color: Colors.green[100]!,
                          textColor: Colors.green,
                          icon: Icons.check,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: AttendanceStatusButton(
                          label: 'Atrasado',
                          color: Colors.amber[100]!,
                          textColor: Colors.amber[800]!,
                          icon: Icons.access_time,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: AttendanceStatusButton(
                          label: 'Ausente',
                          color: Colors.red[100]!,
                          textColor: Colors.red,
                          icon: Icons.close,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: AttendanceStatusButton(
                          label: 'Justificado',
                          color: Colors.blue[100]!,
                          textColor: Colors.blue,
                          icon: Icons.description,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Botón de subir justificante
                  Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.upload_file,
                              color: Colors.blue,
                              size: 24,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Subir Justificante',
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Definición de estados de asistencia
enum AttendanceStatus { present, late, absent, justified }

// Widget para cada estudiante
class AttendanceItem extends StatelessWidget {
  final String name;
  final AttendanceStatus status;
  final String imagePath;

  const AttendanceItem({
    required this.name,
    required this.status,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    Icon statusIcon;
    Color statusColor;

    switch (status) {
      case AttendanceStatus.present:
        statusIcon = Icon(Icons.check, color: Colors.white);
        statusColor = Colors.green;
        break;
      case AttendanceStatus.late:
        statusIcon = Icon(Icons.access_time, color: Colors.white);
        statusColor = Colors.amber;
        break;
      case AttendanceStatus.absent:
        statusIcon = Icon(Icons.close, color: Colors.white);
        statusColor = Colors.red;
        break;
      case AttendanceStatus.justified:
        statusIcon = Icon(Icons.description, color: Colors.white);
        statusColor = Colors.blue;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Foto del estudiante
          CircleAvatar(radius: 20, backgroundImage: AssetImage(imagePath)),
          SizedBox(width: 12),
          // Nombre del estudiante
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          // Icono de estado
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: statusIcon,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para los botones de estado
class AttendanceStatusButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final IconData icon;

  const AttendanceStatusButton({
    required this.label,
    required this.color,
    required this.textColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: 16),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
