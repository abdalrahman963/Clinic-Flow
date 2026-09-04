import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ReusableMapWidget extends StatelessWidget {
  final LatLng centerCoordinates;
  final double initialZoom;
  final List<Marker> markers;
  final Function(LatLng)? onMapTap; // ADD THIS

  const ReusableMapWidget({
    super.key,
    required this.centerCoordinates,
    this.initialZoom = 15.0,
    this.markers = const [],
    this.onMapTap, // ADD THIS
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: centerCoordinates,
        initialZoom: initialZoom,
        minZoom: 5.0, // The user cannot zoom out further than city-level
        maxZoom: 18.0, // The user cannot zoom in closer than building-level
        // ADD THE onTap TRIGGER HERE:
        onTap: (tapPosition, point) {
          if (onMapTap != null) {
            onMapTap!(point);
          }
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.clinic_flow.flutter_app',
        ),
        MarkerLayer(markers: markers),
      ],
    );
  }
}