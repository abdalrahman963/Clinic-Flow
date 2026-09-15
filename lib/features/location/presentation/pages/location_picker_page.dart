import 'package:clinic_flow/core/localization/l10n/app_localizations.dart';
import 'package:clinic_flow/features/location/domain/entities/location.dart';
import 'package:clinic_flow/features/location/presentation/bloc/location_bloc.dart';
import 'package:clinic_flow/features/location/presentation/bloc/location_event.dart';
import 'package:clinic_flow/features/location/presentation/bloc/location_state.dart';
import 'package:clinic_flow/features/location/presentation/widgets/reuseable_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../injection_container.dart';



/// Opens full-screen map picker (same stack as patient pharmacy / discovery maps).
Future<Location?> showLocationPicker(
  BuildContext context, {
  double? initialLatitude,
  double? initialLongitude,
}) {
  return Navigator.of(context).push<Location>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => BlocProvider(
        create: (_) {
          final bloc = sl<LocationBloc>();
          if (initialLatitude != null &&
              initialLongitude != null &&
              initialLatitude != 0 &&
              initialLongitude != 0) {
            bloc.add(
              UpdateSelectedLocationEvent(
                newLocation: Location(
                  latitude: initialLatitude,
                  longitude: initialLongitude,
                ),
              ),
            );
          } else {
            bloc.add(GetUserLocationEvent());
          }
          return bloc;
        },
        child: LocationPickerPage(
          initialLatitude: initialLatitude,
          initialLongitude: initialLongitude,
        ),
      ),
    ),
  );
}

class LocationPickerPage extends StatelessWidget {
  const LocationPickerPage({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
  });

  final double? initialLatitude;
  final double? initialLongitude;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.locationPickerTitle),
        actions: [
          IconButton(
            tooltip: loc.locationPickerMyLocation,
            onPressed: () => context.read<LocationBloc>().add(GetUserLocationEvent()),
            icon: const Icon(Icons.my_location),
          ),
        ],
      ),
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LocationError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => context.read<LocationBloc>().add(GetUserLocationEvent()),
                      child: Text(loc.commonTryAgain),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is! LocationLoaded) {
            return Center(child: Text(loc.locationPickerLoadingMap));
          }

          final selected = state.selectedLocation;
          final point = LatLng(selected.latitude, selected.longitude);

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: const Color(0xFFE0F2FE),
                child: Text(
                  loc.locationPickerTapHint(
                    selected.latitude.toStringAsFixed(5),
                    selected.longitude.toStringAsFixed(5),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: ReusableMapWidget(
                  centerCoordinates: point,
                  markers: [
                    Marker(
                      point: point,
                      width: 50,
                      height: 50,
                      alignment: Alignment.bottomCenter,
                      child: const Icon(Icons.location_pin, color: Colors.red, size: 44),
                    ),
                  ],
                  onMapTap: (newPoint) {
                    context.read<LocationBloc>().add(
                          UpdateSelectedLocationEvent(
                            newLocation: Location(
                              latitude: newPoint.latitude,
                              longitude: newPoint.longitude,
                            ),
                          ),
                        );
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context, selected),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: Text(loc.locationPickerConfirm),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
