import 'package:employee_attendance/screens/home_screen.dart';
import 'package:employee_attendance/screens/login_screen.dart';
import 'package:employee_attendance/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);



    return authService.currentUser == null
        ? const LoginScreen() 
        : const HomeScreen();
  }
}