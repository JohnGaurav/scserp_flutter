import 'dart:convert';

import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/custom_widget.dart';
import 'package:admin/globalwidgets/drawer.dart';
import 'package:admin/services/api_cred.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class PGApplicationScreen extends StatefulWidget {
  const PGApplicationScreen({super.key});

  @override
  State<PGApplicationScreen> createState() => _PGApplicationScreenState();
}

class _PGApplicationScreenState extends State<PGApplicationScreen> {
  TextEditingController searchCtrl = TextEditingController();
  List<dynamic> filteredList = [];
  List<dynamic> applicationList = [];
  String? selectedValue; // stores current selection
  int currentPage = 1;
  int lastPage = 1;
  bool isLoading = false;
  // dropdown options
  final List<String> items = ["2025", "2024", "2023", "2022"];
  String? selectedDept; // stores current selection
  List<Map<String, dynamic>> departments = [
    {"id": 1, 'name': "Bcom 7:00am"},
    {"id": 2, 'name': "Music 7:50am"},
    {"id": 3, 'name': "BBA 8:50am"},
    {"id": 4, 'name': "English 7:10am"},
  ];

  List availableSearchList = [];

  Future<void> _openImage(String imageUrl) async {
    final Uri url = Uri.parse(imageUrl);

    // On web, this will open in a new browser tab
    if (!await launchUrl(
      url,
      mode: LaunchMode
          .externalApplication, // Opens in new tab (web) / external (mobile)
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = List.from(applicationList);
      });
      return;
    }

    // Split the query into multiple keywords
    List<String> keywords = query
        .toLowerCase()
        .split(" ")
        .where((k) => k.isNotEmpty)
        .toList();

