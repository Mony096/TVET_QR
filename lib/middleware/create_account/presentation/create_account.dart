import 'package:npit_qr/component/button.dart';
import 'package:npit_qr/constant/api.dart';
import 'package:npit_qr/feature/dashboard/dashboard_screen.dart';
import 'package:npit_qr/helper/helper.dart';
import 'package:npit_qr/middleware/create_account/domain/entity/create_account_entity.dart';
import 'package:npit_qr/middleware/domain/entity/login_entity.dart';
import 'package:npit_qr/middleware/presentation/bloc/authorization_bloc.dart';
import 'package:npit_qr/middleware/presentation/login_screen.dart';
import 'package:npit_qr/utilities/dialog/dialog.dart';
import 'package:npit_qr/utilities/storage/locale_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key, this.fromLogout});
  final dynamic fromLogout;

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _email = TextEditingController(text: "manager@gmail.com");
  final _username = TextEditingController(text: "manager");
  final _password = TextEditingController(text: "Manager@123");
  final _confirmPassword = TextEditingController(text: "Manager@123");

  late bool _obscureText = true;

  Future<void> _postData() async {
    try {
      if (mounted) {
        final db = await LocalStorageManger.getString('companyDB');
        // final host = await LocalStorageManger.getString('host');
        // final port = await LocalStorageManger.getString('port');

        // // Check if the configuration is valid
        // if (db.isEmpty || host.isEmpty || port.isEmpty) {
        //   MaterialDialog.success(context,
        //       title: 'Failed', body: "Invalid Configuration");
        //   return;
        // }

        // Proceed with login request
        final createAccountEntity = CreateAccountEntity(
          email: _email.text,
          username: _username.text,
          password: _password.text,
          confirmPassword: _confirmPassword.text,
          db: db,
        );

        // Trigger login event through Bloc
        // BlocProvider.of<AuthorizationBloc>(context).add(
        //   RequestLoginOnlineEvent(entity: createAccountEntity),
        // );
      }
    } catch (e) {
      print(e);
      MaterialDialog.success(context,
          title: 'Error', body: "An unexpected error occurred.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.png'), // Path to your image
              fit: BoxFit.cover, // Adjust how the image fits into the container
            ),
          ),
          child: BlocConsumer<AuthorizationBloc, AuthorizationState>(
            listener: (context, state) {
              if (state is RequestLoginFailedState) {
                MaterialDialog.success(
                  context,
                  title: 'Failed',
                  body: state.message,
                );
              }
              // if (state is AuthorizationSuccess) {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const DashboardScreen(),
              //     ),
              //   );
              // }
            },
            builder: (context, state) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title

                    Image.asset(
                      'images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // const SizedBox(height: 50), // Space between Title and boxes

                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
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
                        const Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color.fromARGB(255, 28, 104, 235)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          controller: _username,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // Set border color to gray
                                width:
                                    1.0, // Optional: Adjust the border thickness
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // Gray border when enabled
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // Gray border when focused
                                width: 1.0,
                              ),
                            ),
                            hintText: 'Enter Name',
                            isDense: true, // Reduces the vertical space
                            contentPadding: EdgeInsets.symmetric(
                              vertical:
                                  12.0, // Adjusts the height of the input field
                              horizontal:
                                  12.0, // Adjusts horizontal padding inside the field
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          controller: _email,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // Set border color to gray
                                width:
                                    1.0, // Optional: Adjust the border thickness
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // Gray border when enabled
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // Gray border when focused
                                width: 1.0,
                              ),
                            ),
                            hintText: 'Enter Email',
                            isDense: true, // Reduces the vertical space
                            contentPadding: EdgeInsets.symmetric(
                              vertical:
                                  12.0, // Adjusts the height of the input field
                              horizontal:
                                  12.0, // Adjusts horizontal padding inside the field
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          obscureText: _obscureText,
                          controller: _password,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // Set border color to gray
                                width: 1.0, // Optional: Border thickness
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // Gray border when enabled
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // Gray border when focused
                                width: 1.0,
                              ),
                            ),
                            hintText: 'Enter Password',
                            isDense: true, // Makes the TextField smaller
                            contentPadding: const EdgeInsets.symmetric(
                              vertical:
                                  8.0, // Adjust the height of the input field
                              horizontal:
                                  12.0, // Adjust horizontal padding inside the field
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextField(
                          obscureText: _obscureText,
                          controller: _confirmPassword,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // Set border color to gray
                                width: 1.0, // Optional: Border thickness
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // Gray border when enabled
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey, // Gray border when focused
                                width: 1.0,
                              ),
                            ),
                            hintText: 'Enter Confirm Password',
                            isDense: true, // Makes the TextField smaller
                            contentPadding: const EdgeInsets.symmetric(
                              vertical:
                                  8.0, // Adjust the height of the input field
                              horizontal:
                                  12.0, // Adjust horizontal padding inside the field
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Button(
                          heigth: 45.00,
                          bgColor: const Color.fromARGB(255, 28, 104, 235),
                          variant: ButtonVariant.ghost,
                          loading: false,
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          onPressed: () => {},
                        ),
                      ]),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Have a account ?",
                      style: TextStyle(
                          fontSize: 14, color: Color.fromARGB(255, 11, 11, 11)),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        MaterialDialog.close(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color.fromARGB(255, 28, 104, 235)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
