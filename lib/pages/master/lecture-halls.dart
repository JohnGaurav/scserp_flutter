import 'dart:convert';

import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/custom_widget.dart';
import 'package:admin/globalwidgets/drawer.dart';
import 'package:admin/services/api_cred.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LectureHallScreen extends StatefulWidget {
  const LectureHallScreen({super.key});

  @override
  State<LectureHallScreen> createState() => _LectureHallScreenState();
}

class _LectureHallScreenState extends State<LectureHallScreen> {
  int _rowsPerPage = 10;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  late MyDataSource _source;
  bool _loading = true;
  List<dynamic> lecturehalls = [];
  List<dynamic> acblocks = [];
  List<dynamic> roomtypes = [];
  int? selectedBlockId, selectedRoomTypeId;

  Future<void> apiData() async {
    http.Response apiResponse = await http.get(
      Uri.parse("$baseUrl/lecturehalls"),
      headers: requestHeaders,
    );
    final decoded = jsonDecode(apiResponse.body);
    lecturehalls = decoded['data']["halldata"];
    acblocks = decoded['data']["acblocks"];
    roomtypes = decoded['data']["roomtypes"];

    setState(() {
      _source = MyDataSource(List<Map<String, dynamic>>.from(lecturehalls));
      _loading = false;
    });
  }

  Future<void> addNewDialog(context) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add New'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    DropdownButton<int>(
                      isExpanded: true,
                      hint: Text("Select Academic Block"),
                      value: selectedBlockId,
                      items: acblocks.map((block) {
                        return DropdownMenuItem<int>(
                          value: (block["id"]),
                          // set id as value
                          child: Text(block['title']), // display name
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedBlockId = value;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    DropdownButton<int>(
                      isExpanded: true,
                      hint: Text("Select Room Type"),
                      value: selectedRoomTypeId,
                      items: roomtypes.map((room) {
                        return DropdownMenuItem<int>(
                          value: (room["id"]),
                          // set id as value
                          child: Text(room['title']), // display name
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRoomTypeId = value;
                        });
                      },
                    ),

                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Name...",
                        labelText: "Lecture Hall Name",
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
                      submit(
                        selectedBlockId,
                        selectedRoomTypeId,
                        context,
                      ); //testing
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

  Future<void> submit(acblockId, roomTypeId, context) async {
    final title = titleController.text.trim();

    var postBody = jsonEncode({
      "acblock_id": acblockId,
      "roomtype_id": roomTypeId,
      "title": title,
    });

    if (title.isEmpty) {
      myToast('Title is required');
      return;
    }

    Navigator.pop(context);

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/add-lecture-hall"),
        headers: {
          ...requestHeaders,
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: postBody,
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
        title: Text(
          'Lecture Halls Master',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: accentMain,
        elevation: 5.0,
      ),
      drawer: CustomDrawer(),

      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        tooltip: "Create New",
        onPressed: () {
          addNewDialog(context);
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
                lecturehalls.isEmpty
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
                                DataColumn(label: Text('Academic Block')),
                                DataColumn(label: Text('Lecture Hall Name')),
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
  // 👈 callback added

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
        DataCell(Text(' ${apijson['acblockmaster']['title'].toUpperCase()}')),
        DataCell(Text(apijson['title'].toUpperCase())),
        DataCell(Text(' ${apijson['roomtypemaster']['title'].toUpperCase()}')),
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
