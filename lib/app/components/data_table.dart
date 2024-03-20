import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TabelaDadosPrecatorio extends StatefulWidget {
  @override
  _TabelaDadosPrecatorioState createState() => _TabelaDadosPrecatorioState();
}

class _TabelaDadosPrecatorioState extends State<TabelaDadosPrecatorio> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _pageIndex = 0;
  late _PrecatorioDataSource _precatorioDataSource;

  @override
  void initState() {
    super.initState();
    _precatorioDataSource = _PrecatorioDataSource([]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getPrecatorioData(_rowsPerPage, _pageIndex),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>>? precatorioData = snapshot.data;
          _precatorioDataSource = _PrecatorioDataSource(precatorioData!);

          return SingleChildScrollView(
            child: PaginatedDataTable(
              header: Text('Dados Precatórios'),
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Sigla do Tribunal')),
                DataColumn(label: Text('Ano de Referência')),
                DataColumn(label: Text('Esfera do Federado Devedor')),
                DataColumn(label: Text('Sigla do Estado')),
                DataColumn(label: Text('Cód. Município Devedor')),
                DataColumn(label: Text('Regime de Pagamento')),
                DataColumn(label: Text('Tipo de Entidade Devedora')),
                DataColumn(label: Text('CNPJ da Entidade Devedora')),
                DataColumn(label: Text('Nome da Entidade Devedora')),
                DataColumn(label: Text('Valor expedido até ano anterior')),
                DataColumn(label: Text('Montante pago no ano de referência')),
                DataColumn(label: Text('Saldo devedor após pagamento')),
                DataColumn(
                    label: Text(
                        'Montante de Precatórios expedidos no ano de referência')),
              ],
              source: _precatorioDataSource,
              onPageChanged: (newPageIndex) {
                _fetchNextPage(newPageIndex);
              },
              rowsPerPage: _rowsPerPage,
              availableRowsPerPage: [5, 10, 20],
              onRowsPerPageChanged: (newRowsPerPage) {
                setState(() {
                  _rowsPerPage = newRowsPerPage!;
                });
              },
            ),
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> _getPrecatorioData(
      int pageSize, int pageIndex) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('mapa_precatorios')
        .orderBy('sigla_estado')
        .limit(pageSize * 2)
        .startAfter([_pageIndex]).get();

    List<Map<String, dynamic>> precatorioData = [];
    querySnapshot.docs.forEach((doc) {
      precatorioData.add(doc.data() as Map<String, dynamic>);
    });

    return precatorioData;
  }

  void _fetchNextPage(int newPageIndex) async {
    setState(() {
      _pageIndex += newPageIndex;
    });

    List<Map<String, dynamic>>? precatorioData =
        await _getPrecatorioData(_rowsPerPage, _pageIndex);

    setState(() {
      _precatorioDataSource = _PrecatorioDataSource(precatorioData);
    });
  }
}

class _PrecatorioDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _precatorioData;

  _PrecatorioDataSource(this._precatorioData);

  @override
  DataRow getRow(int index) {
    final rowData = _precatorioData[index];
    return DataRow(cells: [
      DataCell(Text(rowData['montante_ano_referencia'].toString())),
      DataCell(Text(rowData['sigla_tribunal'].toString())),
      DataCell(Text(rowData['ano_referencia'].toString())),
      DataCell(Text(rowData['esfera_federado_devedor'].toString())),
      DataCell(Text(rowData['sigla_estado'].toString())),
      DataCell(Text(rowData['cod_municipio_devedor'].toString())),
      DataCell(Text(rowData['regime_pagamento'].toString())),
      DataCell(Text(rowData['tipo_entidade_devedora'].toString())),
      DataCell(Text(rowData['cnpj_entidade_devedora'].toString())),
      DataCell(Text(rowData['nome_entidade_devedora'].toString())),
      DataCell(Text(rowData['montante_ano_anterior'].toString())),
      DataCell(Text(rowData['montante_pago_ano_referencia'].toString())),
      DataCell(Text(rowData['saldo_devedor_pos_pag'].toString())),
      DataCell(Text(rowData['montante_ano_referencia'].toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _precatorioData.length;

  @override
  int get selectedRowCount => 0;
}
