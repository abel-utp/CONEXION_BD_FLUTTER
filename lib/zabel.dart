import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Este es el widget raíz de la aplicación
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Promolider',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: const PromoHomePage(),
      debugShowCheckedModeBanner: false, // Quita el banner de debug
    );
  }
}

class PromoHomePage extends StatefulWidget {
  const PromoHomePage({Key? key}) : super(key: key);

  @override
  State<PromoHomePage> createState() => _PromoHomePageState();
}

class _PromoHomePageState extends State<PromoHomePage> {
  List<Map<String, dynamic>> courses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  Future<void> getCourses() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.18.125/api/get_courses.php'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          courses = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(221, 15, 15, 15),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),

        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo de usuario dentro de un círculo
              CircleAvatar(
                backgroundImage: AssetImage('assets/usuario.jpg'),
                radius: 20,
              ),
              SizedBox(
                width: 30,
              ), // Espacio entre el logo de usuario y el logo de Promolider
              // Logo de Promolider
              Image.asset('assets/promolider_logo.png', width: 140),
            ],
          ),
        ),
        actions: [
          // Icono de búsqueda
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          // Icono de menú
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de categorías
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categorías',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Ver todo >',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 41, 40, 40),
                    ),
                  ),
                ],
              ),
            ),

            // Horizontal Divider
            Divider(color: Colors.grey[300], height: 24, thickness: 1),

            SizedBox(height: 6),

            // Lista horizontal de categorías
            SizedBox(
              height: 80,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategoryItem(
                    'assets/bd_icon.jpg',
                    'Base de Datos',
                    Colors.blue,
                  ),
                  SizedBox(width: 16),
                  _buildCategoryItem(
                    'assets/redes_icon.jpg',
                    'Redes',
                    Colors.blue,
                  ),
                  SizedBox(width: 16),
                  _buildCategoryItem(
                    'assets/programacion_icon.jpg',
                    'Programación',
                    Colors.purple,
                  ),
                  SizedBox(width: 16),
                  _buildCategoryItem(
                    'assets/audio_icon.jpg',
                    'Audio',
                    Colors.white,
                  ),
                ],
              ),
            ),

            SizedBox(height: 26),

            // Grid de cursos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          final course = courses[index];
                          return GestureDetector(
                            onTap: () {},
                            child: _buildCourseCard(
                              course['title'],
                              course['teacher'],
                              course['duration'],
                              course['image_path'],
                            ),
                          );
                        },
                      ),
            ),

            // Paginación
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPageButton('<', false),
                  _buildPageButton('1', true),
                  _buildPageButton('2', false),
                  _buildPageButton('3', false),
                  _buildPageButton('4', false),
                  _buildPageButton('5', false),
                  Text(' ... '),
                  _buildPageButton('5', false),
                  _buildPageButton('>', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir los elementos de categoría
  Widget _buildCategoryItem(String imagePath, String title, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: ClipOval(child: Image.asset(imagePath, fit: BoxFit.cover)),
          ),
          SizedBox(width: 8),
          Text(title, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // Método para construir las tarjetas de cursos
  Widget _buildCourseCard(
    String title,
    String author,
    String duration,
    String imagePath,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del curso con letra de categoría
          Stack(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage(imagePath), // Usar el nuevo parámetro
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 39, 37, 37),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    '10 mayo',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 43, 255, 0),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Información del curso
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  author,
                  style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      duration,
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir los botones de paginación
  Widget _buildPageButton(String text, bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color:
            isActive ? const Color.fromRGBO(32, 35, 41, 1) : Colors.transparent,
        border: Border.all(color: isActive ? Colors.green : Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
