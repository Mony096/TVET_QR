import 'package:npit_qr/feature/scanning/presentation/detail_qr_scanned.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatelessWidget {
  bool _hasNavigated = false;

  QRScannerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 67, 68, 69),
        child: Column(
          children: [
            /// Logo at the top
            const SizedBox(height: 100), // Space to position the logo
            Center(
              child: Image.asset(
                'images/NPIT.png', // Replace with your logo image path
                width: 140,
                height: 140,
              ),
            ),
            /// Scanning Camera in the center
            const SizedBox(height: 60), // Space between logo and camera view
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // Optional styling
                border: Border.all(
                    color: Colors.blue, width: 2), // Optional styling
              ),
              padding: const EdgeInsets.all(5),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), // Optional styling
                ),
                child: MobileScanner(
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    final Barcode firstBarcode = barcodes.first;

                    if (!_hasNavigated && firstBarcode.rawValue != null) {
                      _hasNavigated = true; // Prevent further navigation
                      String qrData = firstBarcode.rawValue!;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailQrScanned(data: qrData),
                        ),
                      ).then(
                          (_) => _hasNavigated = false); // Reset flag on return
                    }
                  },
                ),
              ),
            ),

            /// Scanning text at the bottom
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 30), // Adjust the bottom space
              child: Container(
                width: 180,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100), // Optional styling
                  border: Border.all(
                    color: Colors.white, // Optional styling
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'images/QR_icon.svg',
                        color: const Color.fromARGB(255, 28, 104, 235),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'QR Scanning',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 28, 104, 235),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
