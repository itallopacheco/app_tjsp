import 'package:app_tjsp/app/components/auth_page.dart';
import 'package:app_tjsp/app/views/data_table_view.dart';
import 'package:app_tjsp/app/views/login_page.dart';
import 'package:app_tjsp/app/views/mapa_de_precatorios.dart';
import 'package:flutter/material.dart';

/// O widget principal que define a estrutura do aplicativo.
class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transparência TJSP',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Define the initial route
      routes: {
        '/login': (context) => const AuthPage(),
        '/data_table': (context) => HomePage(
              onFilterSubmitted: (
                String municipio,
                String entidade,
                String cnpj,
                String anoReferencia,
              ) {},
            ),
        '/precatorios-ano': (context) => MapaPrecatoriosPage(),
      },
    );
  }
}
