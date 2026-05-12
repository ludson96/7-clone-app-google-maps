import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: GoogleMap(
      //   mapType: MapType.normal,
      //   initialCameraPosition: _kGooglePlex,
      //   onMapCreated: (GoogleMapController controller) {
      //     _mapController.complete(controller);
      //   },
      // ),
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
