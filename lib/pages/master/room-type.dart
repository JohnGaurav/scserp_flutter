import 'dart:convert';

import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/custom_widget.dart';
import 'package:admin/globalwidgets/drawer.dart';
import 'package:admin/services/api_cred.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RoomTypeScreen extends StatefulWidget {
  const RoomTypeScreen({super.key});

  @override
  State<RoomTypeScreen> createState() => _RoomTypeScreenState();
}

class _RoomTypeScreenState extends State<RoomTypeScreen> {
  int _rowsPerPage = 10;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  late MyDataSource _source;
  bool _loading = true;
  int? selectedCampus;
  List<dynamic> roomList = [];
  List<dynamic> programList = [];
  String? program;
  String? title;
  int? selectedProgramId;

  Future<void> apiData() async {
    http.Response apiResponse = await http.get(
      Uri.parse("$baseUrl/roomtype-master"),
      headers: requestHeaders,
    );
    final decoded = jsonDecode(apiResponse.body);
    roomList = decoded['data'];

    setState(() {
      _source = MyDataSource(List<Map<String, dynamic>>.from(roomList));
      _loading = false;
    });
  }

  Future<void> addDialog(context) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add New Room Type '),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Name...",
                        labelText: "Room Type Name",
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
                      submit(context); //testing
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

  Future<void> submit(context) async {
    final title = titleController.text.trim();

    var jsonData = jsonEncode({"title": title});

    if (title.isEmpty) {
      myToast('Title is required');
      return;
    }

    Navigator.pop(context);

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/add-roomtype-master"),
        headers: {
          ...requestHeaders,
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonData,
      );

      final apiJson = jsonDecode(response.body);
      myToast('${apiJson['message']}');
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
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Room Type', style: TextStyle(color: Colors.white)),
        backgroundColor: accentMain,
        elevation: 5.0,
      ),
      drawer: CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        tooltip: "Create New",
        onPressed: () {
          addDialog(context);
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
                        sizes: 'col-lg-4 col-sm-6 col-md-6',
                        offsets: "offset-7",
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
                roomList.isEmpty
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
                                DataColumn(label: Text('Room Type')),
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

  MyDataSource(this._allData) {
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
        final title = _normalize(row['title']?.toString() ?? '');
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
