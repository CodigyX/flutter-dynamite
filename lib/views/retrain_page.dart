import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_template/pallete.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DispatchScreen(),
    );
  }
}

class DispatchScreen extends StatefulWidget {
  @override
  _DispatchScreenState createState() => _DispatchScreenState();
}

class _DispatchScreenState extends State<DispatchScreen> {
  final dio = Dio();
  String githubToken =
      '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'; // Reemplaza con tu token de GitHub
  String dataseturl =
      'https://firebasestorage.googleapis.com/v0/b/weather-model-dab71.appspot.com/o/seattle-weather_100.csv?alt=media&token=2864b728-156d-447e-9b9a-a425c5daea20';
  String sha = 'i-love-adsoftsito';

  void dispatchGitHubEvent() async {
    final dispatchEventUrl =
        'https://api.github.com/repos/BernaRM111/weather/dispatches'; // Reemplaza con tu nombre de usuario y nombre de repositorio

    final payload = {
      "event_type": "ml_ci_cd",
      "client_payload": {
        "dataseturl": dataseturl,
        "sha": sha,
      }
    };

    final options = Options(
      headers: {
        'Authorization': 'Bearer $githubToken',
        'Accept': 'application/vnd.github.v3+json',
        'Content-type': 'application/json',
      },
    );

    try {
      final response =
          await dio.post(dispatchEventUrl, data: payload, options: options);

      if (response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Evento de GitHub Dispatch enviado con éxito.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error al enviar el evento de GitHub Dispatch.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrain model prediction'),
        backgroundColor: Pallete.gradient2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                  labelText: 'URL del dataset',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              onChanged: (value) {
                dataseturl = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'SHA',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              onChanged: (value) {
                sha = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: dispatchGitHubEvent,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Pallete.gradient2), // Cambia a tu color deseado
              ),
              child: Text('Enviar evento de GitHub Dispatch',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
