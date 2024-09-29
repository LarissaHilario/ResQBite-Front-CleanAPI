import 'dart:async';
import 'package:crud_r/presentation/providers/request_permission.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/user_repository.dart';
import '../../../../infraestructure/repositories/user_repository_impl.dart';
import '../../../providers/user_provider.dart';


class DialogLocation extends StatefulWidget {
  const DialogLocation({Key? key}) : super(key: key);

  @override
  State<DialogLocation> createState() => _DialogLocationState();
}

class _DialogLocationState extends State<DialogLocation> {
  final _controller = RequestPermission(Permission.locationWhenInUse);
  late StreamSubscription _subscription;
  final UserRepository userRepository = UserRepositoryImpl();

  @override
  void initState() {
    super.initState();
    _subscription = _controller.onStatusChanged.listen((status){
      if (status == PermissionStatus.granted){
        _updateLocation();
        return;
      }
    });
  }


  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }
  String _determineLocation(double latitude, double longitude) {
    // Coordenadas aproximadas de Suchiapa
    const double suchiapaLatMin = 16.660;
    const double suchiapaLatMax = 16.674;
    const double suchiapaLonMin = -93.106;
    const double suchiapaLonMax = -93.094;

    // Coordenadas aproximadas de Tuxtla Gutiérrez
    const double tuxtlaLatMin = 16.740;
    const double tuxtlaLatMax = 16.760;
    const double tuxtlaLonMin = -93.126;
    const double tuxtlaLonMax = -93.106;

    if (latitude >= suchiapaLatMin && latitude <= suchiapaLatMax &&
        longitude >= suchiapaLonMin && longitude <= suchiapaLonMax) {
      return "SUCHIAPA";
    } else if (latitude >= tuxtlaLatMin && latitude <= tuxtlaLatMax &&
        longitude >= tuxtlaLonMin && longitude <= tuxtlaLonMax) {
      return "TUXTLA";
    } else {
      return "UNKNOWN";
    }
  }


  Future<void> _updateLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final token = Provider
        .of<UserProvider>(context, listen: false)
        .user
        ?.token;

    if (token != null) {
      String location = _determineLocation(
          position.latitude, position.longitude);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Padding(
      padding: const EdgeInsets.only(top: 1),
          child:
          Text(
            'RESQBITE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35.0,
              color: Color(0xFF464646),
              fontWeight: FontWeight.w500,
              fontFamily: 'FiraSansCondensed',
              letterSpacing: 5,
            ),
          ),
          ),
          Image.asset('assets/images/location-image.png',
            width: 250,
            height: 250,),
          const Text(
            'Necesita permisos para '
                'acceder a tu ubicación',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Color(0xFF464646),
              fontWeight: FontWeight.w500,
              fontFamily: 'FiraSansCondensed',
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 75),
              child: ElevatedButton(
                onPressed: () {
                  _controller.request();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF88B04F),
                  minimumSize: Size(150, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Vamos',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'FiraSansCondensed',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
