import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Obter Posição no Mapa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MapScreenOSM(),
    );
  }
}

class MapScreenOSM extends StatefulWidget {
  const MapScreenOSM({super.key});

  @override
  State<MapScreenOSM> createState() => _MapScreenOSMState();
}

class _MapScreenOSMState extends State<MapScreenOSM> {
  LatLng? _pontoClicado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Obter Coordenadas (flutter_map)')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: const LatLng(-22.7130000, -46.8180000),
          initialZoom: 17.0,
          onTap: (tapPosition, latLng) {
            setState(() {
              _pontoClicado = latLng;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}',
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.flutter_maps_aula05',
          ),
          if (_pontoClicado != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _pontoClicado!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
