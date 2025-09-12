import 'dart:convert';

import 'package:admin/services/api_cred.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:http/http.dart' as http;

class SemesterScreen extends StatefulWidget {
  const SemesterScreen({super.key});

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  int _rowsPerPage = 10;
  final TextEditingController _searchController = TextEditingController();
  late MyDataSource _source;
  bool _loading = true;
  List<dynamic> semesterList = [];

  Future<void> apiData() async {
    http.Response apiResponse = await http.get(
      Uri.parse("$baseUrl/semesters"),
      headers: requestHeaders,
    );
    final decoded = jsonDecode(apiResponse.body);
    semesterList = decoded["data"];

    setState(() {
      _source = MyDataSource(List<Map<String, dynamic>>.from(semesterList));
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    apiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Semesters'), elevation: 5.0),

      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // 🔍 Search box
                BootstrapRow(
                  children: [
                    BootstrapCol(
                      sizes: 'col-lg-6 col-sm-6 col-md-6',
                      offsets: 'offset-8',
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search by title...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            _source.search(value);
                            print(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: PaginatedDataTable2(
                        headingRowColor: WidgetStateProperty.all(
                          Colors.blue.shade200,
                        ),
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 600,
                        rowsPerPage: _rowsPerPage,
                        onRowsPerPageChanged: (r) {
                          if (r != null) setState(() => _rowsPerPage = r);
                        },
                        availableRowsPerPage: const [5, 10, 20, 50, 100],
                        renderEmptyRowsInTheEnd: false,
                        columns: const [
                          DataColumn2(label: Text('#'), size: ColumnSize.L),
                          DataColumn(label: Text('Name')),
                        ],
                        source: _source,
                        sortColumnIndex: 1,
                        sortAscending: true, //custom data source
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class MyDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _allData; // original
  List<Map<String, dynamic>> _filteredData = []; // filtered copy

  MyDataSource(this._allData) {
    _filteredData = List.from(_allData);
  }

  // normalize: lowercase, remove punctuation, trim
  String _normalize(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').trim();

  /// query: user input (space separated keywords)
  /// matchAll: true -> AND (every keyword must be present in title)
  /// false -> OR  (any keyword present)
  ///
  void search(String query, {bool matchAll = false}) {
    final q = _normalize(query);
    if (q.isEmpty) {
      _filteredData = List.from(_allData);
    } else {
      final keywords = q
          .split(RegExp(r'\s+'))
          .where((k) => k.isNotEmpty)
          .toList();

      _filteredData = _allData.where((row) {
        final title = _normalize(row['title']?.toString() ?? '');

        if (matchAll) {
          // AND: title must contain all keywords
          return keywords.every((kw) => title.contains(kw));
        } else {
          // OR: title contains any keyword
          return keywords.any((kw) => title.contains(kw));
        }
      }).toList();
    }
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _filteredData.length) return null;

    final apijson = _filteredData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text((index + 1).toString())), // Serial
        DataCell(Text(apijson['title'].toUpperCase())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _filteredData.length;

  @override
  int get selectedRowCount => 0;
}
