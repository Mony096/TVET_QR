import 'package:flutter/material.dart';
import 'package:npit_qr/utilities/dialog/dialog.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ), // Example of a leading icon
              onPressed: () {
                MaterialDialog.close(context);
              },
            ),
            centerTitle: true,
            title: const Text(
              "Overview",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add,
                    color: Colors.white), // Example of an icon
                onPressed: () {
                  print("Settings Icon Pressed");
                },
              ),
            ],
            backgroundColor: const Color.fromARGB(
                255, 37, 146, 229), // Customize AppBar color
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StatsCard(
                        title: "Total Students",
                        value: "7,265",
                        percentage: "+11.01%",
                        gradientColors: [Colors.blue, Colors.lightBlueAccent],
                      ),
                      SizedBox(width: 16),
                      StatsCard(
                        title: "Visits : Manager",
                        value: "1.00",
                        percentage: "-0.03%",
                        gradientColors: [Colors.black87, Colors.black54],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StatsCard(
                        title: "New Students",
                        value: "256",
                        percentage: "+15.03%",
                        gradientColors: [Colors.black87, Colors.black54],
                      ),
                      SizedBox(width: 16),
                      StatsCard(
                        title: "Active Students",
                        value: "2,318",
                        percentage: "+6.08%",
                        gradientColors: [Colors.blue, Colors.lightBlueAccent],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 141, 143, 144)
                              .withOpacity(0.25), // Shadow color
                          blurRadius: 10, // How blurry the shadow is
                          offset:
                              const Offset(0, 4), // Offset (x, y) of the shadow
                        ),
                      ],
                      color: const Color.fromARGB(255, 247, 217, 127),
                      borderRadius: BorderRadius.circular(
                          10), // Optional for rounded corners
                    ),
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.list,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Student Listing - 2025",
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String percentage;
  final List<Color> gradientColors;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Text(
            //   percentage,
            //   style: TextStyle(
            //     color: percentage.startsWith('-')
            //         ? Colors.redAccent
            //         : Colors.greenAccent,
            //     fontSize: 14,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
