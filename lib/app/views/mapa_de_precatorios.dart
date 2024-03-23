import 'package:app_tjsp/app/components/drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';

/// Página que exibe o Mapa Anual de Precatórios.
class MapaPrecatoriosPage extends StatefulWidget {
  @override
  State<MapaPrecatoriosPage> createState() {
    return MapaPrecatoriosPageState();
  }
}

/// Estado da página do Mapa Anual de Precatórios.
class MapaPrecatoriosPageState extends State<MapaPrecatoriosPage> {
  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref().child('precatorios').listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa Anual de Precatórios'),
        actions: [],
      ),
      body: FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];

                return ListTile(
                    title: Text(file.name),
                    trailing: IconButton(
                      icon: Icon(Icons.download),
                      onPressed: () => downloadFile(file),
                    ));
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Erro ao tentar buscar os arquivos"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      drawer: MyDrawer(),
    );
  }

  Future<void> downloadFile(Reference ref) async {
    final url = await ref.getDownloadURL();

    String? downloadsDirectoryPath =
        (await DownloadsPath.downloadsDirectory())?.path;

    final filePath = '${downloadsDirectoryPath}/${ref.name}';
    print(filePath);
    await Dio().download(url, filePath);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Arquivo ${ref.name} baixado com sucesso!'),
      ),
    );
  }
}

/// Método privado que constrói o botão de submissão de filtros.
Widget _buildSubmitButton() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton.icon(
      onPressed: () {
        // TODO: Lógica para processar os filtros
      },
      icon: Icon(Icons.search),
      label: Text('Filtrar'),
    ),
  );
}

/// Widget que representa um dropdown para seleção de ano.
class YearDropdown extends StatefulWidget {
  @override
  _YearDropdownState createState() => _YearDropdownState();
}

/// Estado do dropdown de seleção de ano.
class _YearDropdownState extends State<YearDropdown> {
  int selectedYear = DateTime.now().year; // Definindo um valor padrão

  @override
  Widget build(BuildContext context) {
    List<int> years = List.generate(5, (index) => DateTime.now().year - index);

    return DropdownButton<int>(
      value: selectedYear,
      onChanged: (int? year) {
        setState(() {
          selectedYear = year!;
        });
      },
      items: years.map<DropdownMenuItem<int>>((int year) {
        return DropdownMenuItem<int>(
          value: year,
          child: Text('$year'),
        );
      }).toList(),
    );
  }
}
