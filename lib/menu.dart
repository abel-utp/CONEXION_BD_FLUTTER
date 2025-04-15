import 'package:flutter/material.dart';
import 'package:prueba_lunes_17/main.dart';
import 'package:prueba_lunes_17/marketplace.dart';
import 'package:prueba_lunes_17/masterclass_1.dart';
import 'package:prueba_lunes_17/registro_principal.dart';

void main() {
  // Punto de entrada de la aplicación
  runApp(const PromoLiderApp());
}

class PromoLiderApp extends StatelessWidget {
  const PromoLiderApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuración general de la aplicación
    return MaterialApp(
      title: 'Promolider App',
      debugShowCheckedModeBanner: false, // Quita el banner de debug
      theme: ThemeData(
        // Configura el tema oscuro para toda la app
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        colorScheme: ColorScheme.dark(
          primary: const Color(
            0xFF00C853,
          ), // Color verde para elementos destacados
          secondary: const Color(0xFF00C853),
        ),
      ),
      home: const MainScreen(), // Pantalla principal
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Variable para controlar qué opción del menú está seleccionada
  int _selectedIndex = 0;

  // Variable para controlar el estado de expansión
  bool _isExpanded = false;

  // Lista de títulos para el contenido principal
  final List<String> _titles = [
    'Dashboards',
    'Aula Virtual',
    'Masterclass',
    'Marketplace',
    'Registros',
  ];

  // Método para cambiar la opción seleccionada
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Configura el cuerpo principal de la app
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(_titles[_selectedIndex]),
        // Agregar el color blanco al icono del menú
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // Menú lateral (Drawer)
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF212121), // Color de fondo oscuro para el menú
          child: Column(
            children: [
              // Cabecera del menú con logo
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 30),
                    Image.asset('assets/promolider_logo.png', width: 190),
                  ],
                ),
              ),

              // Opciones del menú
              _buildMenuItem(
                icon: Icons.dashboard,
                title: 'Dashboards',
                index: 0,
                iconColor:
                    Colors
                        .white, // Agregar el color blanco específicamente para este ícono
              ),

              // Modificar el ExpansionTile
              ExpansionTile(
                leading: Icon(
                  _isExpanded ? Icons.folder_open : Icons.folder,
                  color: Colors.white,
                ),
                title: const Text(
                  'Aula Virtual',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isExpanded = expanded;
                  });
                },
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 16),
                    leading: const Icon(Icons.school, color: Colors.white),
                    title: const Text(
                      'Masterclass',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MasterclassCreationScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 16),
                    leading: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Marketplace',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PromoHomePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 16),
                    leading: const Icon(Icons.assignment, color: Colors.white),
                    title: const Text(
                      'Registros',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MasterPromoLiderApp(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const Spacer(), // Espacio flexible para empujar el botón de cerrar sesión al fondo
              // Botón de cerrar sesión
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    // Navega a la pantalla principal (main.dart) al hacer clic en "Cerrar Sesión"
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Row(
                      children: [
                        Icon(Icons.logout, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Cerrar Sesión',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Contenido principal (aquí iría el contenido de cada sección)
      body: Center(
        child:
            _selectedIndex == 0
                ? Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 17,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.asset('assets/promolider_logo.png', width: 300),
                )
                : Text(
                  'Contenido de ${_titles[_selectedIndex]}',
                  style: const TextStyle(fontSize: 24),
                ),
      ),
    );
  }

  // Método para construir cada ítem del menú
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required int index,
    Color iconColor = Colors.white, // Agregar parámetro para el color del ícono
    VoidCallback? onTap,
  }) {
    bool isSelected = _selectedIndex == index;

    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      // Cambia el color de fondo si está seleccionado
      tileColor: isSelected ? Colors.green.withOpacity(0.3) : null,
      onTap:
          onTap ??
          () {
            _onItemTapped(index);
            Navigator.pop(
              context,
            ); // Cierra el drawer al seleccionar una opción
          },
    );
  }
}
