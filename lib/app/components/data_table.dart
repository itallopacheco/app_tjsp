import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TabelaDadosPrecatorio extends StatefulWidget {
  String municipio;
  String entidade;
  String cnpj;
  String anoReferencia;

  TabelaDadosPrecatorio(
      {super.key,
      required this.municipio,
      required this.entidade,
      required this.cnpj,
      required this.anoReferencia});

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
    _precatorioDataSource = _PrecatorioDataSource([]);
  }

  Future<void> _updateData(String municipio, String entidade, String cnpj,
      String anoReferencia) async {
    setState(() {
      widget.municipio = municipio;
      widget.entidade = entidade;
      widget.cnpj = cnpj;
      widget.anoReferencia = anoReferencia;
    });

    List<Map<String, dynamic>> newData = await _getPrecatorioData(
        _rowsPerPage, _pageIndex, municipio, entidade, cnpj, anoReferencia);

    setState(() {
      _precatorioDataSource = _PrecatorioDataSource(newData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getPrecatorioData(_rowsPerPage, _pageIndex, widget.municipio,
          widget.entidade, widget.cnpj, widget.anoReferencia),
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
      int pageSize,
      int pageIndex,
      String municipio,
      String entidade,
      String cnpj,
      String anoReferencia) async {
    Query query = FirebaseFirestore.instance.collection('mapa_precatorios');
    if (municipio.isNotEmpty) {
      query = query.where('cod_mun_devedor', isEqualTo: municipio);
    }
    if (entidade.isNotEmpty) {
      query = query.where('nome_entidade_devedora', isEqualTo: entidade);
    }
    if (cnpj.isNotEmpty) {
      query = query.where('cnpj_entidade_devedora', isEqualTo: cnpj);
    }
    if (anoReferencia.isNotEmpty) {
      query = query.where('ano_referencia', isEqualTo: anoReferencia);
    }

    QuerySnapshot querySnapshot =
        await query.orderBy(FieldPath.documentId).get();

    List<Map<String, dynamic>> precatorioData = [];
    querySnapshot.docs.forEach((doc) {
      precatorioData.add(doc.data() as Map<String, dynamic>);
    });
    return precatorioData;
  }
}

class _PrecatorioDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _precatorioData;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

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
      DataCell(Text(rowData['cod_mun_devedor'].toString())),
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
