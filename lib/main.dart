import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/colors.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const AdstacksDashboardApp());
}

class AdstacksDashboardApp extends StatelessWidget {
  const AdstacksDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adstacks Media — Office Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffold,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.brandPurple,
          primary: AppColors.brandPurple,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      home: const DashboardScreen(),
    );
  }
}
