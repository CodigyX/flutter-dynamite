import 'package:flutter/material.dart';
import 'package:flutter_template/pallete.dart';
import 'package:flutter_template/views/landing_page.dart';
import 'package:flutter_template/views/prediction_page.dart';
import 'package:flutter_template/views/retrain_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: Text('Menú'),
              decoration: BoxDecoration(
                color: Pallete.gradient2,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () => onItemPressed(context, index: 0),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca de'),
              onTap: () => onItemPressed(context, index: 1),
            ),
            ListTile(
              title: const Text('Model Prediction'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PredictionPage()));
              },
            ),
            ListTile(
              title: const Text('Retrain Model Prediction'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DispatchScreen()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar sesion'),
              onTap: () => onItemPressed(context, index: 2),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/logo.png",
                  height: 150,
                ),
                SizedBox(height: 20),
                Text(
                  "¡Bienvenido a MyApp!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Explora las características de la aplicación desde el menú.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LandingPage()));
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }
}
