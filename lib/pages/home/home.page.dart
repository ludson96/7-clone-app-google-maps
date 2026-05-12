import 'dart:async';

import 'package:clone_app_google_maps/pages/home/widget/error_settings_map.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  late String mapStyle;

  late Future<CameraPosition> _positionFuture;

  int _selectedIndex = 0;

  Future<CameraPosition> _determinePosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('SERVICE_NOT_ENABLE');
    }

    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('PERMISSION_LOCATION_DENIED');
    }

    final currentPosition = await Geolocator.getCurrentPosition();

    final cameraPosition = CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 14,
    );

    return cameraPosition;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _positionFuture = _determinePosition();
    rootBundle
        .loadString('assets/map/style.json')
        .then((style) => mapStyle = style);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      if (!_mapController.isCompleted) {
        setState(() {
          _positionFuture = _determinePosition();
        });
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _positionFuture,
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final error = snapshot.error as String;

            if (error == 'SERVICE_NOT_ENABLE') {
              return ErrorSettingsMap(
                textButton: "Habilitar localização",
                textError:
                    "O serviço de localização está desabilitado. Você  precisa habilitar para utilizá-lo",
                onPressed: () async {
                  await Geolocator.openLocationSettings();
                },
              );
            }

            if (error == 'PERMISSION_LOCATION_DENIED') {
              return ErrorSettingsMap(
                textButton: "Conceder permissão de localização",
                textError:
                    "O aplicativo precisa de permissão de localização para funcionar.",
                onPressed: () async {
                  final permission = await Geolocator.requestPermission();
                  if (permission == LocationPermission.deniedForever) {
                    await Geolocator.openAppSettings();
                  } else if (permission == LocationPermission.whileInUse ||
                      permission == LocationPermission.always) {
                    setState(() {
                      _positionFuture = _determinePosition();
                    });
                  }
                },
              );
            }
          }

          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: snapshot.data!,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            style: mapStyle,
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
          );
        },
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return IconThemeData(color: Colors.blue[200]);
            }
            return const IconThemeData(color: Colors.grey);
          }),
        ),
        child: NavigationBar(
          backgroundColor: Color(0xFF151515),
          indicatorColor: Colors.blue.withValues(alpha: 0.1),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(color: Colors.white);
            }
            return const TextStyle(color: Colors.grey);
          }),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.place_outlined),
              selectedIcon: Icon(Icons.place),
              label: 'Explorar',
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark_border),
              selectedIcon: Icon(Icons.bookmark),
              label: 'Salvos',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_circle_outline),
              selectedIcon: Icon(Icons.add_circle),
              label: 'Contribuir',
            ),
          ],
        ),
      ),
    );
  }
}
