import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:prueba_lunes_17/menu.dart';
//import 'package:prueba_lunes_17/widgets/captcha_widget.dart';
import 'package:prueba_lunes_17/widgets/captcha_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login con MySQL',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores para los campos de texto
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variable para mostrar mensajes de error
  String _errorMessage = '';
  // Variable para mostrar el indicador de carga
  bool _isLoading = false;

  //ABEL-VARIABLE PARA CHECKBOXES DEL LOGIN
  bool _rememberMe = false;

  //ABEL-VARIABLE PARA VISUALIZAR CONTRASEÑA
  bool _passwordVisible = false;

  // Variable para validar CAPTCHA
  bool _captchaValidated = false;

  // Función para validar el login
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // Obtener los valores de los campos
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    // Validar que los campos no estén vacíos y los checkboxes estén marcados
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, complete todos los campos';
        _isLoading = false;
      });
      return;
    }

    if (!_rememberMe) {
      setState(() {
        _errorMessage = 'Por favor, marque la casilla "Recuérdame"';
        _isLoading = false;
      });
      return;
    }

    if (!_captchaValidated) {
      setState(() {
        _errorMessage = 'Por favor, complete el CAPTCHA correctamente';
        _isLoading = false;
      });
      return;
    }

    try {
      // Reemplaza esta URL con la dirección IP de tu computadora donde está XAMPP
      // Asegúrate de que el archivo PHP esté en la carpeta htdocs de XAMPP
      final response = await http.post(
        //Uri.parse('http://192.168.18.125/tienda_api/login.php'),
        Uri.parse('http://192.168.18.125/api/login.php'),
        body: {'username': username, 'password': password},
      );

      final data = json.decode(response.body);

      if (data['success']) {
        // Login exitoso, navegar a la pantalla de bienvenida
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        // Login fallido, mostrar mensaje de error
        setState(() {
          _errorMessage = data['message'] ?? 'Usuario o contraseña incorrectos';
        });
      }
    } catch (e) {
      // Error de conexión
      setState(() {
        _errorMessage = 'Error de conexión: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Ajustamos la altura del Stack para que sea al menos el alto de la pantalla
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  // Fondo superior con imagen
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            const Color.fromARGB(
                              255,
                              255,
                              255,
                              255,
                            ).withOpacity(0.5),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Contenido del formulario
                  SafeArea(
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(
                            32,
                            35,
                            41,
                            1,
                          ).withOpacity(1.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/promolider_logo.png', // Asegúrate de tener esta imagen
                                  width: 220,
                                  height: 100,
                                ),
                              ],
                            ),
                            //const SizedBox(height: 8),
                            const Text(
                              'Impulsa tu liderazgo, comienza ahora.',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),

                            // Etiqueta de Usuario
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Usuario',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                hintText: 'Ingresar nombre de Usuario',
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: const Icon(
                                  Icons.person,
                                ), // Cambiado de prefixIcon a suffixIcon
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),

                            const SizedBox(height: 16),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Contraseña',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            TextField(
                              controller: _passwordController,
                              obscureText:
                                  !_passwordVisible, // Controla si la contraseña es visible
                              decoration: InputDecoration(
                                hintText: 'Ingresar Contraseña',
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),

                            //const SizedBox(height: 16),

                            //Fila con checkbox "Recordarme"
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>((
                                        Set<MaterialState> states,
                                      ) {
                                        return const Color.fromRGBO(
                                          32,
                                          35,
                                          41,
                                          1,
                                        ).withOpacity(1.0);
                                      }),
                                ),
                                const Text(
                                  'Recuérdame',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(), // Espacio flexible
                                TextButton(
                                  onPressed: () {
                                    // Función para recuperar contraseña
                                  },
                                  child: const Text(
                                    '¿Olvidaste tu contraseña?',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 12,
                                      decoration:
                                          TextDecoration
                                              .underline, // Subraya el texto
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //const SizedBox(height: 16),

                            // Reemplazar el antiguo checkbox de "No soy un robot" con el nuevo CaptchaWidget
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: _captchaValidated,
                                        onChanged: (value) async {
                                          if (!_captchaValidated) {
                                            await CaptchaDialog.show(context, (
                                              isValid,
                                            ) {
                                              setState(() {
                                                _captchaValidated = isValid;
                                              });
                                            });
                                          }
                                        },
                                        fillColor:
                                            MaterialStateProperty.resolveWith<
                                              Color
                                            >((Set<MaterialState> states) {
                                              return const Color.fromRGBO(
                                                32,
                                                35,
                                                41,
                                                1,
                                              ).withOpacity(1.0);
                                            }),
                                      ),
                                      const Text(
                                        'No soy un Robot',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          'assets/recaptcha.png',
                                          height: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //const SizedBox(height: 14),
                            if (_errorMessage.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Text(
                                  _errorMessage,
                                  style: const TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: _isLoading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(
                                  32,
                                  35,
                                  41,
                                  1,
                                ),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 10, 255, 23),
                                  width: 2,
                                ), // Agregar borde azul
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ), // Mantener bordes redondeados
                                ),
                              ),
                              child:
                                  _isLoading
                                      ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : const Text(
                                        'Ingresar',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
