import 'package:crud_r/presentation/components/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UbicationsWidget extends StatelessWidget {
  final void Function(LatLng) onLocationSelected;

  const UbicationsWidget({Key? key, required this.onLocationSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: SearchBarComponent(
                  hintText: 'Selecciona tu ubicación...'),
            ),
          ),
          SizedBox(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => onLocationSelected(const LatLng(16.629444 , -93.091667)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: const Image(
                                width: 60,
                                height: 60,
                                image: AssetImage('assets/images/suchiapa.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'SUCHIAPA',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFF464646),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'FiraSansCondensed',
                              letterSpacing: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.1,
                            vertical: MediaQuery.of(context).size.height * 0.009,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => onLocationSelected(const LatLng(16.75973, -93.11308)), // Coordenadas de Tuxtla
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: const Image(
                                    width: 60,
                                    height: 60,
                                    image: AssetImage('assets/images/tuxtla.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              const Text(
                                'TUXTLA',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xFF464646),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'FiraSansCondensed',
                                  letterSpacing: 3,
                                ),
                              ),
                            ],
                          ))),
                ],
              ))
        ],
      ),
    );
  }
}
