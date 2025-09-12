import 'dart:convert';

import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/custom_widget.dart';
import 'package:admin/services/api_cred.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DeaneryScreen extends StatefulWidget {
  const DeaneryScreen({super.key});

  @override
  State<DeaneryScreen> createState() => _DeaneryScreenState();
}

class _DeaneryScreenState extends State<DeaneryScreen> {
  int _rowsPerPage = 10;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  late MyDataSource _source;
  bool _loading = true;
  int? selectedCampus;
  List<dynamic> deaneryList = [];
  List<dynamic> programList = [];
  String? program;
  String? title;

  Future<void> apiData() async {
    if (selectedCampus == null) {
      http.Response apiResponse = await http.get(
        Uri.parse("$baseUrl/deanery"),
        headers: requestHeaders,
      );
      final decoded = jsonDecode(apiResponse.body);
      deaneryList = decoded['data']["deanery"];
      programList = decoded['data']["programs"];
    } else {
      final uri = Uri.parse(
        "$baseUrl/deanery",
      ).replace(queryParameters: {"campus": selectedCampus.toString()});

      http.Response apiResponse = await http.get(uri, headers: requestHeaders);
      final decoded = jsonDecode(apiResponse.body);
      deaneryList = decoded['data']["deanery"];
      programList = decoded['data']["programs"];
    }

    setState(() {
      _source = MyDataSource(List<Map<String, dynamic>>.from(deaneryList));
      _loading = false;
    });
  }

  Future<void> addDeaneryDialog(context) async {
    int? selectedProgramId;
    return showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add New Deanery '),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    DropdownButton<int>(
                      isExpanded: true,
                      hint: Text("Select a Program"),
                      value: selectedProgramId,
                      items: programList.map((prog) {
                        return DropdownMenuItem<int>(
                          value: prog["id"] as int, // set id as value
                          child: Text(
                            prog['campus']["name"] + ' - ' + prog["name"],
                          ), // display name
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProgramId = value;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Name...",
                        labelText: "Deanery Name",
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 3,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      submit(selectedProgramId, context); //testing
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> submit(programId, context) async {
    title = titleController.text;
    program = programId.toString();
    if (title == '') {
      myToast('title is required');
      return;
    } else {
      Navigator.pop(context);
      try {
        final response = await http.post(
          Uri.parse("$baseUrl/add-deanery"),
          headers: requestHeaders,
          body: {"title": title, "program": program},
        );

        final apiJson = jsonDecode(response.body);
        myToast('${apiJson['msg']}');
        apiData();
      } catch (e) {
        Fluttertoast.showToast(msg: "Something went wrong: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    apiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deanery', style: TextStyle(color: Colors.white)),
        backgroundColor: accentMain,
        elevation: 5.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        tooltip: "Create new deanery",
        onPressed: () {
          addDeaneryDialog(context);
        },
        child: Icon(Icons.add),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // 🔍 Search box
                BootstrapRow(
                  children: [
                    BootstrapCol(
                      sizes: "col-lg-2",
                      child: DropdownButton<int>(
                        isExpanded: true,
                        hint: Text("Select Campus"),
                        value: selectedCampus,
                        items: [
                          DropdownMenuItem(value: null, child: Text("All")),
                          DropdownMenuItem(value: 1, child: Text("Sonada")),
                          DropdownMenuItem(value: 2, child: Text("Siliguri")),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedCampus = value;
                              _loading = true;
                            });
                            apiData(); // reload both deanery + program
                          } else {
                            setState(() {
                              selectedCampus = null;
                              _loading = true;
                              apiData();
                            });
                          }
                        },
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-lg-4 col-sm-6 col-md-6',
                      offsets: "offset-5",
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
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                deaneryList.isEmpty
                    ? Center(
                        child: Text(
                          'No Data Found',
                          style: TextStyle(fontSize: 22.0),
                        ),
                      )
                    : Expanded(
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
                                DataColumn2(
                                  label: Text('#'),
                                  size: ColumnSize.L,
                                ),
                                DataColumn2(
                                  label: Text('Campus - Program'),
                                  size: ColumnSize.L,
                                ),

                                DataColumn(label: Text('Deanery Name')),
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
        DataCell(
          Text(
            apijson['program']['campus']['name'] +
                ' - ' +
                apijson['program']['name'].toUpperCase(),
          ),
        ),

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
