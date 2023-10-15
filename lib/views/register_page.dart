import 'package:flutter/material.dart';
import 'package:flutter_template/views/login_page.dart';
import 'package:flutter_template/widgets/fields/textfield.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/alerts/alerta_generica.dart';
import '../widgets/buttons/button_register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
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
                'Sign up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 15),
              TextFieldGeneric(
                textController: emailController,
                hintText: 'Email',
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),
              const SizedBox(height: 15),
              TextFieldGeneric(
                textController: usernameController,
                hintText: 'Username',
                labelText: 'Username',
                keyboardType: TextInputType.name,
                obscureText: false,
              ),
              const SizedBox(height: 15),
              TextFieldGeneric(
                textController: passwordController,
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
              const SizedBox(
                height: 15,
              ),
              MyRegisterButton(
                onPressed: () async {
                  final email = emailController.text.trim();
                  final username = usernameController.text.trim();
                  final password = passwordController.text.trim();

                  if (email.isEmpty || username.isEmpty || password.isEmpty) {
                    mostrarAlerta(
                      context,
                      'Empty fields',
                      'Please complete all fields',
                    );
                    return;
                  }
                  //Pueden agregar mas validaciones antes de pasar al back

                  authService.autenticando = true;

                  final registerOk =
                      await authService.register(email, username, password);

                  authService.autenticando = false;

                  if (registerOk) {
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    mostrarAlerta(
                      context,
                      'Registration failed',
                      'Registration could not be completed',
                    );
                  }
                },
                enabled: !authService.autenticando,
                loading: authService.autenticando,
              ),
              const SizedBox(height: 15),
              const Text(
                'Already have an account?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Sign in',
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
    ));
  }
}
