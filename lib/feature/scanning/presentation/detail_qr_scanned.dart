import 'package:npit_qr/feature/monthly_attendent/monthly_attendent.dart';
import 'package:npit_qr/feature/scanning/presentation/component/general.dart';
import 'package:flutter/material.dart';
import 'package:npit_qr/feature/scanning/presentation/component/personal.dart';
import 'package:npit_qr/utilities/dialog/dialog.dart';
import 'package:npit_qr/utilities/dio_client.dart';

class DetailQrScanned extends StatefulWidget {
  final String data;
  const DetailQrScanned({super.key, required this.data});

  @override
  _DetailQrScannedState createState() => _DetailQrScannedState();
}

class _DetailQrScannedState extends State<DetailQrScanned> {
  bool isLoading = true;
  int _selectedIndex = 0; // Tracks the selected tab
  late PageController _pageController; // Page controller for body content
  final DioClient dio = DioClient(); // Your custom Dio client
  final Map<String, dynamic> data = {};
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
      print(widget.data.split("/").last);
    });
    _pageController = PageController(); // Initialize the PageController
    super.initState();
  }

  // Function to handle tab change
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _init() async {
    // --- Show loading dialog ---
    MaterialDialog.loading(context);

    try {
      // --- Fetch equipment ---
      final response = await dio.get("/${widget.data.split("/").last}");

      if (response.statusCode == 200) {
        if (!mounted) return;

        setState(() {
          data.addAll(response.data);
        });

        // ✅ Close loading after success
        if (Navigator.of(context, rootNavigator: true).canPop()) {
          MaterialDialog.close(context);
        }
      } else {
        // ❌ Non-200 response
        if (Navigator.of(context, rootNavigator: true).canPop()) {
          MaterialDialog.close(context);
        }
        MaterialDialog.warning(
          context,
          title: 'Error',
          body: 'Unexpected status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print("Error fetching documents: $e");

      // ✅ Close loading before showing error
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        MaterialDialog.close(context);
      }
      MaterialDialog.warning(
        context,
        title: 'Error',
        body: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          GeneralScreen(data: data), // Replace with your General Screen widget
          AttendanceScreen(data: data),
          PersonalScreen(
              data: data), // Replace with your Customer Screen widget
        ],
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 69, 78, 92).withOpacity(0.25),
                blurRadius: 25,
                offset: const Offset(0, 5),
              ),
            ],
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          height: 60,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 4, 4, 4),
                child: ElevatedButton(
                  onPressed: () => _onTabTapped(0), // Change to General tab
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.home,
                          size: 24,
                          color: _selectedIndex == 0
                              ? Colors.blue
                              : Colors.grey), // Highlight if selected
                      const SizedBox(height: 4),
                      Text(
                        "General",
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              _selectedIndex == 0 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                child: ElevatedButton(
                  onPressed: () => _onTabTapped(1), // Change to General tab
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.assignment,
                          size: 24,
                          color: _selectedIndex == 1
                              ? Colors.blue
                              : Colors.grey), // Highlight if selected
                      const SizedBox(height: 4),
                      Text(
                        "Attendance",
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              _selectedIndex == 1 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 25, 4),
                child: ElevatedButton(
                  onPressed: () => _onTabTapped(2), // Change to General tab
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person,
                          size: 24,
                          color: _selectedIndex == 2
                              ? Colors.blue
                              : Colors.grey), // Highlight if selected
                      const SizedBox(height: 4),
                      Text(
                        "Personal",
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              _selectedIndex == 2 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )

          //  Stack(
          //   clipBehavior: Clip.none,
          //   children: [
          //     // General Tab Button
          //     Positioned(
          //       top: 0,
          //       left: 0,
          //       bottom: 0,
          //       child: Center(
          //         child: SizedBox(
          //           width: 150,
          //           child:
          // Padding(
          //             padding: const EdgeInsets.fromLTRB(4, 4, 25, 4),
          //             child: ElevatedButton(
          //               onPressed: () => _onTabTapped(0), // Change to General tab
          //               style: ElevatedButton.styleFrom(
          //                 elevation: 0,
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(10),
          //                 ),
          //                 backgroundColor:
          //                     const Color.fromARGB(255, 255, 255, 255),
          //               ),
          //               child: Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Icon(Icons.home,
          //                       size: 24,
          //                       color: _selectedIndex == 0
          //                           ? Colors.blue
          //                           : Colors.grey), // Highlight if selected
          //                   const SizedBox(height: 4),
          //                   Text(
          //                     "General",
          //                     style: TextStyle(
          //                       fontSize: 13,
          //                       color: _selectedIndex == 0
          //                           ? Colors.blue
          //                           : Colors.grey,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Positioned(
          //       top: 0,
          //       left: 140,
          //       bottom: 0,
          //       child: Center(
          //         child: SizedBox(
          //           width: 150,
          //           child: Padding(
          //             padding: const EdgeInsets.fromLTRB(4, 4, 25, 4),
          //             child: ElevatedButton(
          //               onPressed: () => _onTabTapped(1), // Change to General tab
          //               style: ElevatedButton.styleFrom(
          //                 elevation: 0,
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(10),
          //                 ),
          //                 backgroundColor:
          //                     const Color.fromARGB(255, 255, 255, 255),
          //               ),
          //               child: Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Text(""),
          //                   // Icon(Icons.assignment,
          //                   //     size: 24,
          //                   //     color: _selectedIndex == 1
          //                   //         ? Colors.blue
          //                   //         : Colors.grey), // Highlight if selected
          //                   const SizedBox(height: 4),
          //                   Text(
          //                     "Attendance",
          //                     style: TextStyle(
          //                       fontSize: 13,
          //                       color: _selectedIndex == 1
          //                           ? Colors.blue
          //                           : Colors.grey,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     // Personal Tab Button
          //     Positioned(
          //       top: 0,
          //       right: 0,
          //       bottom: 0,
          //       child: Center(
          //         child: SizedBox(
          //           width: 150,
          //           child: Padding(
          //             padding: const EdgeInsets.fromLTRB(25, 4, 4, 4),
          //             child: ElevatedButton(
          //               onPressed: () =>
          //                   _onTabTapped(2), // Change to Personal tab
          //               style: ElevatedButton.styleFrom(
          //                 elevation: 0,
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(10),
          //                 ),
          //                 backgroundColor:
          //                     const Color.fromARGB(255, 255, 255, 255),
          //               ),
          //               child: Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Icon(Icons.person,
          //                       size: 24,
          //                       color: _selectedIndex == 2
          //                           ? Colors.blue
          //                           : Colors.grey), // Highlight if selected
          //                   const SizedBox(height: 4),
          //                   Text(
          //                     "Personal",
          //                     style: TextStyle(
          //                       fontSize: 13,
          //                       color: _selectedIndex == 2
          //                           ? Colors.blue
          //                           : Colors.grey,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     // Center Logo Button
          //     Positioned(
          //       top: -40,
          //       left: 0,
          //       right: 0,
          //       child: Center(
          //         child: Container(
          //           width: 68,
          //           height: 68,
          //           decoration: BoxDecoration(
          //             boxShadow: [
          //               BoxShadow(
          //                 color: const Color.fromARGB(255, 141, 143, 144)
          //                     .withOpacity(0.25),
          //                 blurRadius: 10,
          //                 offset: const Offset(0, 4),
          //               ),
          //             ],
          //             color: const Color.fromARGB(255, 255, 255, 255),
          //             borderRadius: BorderRadius.circular(50),
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.all(9.0),
          //             child: Image.asset(
          //               'images/logo.png',
          //               width: 40,
          //               height: 40,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
