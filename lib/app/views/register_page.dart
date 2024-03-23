import 'package:app_tjsp/app/components/ui/my_buttom.dart';
import 'package:app_tjsp/app/components/ui/my_textfield.dart';
import 'package:app_tjsp/app/components/ui/my_tile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final Function()? switchTap;
  const RegisterPage({super.key, required this.switchTap});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  Future<void> _register() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String passwordConfirm = _passwordConfirmController.text.trim();

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordConfirm == password) {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      // Lidar com erros de cadastro
      else {
        wrongMsg('As senhas devem ser iguais');
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      wrongMsg('Ops ... Algo deu errado $e');
    }
  }

  void wrongMsg(String mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              mensagem,
              style: const TextStyle(color: Color(0xffe6e6e6)),
            ),
          ),
          backgroundColor: const Color(0xffce1518),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe6e6e6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              Container(
                width: 1000,
                height: 150,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(15), // Adjust the radius as needed
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.network(
                    'https://i.imgur.com/IN6Xk3a.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text(
                'Precatorios TJSP',
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  'Digite abaixo suas informações para criar sua conta',
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                controller: _emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              MyTextField(
                controller: _passwordController,
                hintText: 'Senha',
                obscureText: true,
              ),
              MyTextField(
                controller: _passwordConfirmController,
                hintText: 'Confirme sua Senha',
                obscureText: true,
              ),
              const SizedBox(
                height: 15,
              ),
              MyButton(
                onTap: _register,
                text: 'Registrar-se',
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Já possui uma conta?',
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.switchTap,
                    child: const Text(
                      'Faça seu login agora!',
                      style: TextStyle(
                        color: Color(0xffce1518),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
