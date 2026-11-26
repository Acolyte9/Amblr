import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// Provides access to GPS coordinates and location permissions.
import 'package:geolocator/geolocator.dart';
import 'dart:async';
// This widget displays the map that users will see during
// their walking brainstorming session.
//will use it to show their location and walking path later
class WalkingMap extends StatefulWidget {
  const WalkingMap({super.key});

  @override
  State<WalkingMap> createState(){
    return _WalkingMapState();
  }
}
class _WalkingMapState extends State<WalkingMap> {
  // Controls the map so we can move it to the user's location.
  final MapController mapController = MapController();

  // Stores the user's location after GPS finds it.
  LatLng? currentLocation;
  // Stores the GPS coordinates collected during the walking session.
  List<LatLng> walkingPath = [];
  // Stores the GPS listener so we can stop it when the map closes.
  StreamSubscription<Position>? positionSubscription;

    @override
    void initState() {
    super.initState();

    // Finds the user's location when the map first opens.
    getCurrentLocation();
  }

  // Checks location services and asks for permission if needed.
  // If permission is granted finds the user's current position.
  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Stop if the user does not allow location access.
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    // Get the user's current latitude and longitude.
    Position position = await Geolocator.getCurrentPosition();

    if (!mounted) return;

    setState(() {
      currentLocation = LatLng(
        position.latitude,
        position.longitude,
      );
    });

    // Moves the map to the user's current location.
    mapController.move(currentLocation!, 16);
    // Start collecting GPS updates after location permission is granted.
    startLocationTracking();
  }

   // Starts listening for GPS updates while the walking map is open.
   // Each new location is added to the walkingPath list.
  void startLocationTracking() {
    // Avoid starting multiple GPS listeners.
    if (positionSubscription != null) return;

    // Request location updates when the device moves.
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    positionSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(
      (Position position) {
        // Stop updating if this widget has been closed.
        if (!mounted) return;

        // Convert the GPS coordinates into a map point.
        final LatLng newPoint = LatLng(
          position.latitude,
          position.longitude,
        );

        // Save the new location and add it to the walking path.
        setState(() {
          currentLocation = newPoint;
          walkingPath.add(newPoint);
        });
      },
      onError: (Object error) {
        // Log GPS errors so we can diagnose tracking problems.
        debugPrint('Location tracking error: $error');
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        // Connects the controller to center the map
       mapController: mapController,
       // Set the starting location and zoom level of the map.
      // used conway temporarily until I add live GPS location.
      options: const MapOptions(
        initialCenter: LatLng(35.0887, -92.4421),
        initialZoom: 15,
      ),
      children: [
            // It loads the map tiles from OpenStreetMap so users
        // can see roads, buildings, and other nearby places.
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'amblr',
        ),
         // Show a blue marker once the user's location is found.
        if (currentLocation != null)
          MarkerLayer(
            markers: [
              Marker(
                point: currentLocation!,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
            ],
          ),
      ],
    );
  }

  @override
  void dispose() {
    // Stops listening for GPS updates when the walking map closes
    positionSubscription?.cancel();
    mapController.dispose();
    super.dispose();
}
}