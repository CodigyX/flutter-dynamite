import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/fields/textfield.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../widgets/alerts/alerta_generica.dart';
import '../widgets/buttons/button_login.dart';
import 'home_page.dart';

// ignore: camel_case_types
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 150,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Sign in.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                const SizedBox(height: 15),
                TextFieldGeneric(
                  textController: usernameCtrl,
                  hintText: 'Username',
                  labelText: 'Username',
                  keyboardType: TextInputType.name,
                  obscureText: false,
                ),
                const SizedBox(height: 15),
                TextFieldGeneric(
                  textController: passwordCtrl,
                  hintText: 'Password',
                  labelText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                const SizedBox(height: 15),
                MyLoginButton(
                  onPressed: () async {
                    final username = usernameCtrl.text.trim();
                    final password = passwordCtrl.text.trim();

                    if (username.isEmpty || password.isEmpty) {
                      mostrarAlerta(context, 'Empty fields',
                          'Please complete all fields');
                      return;
                    }

                    authService.autenticando = true;

                    final loginOk = await authService.login(username, password);

                    authService.autenticando = false;

                    if (loginOk != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    } else {
                      mostrarAlerta(
                          context, 'Wrong login', 'Check your details');
                    }
                  },
                  enabled: !authService.autenticando,
                  loading: authService.autenticando,
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    // Agrega aquí la navegación a la pantalla de registro
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage()), // Reemplaza RegistroPage con tu página de registro
                    );
                  },
                  child: Text(
                    'You do not have an account? Sign up here',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
