import 'package:flutter/material.dart';
import 'package:flutter_application_filmes/view/login_screen.dart';
import 'package:flutter_application_filmes/view/movies_screen.dart';
import 'services/auth_service.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final authService = AuthService();
  final bool isLoggedIn = await authService.isUserLoggedIn();
  
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB Filmes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: isLoggedIn ? const MoviesScreen() : const LoginScreen(),
    );
  }
}