    setState(() {
      filteredList = applicationList.where((item) {
        // Match if ANY keyword is found in ANY field
        return keywords.any((keyword) {
          return item.values.any(
            (value) => value.toString().toLowerCase().contains(keyword),
          );
        });
      }).toList();
    });
  }

  Future<void> sendMessage() async {
    if (selectedDept!.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Select a Department',
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(msg: 'Message Send to Applicants');
      Navigator.pop(context);
    }
  }

  Future<void> showMessageDialog(context) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        int? selectedDepartmentId; // to store selected ID
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Bulk Messaging'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Send Phase 1 Interview Message to Applicants'),
                    SizedBox(height: 10.0),
                    DropdownButton<int>(
                      isExpanded: true,
                      hint: Text("Select Department"),
                      value: selectedDepartmentId,
                      items: departments.map((dept) {
                        return DropdownMenuItem<int>(
                          value: dept["id"] as int, // set id as value
                          child: Text(dept["name"]), // display name
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDepartmentId = value;
                        });

                        print(
                          "Selected Department ID: $selectedDepartmentId",
                        ); //testing
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _controller,
                      readOnly: true, // prevent manual typing
                      decoration: InputDecoration(
                        labelText: "Select Date & Time",
                        suffixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      onTap: () => _selectDateTime(context),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: ElevatedButton(
                    child: Text('Send'),
                    onPressed: () {
                      sendMessage();
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

  final TextEditingController _controller = TextEditingController();
  // Select Date
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Select Time
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Format DateTime (you can use intl for custom formats)
        final String formatted =
            "${fullDateTime.year}-${fullDateTime.month.toString().padLeft(2, '0')}-${fullDateTime.day.toString().padLeft(2, '0')} "
            "${fullDateTime.hour.toString().padLeft(2, '0')}:${fullDateTime.minute.toString().padLeft(2, '0')}";

        setState(() {
          _controller.text = formatted;
        });
      }
    }
  }

  Future<void> apiData({int page = 1, bool append = false}) async {
    if (isLoading) return;
    setState(() => isLoading = true);

    http.Response apiResponse = await http.get(
      Uri.parse("$baseUrl/pg-applications?page=$page"),
      headers: requestHeaders,
    );

    final decoded = jsonDecode(apiResponse.body);

    setState(() {
      currentPage = decoded["current_page"];
      lastPage = decoded["last_page"];

      if (append) {
        applicationList.addAll(decoded["data"]);
      } else {
        applicationList = decoded["data"];
      }

      filteredList = List.from(applicationList);
      isLoading = false;
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
      appBar: AppBar(
        backgroundColor: accentMain,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'PG Applications'.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMessageDialog(context);
        },
        child: Icon(Icons.message),
      ),
      body: filteredList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    currentPage < lastPage) {
                  apiData(page: currentPage + 1, append: true);
                }
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BootstrapRow(
                      children: [
                        BootstrapCol(
                          sizes: "col-lg-2 col-sm-6",
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              icon: Center(
                                child: Icon(Icons.settings, color: Colors.teal),
                              ),

                              elevation: 8,
                              hint: Text("Change Session"),
                              value: selectedValue,
                              items: items.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                  print(selectedValue);
                                });
                              },
                            ),
                          ),
                        ),
                        BootstrapCol(
                          sizes: "col-lg-3 col-sm-6",
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (value) {
                                filterSearchResults(value);
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.grey.withValues(alpha: 0.2),
                                filled: true,
                                labelText: "Search ...",
                                prefixIcon: const Icon(Icons.numbers),
                                border: InputBorder.none, //
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    BootstrapRow(
                      children: filteredList.map((item) {
                        return BootstrapCol(
                          sizes: 'col-lg-3 col-sm-12 col-md-6',
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Material(
                              elevation: 5.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),

                                  border: BoxBorder.all(
                                    color: Colors.white10,
                                    width: 3.0,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FittedBox(
                                          child: titleWidget(
                                            DateFormat.yMMMd()
                                            // displaying formatted date
                                            .format(
                                              DateTime.parse(
                                                '${item['created_at']}',
                                              ),
                                            ),
                                            10.0,
                                            FontWeight.normal,
                                          ),
                                        ),
                                        titleWidget(
                                          '${item['registration']['campus_info']['name']} - ${item['registration']['program_info']['name']}',
                                          14.0,
                                          FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(
                                                MediaQuery.of(
                                                  context,
                                                ).size.height,
                                              ),
                                          child: Image.network(
                                            '${item['pic_url']}',
                                            height: 140,
                                            width: 140,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    _openImage(
                                                      '${item['adhaar_url']}',
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    color: Colors.deepPurple,
                                                    child: Icon(
                                                      Icons.fingerprint,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    _openImage(
                                                      '${item['certificate_x']}',
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    color: Colors.deepPurple,
                                                    child: Center(
                                                      child: Text(
                                                        'X',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => _openImage(
                                                    '${item['certificate_xii']}',
                                                  ),
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    color: Colors.deepPurple,
                                                    child: Center(
                                                      child: Text(
                                                        'XII',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    titleWidget(
                                      '${item['name']}',
                                      16.0,
                                      FontWeight.bold,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: Colors.deepPurple,
                                        ),

                                        SizedBox(width: 5.0),
                                        Text('${item['phone']}'),
                                        '${item['otp_status']}' == '1'
                                            ? Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                              )
                                            : Icon(
                                                Icons.close,
                                                color: Colors.redAccent,
                                              ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.mail,
                                          color: Colors.deepPurple,
                                        ),
                                        SizedBox(width: 5.0),
                                        FittedBox(
                                          child: Text('${item['email']}'),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10.0),
                                    titleWidget(
                                      '${item['course']['name']}',
                                      12,
                                      FontWeight.bold,
                                    ),

                                    titleWidget(
                                      '${item['dept']['name']}',
                                      12,
                                      FontWeight.bold,
                                    ),
                                    Divider(
                                      height:
                                          20, // Height of the divider line (including space around it)
                                      thickness:
                                          2, // Thickness of the actual line
                                      indent: 20, // Start indent from the left
                                      endIndent:
                                          20, // End indent from the right
                                      color: Colors
                                          .deepPurple, // Color of the divider line
                                    ),
                                    item['payment_gateway_id'] == null
                                        ? SizedBox(height: 30)
                                        : Row(
                                            children: [
                                              Icon(
                                                Icons.payment,
                                                color: Colors.teal,
                                              ),
                                              SizedBox(width: 5.0),
                                              Text(
                                                '${item['payment_gateway_id']}',
                                              ),
                                              SizedBox(width: 5.0),
                                              IconButton.filled(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all(
                                                        Colors.orange
                                                            .withValues(
                                                              alpha: 0.8,
                                                            ),
                                                      ), // fill color
                                                ),

                                                onPressed: () {},
                                                icon: Icon(Icons.download),
                                              ),
                                            ],
                                          ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: Colors.teal,
                                        ),
                                        SizedBox(width: 5.0),
                                        FittedBox(
                                          child: titleWidget(
                                            DateFormat.yMMMd()
                                            // displaying formatted date
                                            .format(
                                              DateTime.parse(
                                                '${item['updated_at']}',
                                              ),
                                            ),
                                            12.0,
                                            FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Icon(
                                          Symbols.currency_rupee_circle,
                                          color: Colors.teal,
                                        ),
                                        SizedBox(width: 5.0),
                                        item['payment_gateway_status'] == null
                                            ? Text('')
                                            : Text(
                                                '${item['payment_gateway_status']}',
                                              ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            '${item['registration']['application_filled']}' ==
                                                'YES'
                                            ? Colors.teal.withValues(alpha: 0.5)
                                            : Colors.redAccent.withValues(
                                                alpha: 0.5,
                                              ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                      ),

                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/application-single',
                                            arguments: {
                                              'id': item['id'],
                                              'application_id':
                                                  item['application_id'],
                                            },
                                          );
                                        },
                                        child: Center(
                                          child: titleWidget(
                                            '${item['application_id']}',
                                            14,
                                            FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    // 2. Add loading indicator at bottom when fetching next page
                    if (isLoading && currentPage < lastPage)
                      BootstrapCol(
                        sizes: 'col-12',
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
