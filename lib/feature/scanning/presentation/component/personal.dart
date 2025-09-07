import 'package:flutter/material.dart';

class PersonalScreen extends StatefulWidget {
  PersonalScreen({super.key, required this.data});
  Map<String, dynamic> data;

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.data);
  }

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
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            const Icon(Icons.deblur),
                            const SizedBox(
                              width: 13,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                  "${widget.data["student_name"]}'s Details",
                                  style: const TextStyle(fontSize: 15.5)),
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
                  Text(
                    "${widget.data["student_name"] ?? "N/A"} (${widget.data["khmer_name"] ?? "N/A"})",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(3.0, 3.0), // Position of the shadow
                          blurRadius: 3.0, // Softness of the shadow
                          color: Color.fromARGB(
                              128, 136, 149, 154), // Shadow color with opacity
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("លេខកូដសិស្ស : "),
                      Text(
                        "${widget.data["student_id"] ?? "N/A"}",
                      )
                    ],
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
                 DisplayField(keys: 'FirstName', values:"${widget.data["first_name"] ?? "N/A"}"),
                 DisplayField(keys: 'LastName', values: "${widget.data["last_name"] ?? "N/A"}"),
                 DisplayField(keys: 'Gender', values:  "${widget.data["gender"] ?? "N/A"}"),
                 DisplayField(
                    keys: 'Date of Birth', values: "${widget.data["student_dob"] ?? "N/A"}"),
                 DisplayField(keys: 'Email', values: "${widget.data["email"] ?? "N/A"}"),
                 DisplayField(keys: 'Phone Number', values: "${widget.data["phone"] ?? "N/A"}"),
                 DisplayField(
                    keys: 'Enrollment Date', values: "${widget.data["enrollment_date"] ?? "N/A"}"),
                 DisplayField(
                    keys: 'Address',
                    values: "${widget.data["address"] ?? "N/A"}"),
                 DisplayField(keys: 'City', values: "${widget.data["city"] ?? "N/A"}"),
                 DisplayField(
                    keys: 'Marital Status', values: "${widget.data["marital_status"] ?? "N/A"}"),
                 DisplayField(
                    keys: 'Department', values: "${widget.data["department"] ?? "N/A"}"),
                 DisplayField(keys: 'major', values: "${widget.data["major"] ?? "N/A"}"),
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

   DisplayField({
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
