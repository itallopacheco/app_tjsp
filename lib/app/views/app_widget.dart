import 'package:app_tjsp/app/views/data_table_view.dart';
import 'package:app_tjsp/app/views/login_page.dart';
import 'package:flutter/material.dart';

/// O widget principal que define a estrutura do aplicativo.
class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transparência TJSP',
      debugShowCheckedModeBanner: false,
      initialRoute: '/data_table', // Define the initial route
      routes: {
        '/': (context) => LoginPage(),
        '/data_table': (context) => HomePage(
              onFilterSubmitted: (String municipio, String entidade,
                  String cnpj, String anoReferencia) {},
            ),
      },
    );
  }
}
