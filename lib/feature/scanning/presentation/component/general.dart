import 'package:npit_qr/feature/scanning/presentation/qr_code_scanner_screen.dart';
import 'package:npit_qr/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<dynamic> Subj = [
    {
      "color": "true",
      "subjName": "CCNA3",
      "subjCode": "2024-CCNA3",
      "Name": "Ou Kosal",
      "score": "80.50",
      "grade": "B"
    },
    {
      "color": "false",
      "subjName": "Flutter",
      "subjCode": "2024-Flutter",
      "Name": "Touch Brung",
      "score": "40.50",
      "grade": "F"
    },
    {
      "color": "true",
      "subjName": "Python",
      "subjCode": "2024-Python",
      "Name": "Kor Sang",
      "score": "55.50",
      "grade": "E"
    },
    {
      "color": "false",
      "subjName": "Linux",
      "subjCode": "2024-Linux",
      "Name": "thon Sopheak kdey",
      "score": "99.97",
      "grade": "A"
    },
    {
      "color": "true",
      "subjName": "Adobe XD",
      "subjCode": "2024-XD",
      "Name": "Touch Brung",
      "score": "70.50",
      "grade": "C"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            color: Colors.blue[800],
            width: MediaQuery.of(context).size.width,
            child: const Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 70,
                  left: 30,
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text("Student Information",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.5,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 125,
                  left: 25,
                  right: 25,
                  child: ProfileSection(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 115),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 141, 143, 144)
                      .withOpacity(0.25), // Shadow color
                  blurRadius: 10, // How blurry the shadow is
                  offset: const Offset(0, 4), // Offset (x, y) of the shadow
                ),
              ],
              color: const Color.fromARGB(255, 247, 217, 127),
              borderRadius:
                  BorderRadius.circular(10), // Optional for rounded corners
            ),
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(25, 3, 25, 15),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ឆមាសទី 2 - រយៈពេលព្រឹត្តិការណ៍ 2014/2025",
                  style: TextStyle(fontSize: 13),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 25,
                )
              ],
            ),
          ),
          const ScheduleSection(),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 0, 3),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    child: const Row(
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          color: Color.fromARGB(255, 113, 114, 115),
                          size: 23,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            "មុខវិទ្យា / ឈ្មោះ",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                    flex: 1,
                    child: Text("ពិន្ទុ", style: TextStyle(fontSize: 13))),
                const Expanded(
                    flex: 1,
                    child: Text("ចំណាត់ថ្នាក់", style: TextStyle(fontSize: 13)))
              ],
            ),
          ),

          const Divider(
            color: Color.fromARGB(255, 188, 190, 190), // Line color
            thickness: 0.7, // Line thickness
            indent: 25, // Left margin
            endIndent: 25, // Right margin
          ),
          const SizedBox(
            height: 5,
          ),
          ...Subj.map((e) => SubjectDetailBox(e)),
          const SizedBox(
            height: 30,
          ),
          // const NotificationCard(),
          // const SizedBox(height: 10),
          // const ScheduleSection(),
        ],
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 229, 239, 252),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Stack(
        children: [
          // Background image with opacity
          Positioned.fill(
            top: 30,
            child: Opacity(
              opacity: 0.3, // Set the desired opacity here (50%)
              child: Align(
                alignment: Alignment.centerRight, // Align the logo to the right
                child: Image.asset(
                  "images/logo.png", // Replace with your logo image path
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Foreground content
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("images/profile.jpg"),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  const Text("Reaksmey Kunmony (រស្មី គន្ទមុន្នី)",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "2025-PPA32143",
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ខេត្តកណ្ដាល, ក្រុងតាខ្មៅ, ភូមិព្រែកឫស្សី",
                    style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 110.0),
                child: Container(
                    child: const Icon(Icons.qr_code, color: Colors.blue)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScheduleSection extends StatelessWidget {
  const ScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: ScheduleCard("មុខវិទ្យា​ សរុប", "12")),
              SizedBox(width: 10),
              Expanded(child: ScheduleCard("ចំណាត់ថ្នាក់", "D")),
              SizedBox(width: 10),
              Expanded(child: ScheduleCard("ពិន្ទុ សរុប", "200.55")),
            ],
          ),
        ],
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String title, qty;
  const ScheduleCard(this.title, this.qty, {super.key});
  Color getGradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.amber;
      case 'D':
        return Colors.orange;
      case 'E':
        return const Color.fromARGB(255, 126, 78, 6);
      case 'F':
        return Colors.red;
      default:
        return Colors.grey; // fallback for unknown grades
    }
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              textAlign: TextAlign.center,
              title,
              style: const TextStyle(
                  fontSize: 13, color: Color.fromARGB(255, 129, 129, 131))),
          const SizedBox(
            height: 7,
          ),
          Text(
            qty,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isNumeric(qty) ? Colors.grey : getGradeColor(qty),
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectDetailBox extends StatelessWidget {
  final dynamic e;
  const SubjectDetailBox(this.e, {super.key});
  Color getGradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.amber;
      case 'D':
        return Colors.orange;
      case 'E':
        return const Color.fromARGB(255, 126, 78, 6);
      case 'F':
        return Colors.red;
      default:
        return Colors.grey; // fallback for unknown grades
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      height: 90,
      decoration: BoxDecoration(
        color: e["color"] == "true"
            ? const Color.fromARGB(255, 236, 245, 250)
            : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 8, 0, 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Row(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 75,
                                child: Text(
                                  "មុខវិទ្យា",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                              ),
                              Text(
                                " : ",
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            ],
                          ),
                          Text(
                            e["subjName"],
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 75,
                                child: Text(
                                  "លេខកូដ",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                              ),
                              Text(
                                " : ",
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            ],
                          ),
                          Text(
                            e["subjCode"],
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 75,
                                child: Text(
                                  "ឈ្មោះ",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                              ),
                              Text(
                                " : ",
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            ],
                          ),
                          Text(
                            e["Name"],
                            style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Expanded(
              flex: 1,
              child: Text(
                e["score"],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // ✅ dynamic grade-based color
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  e["grade"],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color:
                        getGradeColor(e["grade"]), // ✅ dynamic grade-based color
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
