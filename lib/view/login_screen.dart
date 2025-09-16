import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';
import '../controller/login_controller.dart';
import 'movies_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = LoginController();
  //receber o valor do textFild para o controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController(); 

  late final ReactionDisposer _loginDisposer;


  @override
  //Função para naveagar para a proxima página ou mostrar erros
  void initState() {
    super.initState();
  
    _loginDisposer = autorun((_) {
      if (_controller.loginSuccess) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MoviesScreen()),
        );
      }
      if (_controller.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_controller.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _loginDisposer();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: 
      Observer(
        builder: (_) {

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
                children: [

                  SizedBox(height: 30,),
                  Text('Login', style: GoogleFonts.orbitron().copyWith(fontSize: 26, fontWeight: FontWeight.bold,),),
                  SizedBox(height: 20,), 
                  TextField(
                    controller: _emailController, // vai para essa variável
                    decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(), labelStyle: GoogleFonts.orbitron()),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController, // vai para essa variável
                    decoration: InputDecoration(labelText: 'Senha', border: OutlineInputBorder(), labelStyle: GoogleFonts.orbitron()),
                    obscureText: true, // deixa o texto escuro quando digitar
                  ),
                  const SizedBox(height: 24),
                  _controller.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            _controller.doLogin(
                              _emailController.text,
                              _passwordController.text,
                            );
                          },
                          child: Text('Entrar', style: GoogleFonts.orbitron()),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}