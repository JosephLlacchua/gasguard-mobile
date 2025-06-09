import 'package:flutter/material.dart';
import 'package:gasguard_mobile/utils/app_router.dart';

void main() {
  runApp(const GasGuardApp());
}

class GasGuardApp extends StatelessWidget {
  const GasGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GasGuard',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF0A1A2A),
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      initialRoute: AppRouter.auth,
      routes: AppRouter.getRoutes(),
      onGenerateRoute: AppRouter.generateRoute,
      
      debugShowCheckedModeBanner: false,
    );
  }
}