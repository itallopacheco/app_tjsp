import 'package:app_tjsp/app/components/ui/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navegar para a próxima página após o login bem-sucedido
      Navigator.pushReplacementNamed(context, '/data_table');
    } catch (e) {
      // Lidar com erros de login
      print('Erro de login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6e6e6),
      body: SafeArea(
        child: Column(
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
              style: TextStyle(color: Color(0xff000000), fontSize: 16),
            ),
            const SizedBox(
              height: 25,
            ),
            MyTextField(
              controller: _emailController,
              hintText: 'Login',
              obscureText: false,
            ),
            MyTextField(
              controller: _passwordController,
              hintText: 'Senha',
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
//   @override
//   Widget euild(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Precatorios TJSP'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Senha'),
//               obscureText: true,
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }