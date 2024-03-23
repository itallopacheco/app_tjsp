import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Widget que representa o menu lateral (drawer) do aplicativo.
class MyDrawer extends StatelessWidget {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffe6e6e6),
      child: ListView(
        children: [
          /// Opção 1: Filtrar Precatórios
          ListTile(
            title: const Text(
              'Filtrar Precatórios',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/data_table');
            },
          ),
          const Divider(
            thickness: 2.5,
            height: 1,
            color: Color(0xffe7c87b),
          ),

          /// Opção 2: Link para TJSP

          // ListTile(
          //   title: const Row(
          //     children: [
          //       Text('TJSP'),
          //       Icon(Icons.link),
          //       SizedBox(width: 8),
          //     ],
          //   ),
          //   onTap: () async {
          //     var tjsp_url = Uri(
          //       scheme: 'https',
          //       host: 'www.tjsp.jus.br',
          //       path: '/',
          //     );

          //     if (await canLaunchUrl(tjsp_url)) {
          //       await launchUrl(tjsp_url);
          //     } else {
          //       throw 'Could not launch $tjsp_url';
          //     }
          //   },
          // ),

          /// Opção 3: Dúvidas Frequentes
          ListTile(
            title: const Text('Dúvidas Frequentes'),
            onTap: () {
              // TODO: Lógica para ação da opção 3
            },
          ),
          const Divider(
            thickness: 2.5,
            height: 1,
            color: Color(0xffe7c87b),
          ),

          /// Opção 4: Precatórios por ano
          ListTile(
            title: const Text('Precatórios por ano'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/precatorios-ano');
            },
          ),
          const Divider(
            thickness: 2.5,
            height: 1,
            color: Color(0xffe7c87b),
          ),
          ListTile(
            title: const Text(
              'Deslogar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: logout,
            tileColor: Color(0xffce1518),
          ),
        ],
      ),
    );
  }
}
