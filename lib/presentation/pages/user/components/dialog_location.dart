import 'dart:async';
import 'package:crud_r/presentation/providers/request_permission.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class DialogLocation extends StatefulWidget {
  const DialogLocation({Key? key}) : super(key: key);

  @override
  State<DialogLocation> createState() => _DialogLocationState();
}

class _DialogLocationState extends State<DialogLocation> {
  final _controller = RequestPermission(Permission.locationWhenInUse);
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _controller.onStatusChanged.listen((status){
      if (status == PermissionStatus.granted){
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
