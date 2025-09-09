import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.3;
  double _iconSize = 50.0;
  double _textPosition = 0; // Start from bottom
  double _sizeNpit = 50.0; // Start small
  double _opacityNpit = 0.0;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacityNpit = 1;
        _sizeNpit = 110.0; // Grow size
        _opacity = 0.8; // Fade background color overlay
        _iconSize = 150; // Scale icon
        _textPosition = 245; // Move text to center
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          Positioned.fill(
            child: Image.asset(
              'images/pic_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          /// Color Overlay Animation
          AnimatedOpacity(
            duration: const Duration(seconds: 2),
            opacity: _opacity,
            child: Container(
              color: const Color.fromARGB(255, 34, 5, 176), // Adjust color
            ),
          ),

          /// Center Icon Animation (Fade & Scale)
          Center(
            child: TweenAnimationBuilder(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: 50, end: _iconSize),
              builder: (context, size, child) {
                return Opacity(
                  opacity: _opacity,
                  child: Image.asset(
                    'images/logo.png',
                    width: size,
                    height: size,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10,),
          /// Animated NPIT Image (Size & Position)
          AnimatedPositioned(
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            bottom: _textPosition,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                width: _sizeNpit,
                height: _sizeNpit,
                child: Opacity(
                  opacity: _opacityNpit,
                  child: Image.asset(
                    'images/NPIT.png',
                    color: Colors.white,
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
