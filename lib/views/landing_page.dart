import 'package:flutter/material.dart';
import 'package:flutter_template/views/login_page.dart';
import 'package:flutter_template/widgets/buttons/button_landing.dart';
import 'package:flutter_template/widgets/fields/textfield.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/alerts/alerta_generica.dart';
import '../widgets/buttons/button_register.dart';
import '../widgets/buttons/button_login.dart';
import 'home_page.dart';
import 'register_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
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
                  'Welcome to MyApp',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Join our community or sign in to continue.',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                LandingButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  label: 'Sign In',
                ),
                const SizedBox(height: 15),
                LandingButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  label: 'Sign Up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}