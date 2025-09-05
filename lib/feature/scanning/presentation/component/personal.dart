import 'package:flutter/material.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0),
            height: 320,
            decoration: const BoxDecoration(
              // color: Color.fromARGB(255, 221, 232, 244),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 132, 195, 246),
                  Color.fromARGB(255, 202, 215, 229),
                  Color.fromARGB(255, 229, 214, 154)
                ],
                begin: Alignment.topLeft, // Starting point of the gradient
                end: Alignment.bottomRight, // Ending point of the gradient
              ),
              // image: DecorationImage(
              //   image: AssetImage(
              //       'imagess/logo.png'), // Replace with your image path
              //   fit: BoxFit.contain, // Fills the container with the image
              // ),
            ),
            child: Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     Icon(Icons.deblur),
                  //     SizedBox(
                  //       width: 13,
                  //     ),
                  //     Text("Mony's Details", style: TextStyle(fontSize: 15.5)),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.deblur),
                            SizedBox(
                              width: 13,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.0),
                              child: Text("Kunmony's Details",
                                  style: TextStyle(fontSize: 15.5)),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.menu_book,
                          color: Color.fromARGB(255, 46, 46, 46),
                          size: 23,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 164, 167, 167), // Line color
                    thickness: 0.7, // Line thickness
                    indent: 15, // Left margin
                    endIndent: 15, // Right margin
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("images/profile.jpg"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Reaksmey Kunmony (រស្មី គន្ទមុន្នី)",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(3.0, 3.0), // Position of the shadow
                          blurRadius: 3.0, // Softness of the shadow
                          color: Color.fromARGB(128, 136, 149, 154), // Shadow color with opacity
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("លេខកូដសិស្ស : "), Text("2025-PPA32143")],
                  )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(13),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 69, 78, 92).withOpacity(0.25),
                  blurRadius: 25,
                  offset: const Offset(0, 5),
                ),
              ],
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: const Row(
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: Color.fromARGB(255, 76, 131, 241),
                          size: 19,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Personal Information",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    )),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 126, 127, 129),
                      size: 25,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  color: Color.fromARGB(255, 188, 190, 190), // Line color
                  thickness: 0.7, // Line thickness
                  indent: 0, // Left margin
                  endIndent: 0, // Right margin
                ),
                const DisplayField(keys: 'FirstName', values: "Reaksmey"),
                const DisplayField(keys: 'LastName', values: "Kunmony"),
                const DisplayField(keys: 'Gender', values: "Male"),
                const DisplayField(
                    keys: 'Date of Birth', values: "2-March-1900"),
                const DisplayField(keys: 'Email', values: "mony096@gmail.com"),
                const DisplayField(keys: 'Phone Number', values: "098 787 733"),
                const DisplayField(
                    keys: 'Enrollment Date', values: "2-March-2025"),
                const DisplayField(
                    keys: 'Address',
                    values: "Prek Ruusey, Takhamo, Kandal, Cambodia"),
                const DisplayField(keys: 'City', values: "Takhmao"),
                const DisplayField(
                    keys: 'Marital Status', values: "Mean Songsa "),
                const DisplayField(
                    keys: 'Department', values: "Information of Technology"),
                const DisplayField(keys: 'major', values: "Testing"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DisplayField extends StatelessWidget {
  final String keys;
  final dynamic values;

  const DisplayField({
    super.key,
    required this.keys,
    this.values,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Aligns multiline text properly
            children: [
              SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      keys,
                      style: const TextStyle(
                        fontSize: 14,
                        height:
                            50 / 25, // Set lineHeight proportional to font size
                        color: Color.fromARGB(255, 128, 128, 130),
                      ),
                    ),
                    const Text(" : "),
                  ],
                ),
              ),
              Flexible(
                // Ensures the text wraps within available space
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    values.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      height:
                          50 / 25, // Set lineHeight proportional to font size
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    softWrap: true, // Enables wrapping
                    overflow: TextOverflow.visible, // Shows overflowing text
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
