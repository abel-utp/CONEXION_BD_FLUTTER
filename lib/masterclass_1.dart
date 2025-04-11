import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'menu.dart'; // Importa la clase MenuScreen
import 'masterclass_2.dart'; // Importa la clase MasterclassScreen

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
        primarySwatch: Colors.green,
        inputDecorationTheme: InputDecorationTheme(alignLabelWithHint: true),
      ),
      home: const MasterclassCreationScreen(),
    );
  }
}

class MasterclassCreationScreen extends StatefulWidget {
  const MasterclassCreationScreen({Key? key}) : super(key: key);

  @override
  State<MasterclassCreationScreen> createState() =>
      _MasterclassCreationScreenState();
}

class _MasterclassCreationScreenState extends State<MasterclassCreationScreen> {
  String? selectedCategory;
  DateTime? selectedDate;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isPhoneValid = true;

  final List<String> categories = [
    'Aplicaciones Móviles',
    'Comunicaciones',
    'Derecho Mercantil',
    'Desarrollo Personal',
    'Desarrollo Web',
    'Desarrollo de juegos',
    'Diseño',
    'Diseño Web',
    'Enseñanza y academia',
    'Estilo de vida',
    'Estrategia',
    'Finanzas',
    'Gestión de proyectos',
    'Lenguajes de Programación',
    'Liderazgo',
    'Marketing',
    'Negocio',
    'Salud y Fitness',
    'Transformación Personal',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    dateController.dispose();
    super.dispose();
  }

  bool validatePhone(String value) {
    return value.length == 9 && RegExp(r'^[0-9]+$').hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Agregar esta línea
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/promolider_logo.png',
              height: 40, // Ajusta el tamaño de la imagen según sea necesario
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 14, 15, 14),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Creación de Masterclass',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              // Horizontal Divider
              Divider(color: Colors.grey[300], height: 14, thickness: 1),

              const SizedBox(height: 5),
              const Text(
                'Información General:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              // Horizontal Divider
              Divider(color: Colors.grey[300], height: 24, thickness: 1),

              const SizedBox(height: 15),
              const Text('Título'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Título de la masterclass',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 59, 59, 59),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text('Categoría'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 61, 61, 61),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    value: selectedCategory,
                    isExpanded: true,
                    dropdownStyleData: DropdownStyleData(
                      offset: const Offset(0, -5),
                      maxHeight: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: const Text(
                      'Seleccionar una categoría',
                      style: TextStyle(color: Color.fromARGB(255, 54, 54, 54)),
                    ),
                    items:
                        categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text('Descripción'),
              TextField(
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Descripción de la Masterclass',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 49, 49, 49),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 10,
                    top: 10,
                    right: 10,
                    bottom: 7,
                  ),
                  alignLabelWithHint: false,
                ),
              ),
              const SizedBox(height: 15),
              const Text('Objetivos'),
              TextField(
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Objetivos de la masterclass',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 43, 43, 43),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 10,
                    top: 10,
                    right: 10,
                    bottom: 7,
                  ),
                  alignLabelWithHint: false,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Fecha de Finalización'),
                        TextField(
                          controller: dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'dd/mm/yyyy',
                            hintStyle: TextStyle(
                              color: const Color.fromARGB(255, 63, 62, 62),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () => _selectDate(context),
                            ),
                          ),
                          onTap: () => _selectDate(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(
                      'Mejorar con IA',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text('Contacto'),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                maxLength: 9,
                decoration: InputDecoration(
                  hintText: 'Teléfono (9 dígitos)',
                  errorText:
                      isPhoneValid ? null : 'Ingrese exactamente 9 dígitos',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 54, 54, 54),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  counterText: '',
                ),
                onChanged: (value) {
                  setState(() {
                    isPhoneValid = validatePhone(value);
                  });
                },
              ),

              const SizedBox(height: 15),
              const Text('Correo'),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Correo electrónico',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 54, 54, 54),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                ),
              ),

              const SizedBox(height: 7),
              const Text('Imagen'),
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 61, 61, 61),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    // Aquí puedes agregar la lógica para subir la imagen
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.upload_file, size: 30),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Subir imagen de la Masterclass',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),
              const Text('Documentos'),
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 61, 61, 61),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    // Aquí puedes agregar la lógica para subir documentos
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.file_present, size: 30),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Subir documentos de la Masterclass',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),
              const Text('Enlace de la reunión'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Link de la reunión',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 54, 54, 54),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                ),
              ),

              const SizedBox(height: 50),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MasterclassScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: const Color.fromARGB(255, 2, 253, 11),
                      ), // Añade esta línea para el borde verde
                    ),
                  ),
                  child: const Text('Guardar', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
