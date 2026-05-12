import 'dart:async';

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

  CameraPosition? _initialPosition;

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

    _initialPosition = cameraPosition;

    return cameraPosition;
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

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
      setState(() {});
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
                  }
                },
              );
            }
          }

          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            style: mapStyle,
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
          );
        }
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
