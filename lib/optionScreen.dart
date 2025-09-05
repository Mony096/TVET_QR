import 'package:npit_qr/component/button.dart';
import 'package:npit_qr/feature/scanning/presentation/scanning_screen.dart';
import 'package:npit_qr/helper/helper.dart';
import 'package:npit_qr/middleware/presentation/login_screen.dart';
import 'package:npit_qr/middleware/presentation/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background image

          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg.png'), // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Central Title and columns

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  'តើអ្នកជានរណា​ ?',
                  style: GoogleFonts.koulen(
                    textStyle: const TextStyle(
                        fontSize: 27,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                const SizedBox(height: 100), // Space between Title and boxes
                // Boxes below Title
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center, // Centers children horizontally
                  children: [
                    // Main container
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                      margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 96, 100, 105)
                                .withOpacity(0.25),
                            blurRadius: 4,
                            spreadRadius: 2,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(children: [
                        Button(
                          heigth: 48.00,
                          bgColor: const Color.fromARGB(255, 28, 104, 235),
                          //   width: 250,

                          //   height: 60,
                          variant: ButtonVariant.ghost,
                          loading: false,
                          child: const Text(
                            'រដ្ធបាល',
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          onPressed: () => goTo(context, const LoginScreen()),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Button(
                          heigth: 48.00,
                          bgColor: const Color.fromARGB(255, 28, 104, 235),
                          //   width: 250,
                          onPressed: () => goTo(context, const LoginScreen()),
                          //   height: 60,
                          variant: ButtonVariant.ghost,
                          loading: false,
                          child: const Text(
                            'សាស្រ្តាចា',
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Button(
                          heigth: 48.00,
                          bgColor: const Color.fromARGB(255, 28, 104, 235),
                          //   width: 250,

                          //   height: 60,
                          variant: ButtonVariant.ghost,
                          loading: false,
                          child: const Text(
                            'សិស្ស ឬ​ អាណាព្យាបាល',
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          onPressed: () =>
                              goTo(context, const ScanningListScreen()),
                        ),
                      ]),
                    ),
                    // Logo positioned above the container
                    Positioned(
                      top: -50, // Offset the logo upward
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: 90,
                        height: 90,
                        child: SvgPicture.asset(
                          'images/user.svg',
                          color: const Color.fromARGB(255, 28, 104, 235),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Copyright@ 2025 TVET Cambodia",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "All right reserved",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),

          // SizedBox(height: 100,)
        ],
      ),
    );
  }
}
