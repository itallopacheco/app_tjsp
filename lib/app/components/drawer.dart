import 'package:flutter/material.dart';

/// Widget que representa o menu lateral (drawer) do aplicativo.
class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          /// Opção 1: Filtrar Precatórios
          ListTile(
            title: const Text('Filtrar Precatórios'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/data_table');
            },
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

          /// Opção 4: Precatórios por ano
          ListTile(
            title: const Text('Precatórios por ano'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/precatorios-ano');
            },
          ),
        ],
      ),
    );
  }
}
