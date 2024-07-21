import 'package:crud_r/presentation/pages/user/components/ubications_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../domain/repositories/user_repository.dart';
import '../../../infraestructure/repositories/user_repository_impl.dart';
import '../../providers/user_provider.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<LocationPage> {
  final UserRepository userRepository = UserRepositoryImpl();
  final initialCameraPosition = const CameraPosition(target: LatLng(0, 0));
  LatLng? userLocation;
  GoogleMapController? mapController;

  void _showDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: UbicationsWidget(onLocationSelected: _onLocationSelected),
        );
      },
    );
  }

  void _onLocationSelected(String location) async {
    Navigator.pop(context); // Cierra el BottomSheet

    // Establecer las coordenadas correspondientes para el mapa
    LatLng coordinates;
    if (location == 'suchiapa') {
      coordinates = const LatLng(16.629444, -93.091667);
    } else {
      coordinates = const LatLng(16.75973, -93.11308);
    }

    mapController?.animateCamera(CameraUpdate.newLatLngZoom(coordinates, 14));
    setState(() {
      userLocation = coordinates;
    });
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
    if (token != null) {
      try {
        await userRepository.updateUserLocation(token, location);
        print('Ubicación actualizada exitosamente en el servidor.');
      } catch (e) {
        print('Error al actualizar la ubicación: $e');
      }
    } else {
      print('Token no encontrado.');
    }
  }
  Future<LatLng?> getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          padding: const EdgeInsets.only(
            top: 100.0,
          ),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) async {
            mapController = controller;
            LatLng? location = await getUserLocation();
            if (location != null) {
              if (mounted) {
                setState(() {
                  userLocation = location;
                });
                controller.animateCamera(CameraUpdate.newLatLngZoom(location, 14));
              }
              controller.animateCamera(CameraUpdate.newLatLngZoom(location, 14));
            }
          },
          initialCameraPosition: const CameraPosition(
            target: LatLng(16.75973, -93.11308),
            zoom: 14,
          ),
          markers: userLocation != null
              ? {
            Marker(
              markerId: MarkerId('userLocation'),
              position: userLocation!,
            ),
          }
              : {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 305.0, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: _showDialog,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const  Color(0xFF88B04F),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.location_on, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}