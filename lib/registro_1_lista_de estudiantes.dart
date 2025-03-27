import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_lunes_17/registro_2_asistencia.dart';
import 'dart:convert';

import 'package:prueba_lunes_17/registro_principal.dart';

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

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List students = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  // Función para obtener los datos desde la API
  Future<void> fetchStudents() async {
    final response = await http.get(
      Uri.parse('http://192.168.18.125/api/get_students.php'),
    );

    if (response.statusCode == 200) {
      setState(() {
        students = json.decode(response.body);
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  List getFilteredStudents() {
    if (searchController.text.isEmpty) return students;
    return students.where((student) {
      return student['lastname'].toString().toLowerCase().contains(
        searchController.text.toLowerCase(),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    fetchStudents(); // Cargar datos al iniciar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSearching = !isSearching;
                              if (!isSearching) {
                                searchController.clear();
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.search,
                              color: isSearching ? Colors.green : Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child:
                                isSearching
                                    ? TextField(
                                      controller: searchController,
                                      decoration: InputDecoration(
                                        hintText: 'Buscar estudiante...',
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                    )
                                    : GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => AttendanceScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Desarrollo Web Frontend',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Icon(Icons.filter_list, color: Colors.grey),
              ],
            ),
          ),
          Expanded(
            child:
                getFilteredStudents().isEmpty
                    ? Center(child: Text('No se encontraron estudiantes'))
                    : ListView.builder(
                      padding: EdgeInsets.all(12),
                      itemCount: getFilteredStudents().length,
                      itemBuilder: (context, index) {
                        final filteredStudents = getFilteredStudents();
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
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
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filteredStudents[index]['lastname'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Correo: ${filteredStudents[index]['email']}',
                                    ),
                                    Text(
                                      'Teléfono: ${filteredStudents[index]['phone']}',
                                    ),
                                    Text(
                                      'Fecha: ${filteredStudents[index]['created_at']}',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
