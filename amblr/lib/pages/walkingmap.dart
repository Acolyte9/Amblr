import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// This widget displays the map that users will see during
// their walking brainstorming session.
//will use it to show their location and walking path later
class WalkingMap extends StatelessWidget {
  const WalkingMap({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
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
      ],
    );
  }
}
