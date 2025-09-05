import 'dart:io';

import 'package:npit_qr/core/disble_ssl.dart';
import 'package:npit_qr/injector.dart';
import 'package:npit_qr/main_screen.dart';
import 'package:npit_qr/middleware/presentation/bloc/authorization_bloc.dart';
import 'package:npit_qr/select/brand_select/presentation/cubit/brand_cubit.dart';
import 'package:npit_qr/select/business_partner/presentation/cubit/business_partner_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart'; // 👈 Add this import

void main() async {
  // Ensures Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = DisableSSL();
  container();
    await initializeDateFormatting('km', null); 
  //  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthorizationBloc>()),
        BlocProvider(create: (_) => getIt<BrandCubit>()),
        BlocProvider(create: (_) => getIt<BusinessPartnerCubit>()),
      ],
      child: const MainScreen(),
    );
  }
}
