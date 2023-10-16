import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/views/DashboardPage.dart';
import 'package:flutter_template/pallete.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({Key? key}) : super(key: key);

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController precipitationController = TextEditingController();
  final TextEditingController temp_maxController = TextEditingController();
  final TextEditingController temp_minController = TextEditingController();
  final TextEditingController windController = TextEditingController();

  void _openDrawer(BuildContext context) {
    _scaffoldKey.currentState!.openDrawer();
  }

  String? predictText;

  Future<void> getPredict() async {
    try {
      String endpoint =
          'https://weather-ml-service-bernarm111.cloud.okteto.net/predict';
      final response = await Dio().post(endpoint, data: {
        "precipitation": double.tryParse(precipitationController.text) ?? 0,
        "temp_max": double.tryParse(temp_maxController.text) ?? 0,
        "temp_min": double.tryParse(temp_minController.text) ?? 0,
        "wind": double.tryParse(windController.text) ?? 0,
      });

      setState(() {
        predictText = response.data.toString();
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  void dispose() {
    precipitationController.dispose();
    temp_maxController.dispose();
    temp_minController.dispose();
    temp_minController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Model prediction'),
        backgroundColor: Pallete.gradient2,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: precipitationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Precipitation',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: temp_maxController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'TempMax',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: temp_minController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'TempMin',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: windController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Wind',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  getPredict();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Pallete.gradient2), // Cambia a tu color deseado
                ),
                child: const Text('Get weather',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              if (predictText != null)
                Text(
                  'Weather: $predictText',
                  style: const TextStyle(fontSize: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
