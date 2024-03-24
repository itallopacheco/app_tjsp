import 'package:app_tjsp/app/components/ui/my_buttom.dart';
import 'package:app_tjsp/app/components/ui/my_textfield.dart';
import 'package:app_tjsp/app/components/ui/my_tile.dart';
import 'package:app_tjsp/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final Function()? switchTap;
  const LoginPage({super.key, required this.switchTap});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      // Lidar com erros de login
      if (e.code == 'invalid-email') {
        wrongMsg('Email incorreto');
      } else if (e.code == 'invalid-credential') {
        wrongMsg('Senha incorreta');
      } else {
        wrongMsg('Ops ... Algo deu errado');
      }
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
              const SizedBox(
                height: 15,
              ),
              MyButton(
                onTap: _login,
                text: 'Entrar',
              ),
              const SizedBox(
                height: 35,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2.5,
                        color: Color(0xffe7c87b),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(
                        "Ou entre com",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2.5,
                        color: Color(0xffe7c87b),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  My_Tile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imageURL:
                          'https://lh3.googleusercontent.com/COxitqgJr1sJnIDe8-jiKhxDx1FrYbtRHKJ9z_hELisAlapwE9LUPh6fcXIfb5vwpbMl4xl9H9TRFPc5NOO8Sb3VSgIBrfRYvW6cUA')
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Não possui conta?',
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.switchTap,
                    child: const Text(
                      'Inscreva-se agora!',
                      style: TextStyle(
                        color: Color(0xffce1518),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
