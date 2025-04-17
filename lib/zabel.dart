import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_lunes_17/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Promolider',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: const PromoHomePageAbel(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PromoHomePageAbel extends StatefulWidget {
  const PromoHomePageAbel({Key? key}) : super(key: key);

  @override
  State<PromoHomePageAbel> createState() => _PromoHomePageAbelState();
}

class _PromoHomePageAbelState extends State<PromoHomePageAbel> {
  List<Map<String, dynamic>> masterclass = [];
  List<Map<String, dynamic>> filteredMasterclass = [];
  bool isLoading = true;
  String? selectedCategoria;
  static const int itemsPerPage = 6;
  int currentPage = 1;
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  int get totalPages => (filteredMasterclass.length / itemsPerPage).ceil();

  List<Map<String, dynamic>> get paginatedMasterclass {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return filteredMasterclass.sublist(
      startIndex,
      endIndex > filteredMasterclass.length
          ? filteredMasterclass.length
          : endIndex,
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
    getMasterclass();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> getMasterclass() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.18.125/api/get_courses.php'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          masterclass = List<Map<String, dynamic>>.from(data);
          filteredMasterclass = masterclass;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  void filterByCategoria(String? categoria) {
    setState(() {
      selectedCategoria = categoria;
      if (categoria == null) {
        filteredMasterclass = masterclass;
      } else {
        filteredMasterclass =
            masterclass
                .where(
                  (masterclass) =>
                      masterclass['categoria']?.toString().toLowerCase() ==
                      categoria.toLowerCase(),
                )
                .toList();
      }
    });
  }

  void searchMasterclass(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        filteredMasterclass = masterclass;
      } else {
        filteredMasterclass =
            masterclass
                .where(
                  (masterclass) => masterclass['titulo']
                      .toString()
                      .toLowerCase()
                      .contains(searchTerm.toLowerCase()),
                )
                .toList();
      }
      currentPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(221, 15, 15, 15),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          },
        ),
        title:
            isSearching
                ? TextField(
                  controller: searchController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Buscar masterclass...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => searchMasterclass(value),
                )
                : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/usuario.jpg'),
                        radius: 20,
                      ),
                      SizedBox(width: 30),
                      Image.asset('assets/promolider_logo.png', width: 140),
                    ],
                  ),
                ),
        actions: [
          IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  isSearching = false;
                  searchController.clear();
                  searchMasterclass('');
                } else {
                  isSearching = true;
                }
              });
            },
          ),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categorías',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => filterByCategoria(null),
                    child: Text(
                      'Ver todo >',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 41, 40, 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey[300], height: 15, thickness: 1),
            SizedBox(height: 2),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _buildCategoryItem(
                    'assets/web_icon.jpg',
                    'Desarrollo Web',
                    Colors.orange,
                  ),

                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/business_icon.jpg',
                    'Negocio',
                    Colors.green,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/personal_icon.jpg',
                    'Desarrollo Personal',
                    const Color.fromARGB(255, 160, 142, 163),
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/design_icon.jpg',
                    'Diseño',
                    Colors.pink,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/marketing_icon.jpg',
                    'Marketing',
                    Colors.red,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/lifestyle_icon.jpg',
                    'Estilo de vida',
                    Colors.teal,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/health_icon.jpg',
                    'Salud y Fitness',
                    Colors.lightBlue,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/teaching_icon.jpg',
                    'Enseñanza y academia',
                    Colors.amber,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/mobile_icon.jpg',
                    'Aplicaciones Móviles',
                    Colors.indigo,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/programming_icon.jpg',
                    'Lenguajes de Programación',
                    Colors.deepPurple,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/games_icon.jpg',
                    'Desarrollo de juegos',
                    Colors.brown,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/finance_icon.jpg',
                    'Finanzas',
                    Colors.green,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/communications_icon.jpg',
                    'Comunicaciones',
                    Colors.orange,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/strategy_icon.jpg',
                    'Estrategia',
                    Colors.blue,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/project_icon.jpg',
                    'Gestión de proyectos',
                    Colors.purple,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/law_icon.jpg',
                    'Derecho Mercantil',
                    Colors.blueGrey,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/transformation_icon.jpg',
                    'Transformación Personal',
                    Colors.deepOrange,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/leadership_icon.jpg',
                    'Liderazgo',
                    Colors.red,
                  ),
                  SizedBox(width: 8),
                  _buildCategoryItem(
                    'assets/webdesign_icon.jpg',
                    'Diseño Web',
                    Colors.cyan,
                  ),
                ],
              ),
            ),
            SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child:
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.75,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: paginatedMasterclass.length,
                        itemBuilder: (context, index) {
                          final masterclass = paginatedMasterclass[index];
                          return GestureDetector(
                            onTap: () {},
                            child: _buildMasterclassCard(
                              masterclass['titulo'],
                              masterclass['categoria'],
                              masterclass['fecha_creacion'],
                              masterclass['imagen_path'],
                            ),
                          );
                        },
                      ),
            ),
            if (!isLoading && totalPages > 0)
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
    );
  }

  Widget _buildCategoryItem(String imagePath, String titulo, Color color) {
    final bool isSelected = selectedCategoria == titulo;
    return GestureDetector(
      onTap: () => filterByCategoria(titulo),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromARGB(255, 245, 245, 245),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: ClipOval(child: Image.asset(imagePath, fit: BoxFit.cover)),
            ),
            SizedBox(width: 6),
            Text(
              titulo,
              style: TextStyle(fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMasterclassCard(
    String titulo,
    String categoria,
    String fecha_creacion,
    String imagenPath,
  ) {
    // Construir la URL completa para la imagen
    String imageUrl = 'http://192.168.18.125/api/$imagenPath';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                ),
                // Usar Image.network en lugar de AssetImage
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(Icons.error, color: Colors.red),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ],
          ),
          /*Stack(
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
                    image: AssetImage(imagenPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),*/
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  categoria,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 14),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      fecha_creacion,
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

  Widget _buildPageButton(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color:
              isActive
                  ? const Color.fromRGBO(32, 35, 41, 1)
                  : Colors.transparent,
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
      ),
    );
  }
}
