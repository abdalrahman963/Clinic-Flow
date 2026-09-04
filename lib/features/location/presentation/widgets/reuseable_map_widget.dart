import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ReusableMapWidget extends StatelessWidget {
  final LatLng centerCoordinates;
  final double initialZoom;
  final List<Marker> markers;

  const ReusableMapWidget({
    super.key,
    required this.centerCoordinates,
    this.initialZoom = 13.0,
    this.markers = const [],
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: centerCoordinates,
        initialZoom: initialZoom,
      ),
      children: [
        TileLayer(
          // OpenStreetMap is the default, free tile provider
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(markers: markers),
      ],
    );
  }
}