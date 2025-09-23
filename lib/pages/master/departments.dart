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

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({super.key});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  int _rowsPerPage = 10;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  late MyDataSource _source;
  bool _loading = true;
  int? selectedCampus;
  List<dynamic> tableDataList = [];
  String? program;
  String? title;
  int? selectedProgramId;

  Future<void> apiData() async {
    http.Response apiResponse = await http.get(
      Uri.parse("$baseUrl/departments"),
      headers: requestHeaders,
    );
    final decoded = jsonDecode(apiResponse.body);

    tableDataList = decoded['data']['departments'];

    setState(() {
      _source = MyDataSource(
        List<Map<String, dynamic>>.from(tableDataList),
        onRowTap: (row) {
          Navigator.pushNamed(
            context,
            '/view-department',
            arguments: {
              'deptname': row['name'],
              'subject_id': row['coresubject']['id'],
            },
          );
        },
      );
      _loading = false;
    });
  }

  Future<void> addDeaneryDialog(context) async {
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
                      items: tableDataList.map((prog) {
                        return DropdownMenuItem<int>(
                          value: (prog["id"]),
                          // set id as value
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
                  width: MediaQuery.of(context).size.width / 8,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red),
                    ),
                    child: Text('Close', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 6,
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
    final title = titleController.text.trim();

    var jsonData = jsonEncode({
      "program_id": programId.toString(),
      "title": title,
    });

    if (title.isEmpty) {
      myToast('Title is required');
      return;
    }

    Navigator.pop(context);

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/add-deanery"),
        headers: {
          ...requestHeaders,
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonData,
      );

      final apiJson = jsonDecode(response.body);
      myToast('${apiJson['msg']}');
      apiData();
    } catch (e) {
      sendErrorLog('$e');
    }
  }

  Future<void> sendErrorLog(String errors) async {
    var jsonData = jsonEncode({"detail": errors});

    await http.post(
      Uri.parse("$baseUrl/errorlog"),
      headers: {
        ...requestHeaders,
        "Content-Type": "application/json", // 👈 force JSON
        "Accept": "application/json",
      },
      body: jsonData,
    );
    Fluttertoast.showToast(msg: "Error has been Logged and Sent to Tech Team");
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
        title: Text('Department List', style: TextStyle(color: Colors.white)),
        backgroundColor: accentMain,
        elevation: 5.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        tooltip: "Create New",
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BootstrapRow(
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
                ),
                tableDataList.isEmpty
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
                                  size: ColumnSize.S,
                                ),
                                DataColumn(label: Text('Campus|Program')),
                                DataColumn(label: Text('Department Name')),
                                DataColumn(label: Text('Core Subject')),
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
  final List<Map<String, dynamic>> _allData;
  List<Map<String, dynamic>> _filteredData = [];
  final void Function(Map<String, dynamic>) onRowTap; // 👈 callback added

  MyDataSource(this._allData, {required this.onRowTap}) {
    _filteredData = List.from(_allData);
  }

  String _normalize(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').trim();

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
        final title = _normalize(row['name']?.toString() ?? '');
        return matchAll
            ? keywords.every((kw) => title.contains(kw))
            : keywords.any((kw) => title.contains(kw));
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
        DataCell(Text((index + 1).toString())),
        DataCell(
          Text(
            '${apijson['campus']['name']} - ${apijson['program']['name']}'
                .toUpperCase(),
          ),
        ),
        DataCell(
          InkWell(
            onTap: () => onRowTap(apijson), // 👈 use the callback
            child: Text(
              apijson['name'].toUpperCase(),
              style: TextStyle(color: Colors.deepPurple),
            ),
          ),
        ),
        DataCell(
          apijson['coresubject'] != null
              ? Text(
                  apijson['coresubject']['title'].toUpperCase(),
                  style: TextStyle(color: Colors.teal),
                )
              : ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.redAccent),
                  ),
                  child: Text(
                    'Link Subject',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        ),
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
