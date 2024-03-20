import 'package:app_tjsp/app/components/data_table.dart';
import 'package:app_tjsp/app/components/drawer.dart';
import 'package:flutter/material.dart';

/// Página inicial do aplicativo, exibindo a transparência do TJSP.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

/// Estado da página inicial.
class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transparência TJSP'),
        actions: [],
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: _buildFilterExpansionTile(),
            ),
            Expanded(
              child: TabelaDadosPrecatorio(),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }

  /// Constrói o componente de expansão de filtro.
  Widget _buildFilterExpansionTile() {
    return ExpansionTile(
      title: const Row(
        children: [
          Icon(Icons.filter_list),
          SizedBox(width: 8),
          Text('Filtros'),
        ],
      ),
      children: [
        _buildFilterTextField('Municipio Devedor'),
        _buildFilterTextField('Entidade Devedora'),
        _buildFilterTextField('CNPJ'),
        _buildFilterTextField('Ano de Referência'),
        _buildSubmitButton(),
      ],
    );
  }

  /// Constrói um campo de texto para um filtro específico.
  Widget _buildFilterTextField(String labelText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }

  /// Constrói um botão para submeter os filtros.
  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        // TODO: Lógica para submeter os filtros
      },
      child: const Row(
        children: [
          Icon(Icons.search),
          SizedBox(width: 8),
          Text('Filtrar'),
        ],
      ),
    );
  }
}
