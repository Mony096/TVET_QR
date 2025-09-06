import 'package:npit_qr/feature/scanning/presentation/scanning_screen.dart';
import 'package:npit_qr/optionScreen.dart';
import 'package:npit_qr/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:npit_qr/feature/dashboard/dashboard_screen.dart';
import 'package:npit_qr/middleware/presentation/bloc/authorization_bloc.dart';
import 'package:npit_qr/middleware/presentation/login_screen.dart';
import 'constant/style.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool showSplashScreen = true; // To control the SplashScreen visibility
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _startSplashTimer();
  }

  void _startSplashTimer() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        showSplashScreen = false; // Hide SplashScreen after 5 seconds
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (showSplashScreen) {
    //   return SplashScreen(); // Show the SplashScreen
    // }

    return BlocListener<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {
        // if (state is UnAuthorization) {
        //   _navigatorKey.currentState?.pushReplacement(
        //     MaterialPageRoute(builder: (context) => const LoginScreen()),
        //   );
        // } else if (state is AuthorizationSuccess) {
        //   _navigatorKey.currentState?.pushReplacement(
        //     MaterialPageRoute(builder: (context) => const DashboardScreen()),
        //   );
        // }
      },
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: PRIMARY_COLOR,
            onPrimary: Colors.white,
          ),
        ),
        title: 'Flutter Layout Demo',
        home: showSplashScreen
            ? const SplashScreen()
            : BlocBuilder<AuthorizationBloc, AuthorizationState>(
                builder: (context, state) {
                  return const ScanningListScreen();
                  // if (state is AuthorizationSuccess) {
                  //   return const DashboardScreen();
                  // } else {
                  //   return const OptionScreen();
                  // }
                },
              ),
      ),
    );
  }
}
