import 'package:crud_r/presentation/pages/admin/tap_bar_admi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crud_r/presentation/pages/admin/home_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  Future<void> _simulateLoading() async {
    setState(() {
      _isLoading = true;
    });
    _controller.repeat();
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      _controller.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TapBarAdmi())
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/images/loading.svg',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  '¡Hola de nuevo!',
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Color(0xFF464646),
                    fontWeight: FontWeight.normal,
                    fontFamily: 'FiraSansCondensed',
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Veamos cómo todo por aquí',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Color(0xFF464646),
                      fontWeight: FontWeight.normal,
                      fontFamily: 'FiraSansCondensed',
                    ),
                  ),
                ),
              ),
              if (_isLoading)
                RotationTransition(
                  turns: _controller,
                  child: SvgPicture.asset(
                    'assets/images/load.svg',
                    width: 40,
                    height: 40,
                    semanticsLabel: 'Loader',
                  ),
                ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _simulateLoading,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF88B04F),
                    minimumSize: const Size(300, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'FiraSansCondensed',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
