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
  int currentPage = 1;
  int studentsPerPage = 6;

  // Función para obtener los datos desde la API
  Future<void> fetchStudents() async {
    final response = await http.get(
      Uri.parse('http://192.168.18.125/api/get_students.php'),
    );

    if (response.statusCode == 200) {
      setState(() {
        students = json.decode(response.body);
        // Ordenar la lista alfabéticamente por nombre_completo
        students.sort(
          (a, b) => a['nombre_completo'].toString().toLowerCase().compareTo(
            b['nombre_completo'].toString().toLowerCase(),
          ),
        );
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  List getFilteredStudents() {
    if (searchController.text.isEmpty) return students;
    return students.where((student) {
      return student['nombre_completo'].toString().toLowerCase().contains(
        searchController.text.toLowerCase(),
      );
    }).toList();
  }

  List getPaginatedStudents() {
    final filteredStudents = getFilteredStudents();
    final startIndex = (currentPage - 1) * studentsPerPage;
    final endIndex = startIndex + studentsPerPage;

    if (startIndex >= filteredStudents.length) return [];

    return filteredStudents.sublist(
      startIndex,
      endIndex > filteredStudents.length ? filteredStudents.length : endIndex,
    );
  }

  int get totalPages => (getFilteredStudents().length / studentsPerPage).ceil();

  Widget _buildPageButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void changePage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStudents(); // Cargar datos al iniciar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        242,
        242,
        242,
      ), // Añadir esta línea para el color de fondo
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
          style: TextStyle(color: Colors.white, fontSize: 20),
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
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 1),
                            ),
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
                                          color: const Color.fromARGB(
                                            255,
                                            0,
                                            0,
                                            0,
                                          ),
                                          fontSize: 18,
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
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.filter_list, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child:
                      getPaginatedStudents().isEmpty
                          ? Center(child: Text('No se encontraron estudiantes'))
                          : ListView.builder(
                            padding: EdgeInsets.all(12),
                            itemCount: getPaginatedStudents().length,
                            itemBuilder: (context, index) {
                              final paginatedStudents = getPaginatedStudents();
                              return Container(
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            paginatedStudents[index]['nombre_completo'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 1),
                                          Text(
                                            '${paginatedStudents[index]['email']}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(height: 18),
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/wsp.jpg',
                                                width: 20,
                                                height: 20,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                '+51 ${paginatedStudents[index]['phone']}',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/calendario.jpg',
                                                width: 20,
                                                height: 20,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                '${paginatedStudents[index]['fecha']}',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ), // Espaciado entre calendario y reloj
                                              Image.asset(
                                                'assets/reloj.jpg',
                                                width: 20,
                                                height: 20,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                '${paginatedStudents[index]['hora']}',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
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
                if (getFilteredStudents().length > studentsPerPage)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (currentPage > 1)
                          _buildPageButton(
                            '<',
                            false,
                            () => changePage(currentPage - 1),
                          ),
                        for (int i = 1; i <= totalPages; i++)
                          _buildPageButton(
                            '$i',
                            currentPage == i,
                            () => changePage(i),
                          ),
                        if (currentPage < totalPages)
                          _buildPageButton(
                            '>',
                            false,
                            () => changePage(currentPage + 1),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
