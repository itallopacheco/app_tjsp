import 'package:app_tjsp/app/components/data_table.dart';
import 'package:app_tjsp/app/components/drawer.dart';
import 'package:flutter/material.dart';

typedef void FilterCallback(
    String municipio, String entidade, String cnpj, String anoReferencia);

/// Página inicial do aplicativo, exibindo a transparência do TJSP.
class HomePage extends StatefulWidget {
  final FilterCallback onFilterSubmitted;
  const HomePage({super.key, required this.onFilterSubmitted});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

/// Estado da página inicial.
class HomePageState extends State<HomePage> {
  late TabelaDadosPrecatorio tabelaDadosPrecatorio;
  TextEditingController municipioController = TextEditingController();
  TextEditingController entidadeController = TextEditingController();
  TextEditingController cnpjController = TextEditingController();
  TextEditingController anoReferenciaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabelaDadosPrecatorio = TabelaDadosPrecatorio(
        municipio: municipioController.text,
        entidade: entidadeController.text,
        cnpj: cnpjController.text,
        anoReferencia: anoReferenciaController.text);
  }

  void _submitFilters() {
    String municipio = municipioController.text;
    String entidade = entidadeController.text;
    String cnpj = cnpjController.text;
    String anoReferencia = anoReferenciaController.text;
    setState(() {
      tabelaDadosPrecatorio = TabelaDadosPrecatorio(
          municipio: municipio,
          entidade: entidade,
          cnpj: cnpj,
          anoReferencia: anoReferencia);
    });
    widget.onFilterSubmitted(municipio, entidade, cnpj, anoReferencia);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe6e6e6),
      appBar: AppBar(
        title: const Text('Transparência TJSP'),
        actions: [],
        backgroundColor: const Color(0xffe6e6e6),
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: _buildFilterExpansionTile(),
              ),
              SizedBox(
                  height:
                      8), // Adiciona um espaço entre o ExpansionTile e a tabela de dados
              tabelaDadosPrecatorio, // Sem o Expanded
            ],
          ),
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
        _buildFilterTextField('Municipio Devedor', municipioController),
        _buildFilterTextField('Entidade Devedora', entidadeController),
        _buildFilterTextField('CNPJ', cnpjController),
        _buildFilterTextField('Ano de Referência', anoReferenciaController),
        _buildSubmitButton(),
      ],
    );
  }

  /// Constrói um campo de texto para um filtro específico.
  Widget _buildFilterTextField(
      String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
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
        _submitFilters();
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
