import 'package:app_tjsp/app/components/switch_login_register.dart';
import 'package:app_tjsp/app/views/data_table_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Serve para monitorar caso o usuário já esteja logado
// e controlar o fluxo dependendo da resposta
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return HomePage(
              onFilterSubmitted: (
                String municipio,
                String entidade,
                String cnpj,
                String anoReferencia,
              ) {},
            );
          }

          // user is noy logged in
          else {
            return const SwitchLoginRegister();
          }
        },
      ),
    );
  }
}
