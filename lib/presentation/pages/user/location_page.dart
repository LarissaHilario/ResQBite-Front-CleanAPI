
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}
class _LocationState extends State<LocationPage> {
  final initialCameraPosition =  const CameraPosition(target: LatLng(0,0));

  @override
  Widget build(BuildContext context) {
    return GoogleMap( initialCameraPosition: const CameraPosition(
      target: LatLng(16.75973, -93.11308),
      zoom: 14,
    ),);
  }

}
