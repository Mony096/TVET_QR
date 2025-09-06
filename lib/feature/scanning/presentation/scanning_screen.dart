import 'package:npit_qr/feature/scanning/presentation/detail_qr_scanned.dart';
import 'package:npit_qr/feature/scanning/presentation/qr_code_scanner_screen.dart';
import 'package:npit_qr/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanningListScreen extends StatefulWidget {
  const ScanningListScreen({super.key});

  @override
  _ScanningListScreenState createState() => _ScanningListScreenState();
}

class _ScanningListScreenState extends State<ScanningListScreen> {
  @override
  void initState() {
    super.initState();
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
          Opacity(
            opacity: 0.6,
            child: Container(
              color: const Color.fromARGB(255, 34, 5, 176),
            ),
          ),

          /// Top Logo Text
          Positioned(
            top: 85,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailQrScanned(data: ""),
                        ),
                      );
                    },
                    child: Image.asset(
                      'images/logo.png',
                      width: 140,
                      height: 140,
                    ),
                  ),
                  Image.asset(
                    'images/NPIT.png',
                    width: 90,
                    height: 90,
                  ),
                ],
              ),
            ),
          ),

          /// Bottom Column: Title Text and Image
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Scan Student QR Code',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                // const SizedBox(height: 0),
                // const Text(
                //   'Travel Experience',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 30,
                //   ),
                // ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Quickly scan a student’s QR code to view their profile and academic information. Ensure the QR code is clear and within the frame for accurate scanning.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// QR Scanner Trigger
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => QRScannerScreen()),
                    // );
                    goTo(context, QRScannerScreen());
                  },
                  child: Image.asset(
                    'images/QR.png',
                    width: 85,
                    height: 85,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Scan QR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
