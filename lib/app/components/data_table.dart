import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TabelaDadosPrecatorio extends StatefulWidget {
  const TabelaDadosPrecatorio({super.key});

  @override
  _TabelaDadosPrecatorioState createState() => _TabelaDadosPrecatorioState();
}

class _TabelaDadosPrecatorioState extends State<TabelaDadosPrecatorio> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _pageIndex = 0;
  late _PrecatorioDataSource _precatorioDataSource;
  int _totalRows = 0;

  @override
  void initState() {
    super.initState();
    _precatorioDataSource = _PrecatorioDataSource([], _totalRows);

    _getTotalPrecatorioCount().then((value) {
      setState(() {
        _totalRows = value;
        _precatorioDataSource = _PrecatorioDataSource([], _totalRows);
      });
    });
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
          _precatorioDataSource =
              _PrecatorioDataSource(precatorioData!, _totalRows);

          return SingleChildScrollView(
            child: PaginatedDataTable(
              header: Text('Dados Precatórios'),
              columns: [
                DataColumn(
                  label: Text('Teste'),
                  onSort: (columnIndex, ascending) {
                    _precatorioDataSource.sort<String>(
                        (d) => d['montante_ano_referencia'].toString(),
                        columnIndex,
                        ascending);
                  },
                ),
                DataColumn(label: Text('Sigla do Tribunal')),
                DataColumn(
                  label: Text('Ano de Referência'),
                  onSort: (columnIndex, ascending) {
                    _precatorioDataSource.sort<String>(
                        (d) => (d['ano_referencia'].toString()),
                        columnIndex,
                        ascending);
                  },
                ),
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
              onPageChanged: (newPageIndex) {},
              rowsPerPage: _rowsPerPage,
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
        .orderBy('ano_referencia')
        .startAfter([pageIndex * pageSize]).get();

    List<Map<String, dynamic>> precatorioData = [];
    querySnapshot.docs.forEach((doc) {
      precatorioData.add(doc.data() as Map<String, dynamic>);
    });
    return precatorioData;
  }

  Future<int> _getTotalPrecatorioCount() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('mapa_precatorios').get();
    return querySnapshot.size;
  }
}

class _PrecatorioDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _precatorioData;
  final _rowCount;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  _PrecatorioDataSource(this._precatorioData, this._rowCount);

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
  int get rowCount => _rowCount;

  @override
  int get selectedRowCount => 0;

  void _sort<T>(Comparable<T> Function(Map<String, dynamic>) getField,
      int columnIndex, bool ascending) {
    _precatorioData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  void sort<T>(Comparable<T> Function(Map<String, dynamic>) getField,
      int columnIndex, bool ascending) {
    if (_sortColumnIndex == columnIndex) {
      _sortAscending = !_sortAscending;
    } else {
      _sortAscending = true;
    }
    _sortColumnIndex = columnIndex;
    _sort(getField, columnIndex, _sortAscending);
  }
}
