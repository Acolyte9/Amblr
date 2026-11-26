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


    // Try to get the user's current position.
    // If GPS fails print an error
    Position position;

    try {
      position = await Geolocator.getCurrentPosition();
}     catch (error) {
        debugPrint('Could not get current location: $error');
        return;
    }

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
        // Draws a green line connecting the GPS points collected while the user walks.
        if (walkingPath.length >= 2)
        PolylineLayer(
          polylines: [
            Polyline(
              points: walkingPath,
              strokeWidth: 4,
              color: Colors.green,
            ),
          ],
        ),

        // Shows a small green dot for every GPS position
        // collected during the walking session.
        MarkerLayer(
          markers: walkingPath.map((point) {
            return Marker(
              point: point,
              width: 12,
              height: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            );
          }).toList(),
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
                  color: Colors.green,
                  size: 40,
                ),
              ),
            ],
          ),

        // Shows how many GPS coordinates have been recorded.
        // This helps us test whether location tracking is working.
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution('OpenStreetMap contributors'),
          ],
        ),
        // Displays the number of collected GPS points on the map.
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Text(
              'GPS points: ${walkingPath.length}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
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