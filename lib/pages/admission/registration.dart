import 'dart:convert';

import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/custom_widget.dart';
import 'package:admin/globalwidgets/drawer.dart';
import 'package:admin/services/api_cred.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AdmissionRegistrationScreen extends StatefulWidget {
  const AdmissionRegistrationScreen({super.key});

  @override
  State<AdmissionRegistrationScreen> createState() =>
      _AdmissionRegistrationScreenState();
}

class _AdmissionRegistrationScreenState
    extends State<AdmissionRegistrationScreen> {
  TextEditingController searchCtrl = TextEditingController();
  List<dynamic> registration = [];

  Future<void> apiData() async {
    http.Response apiResponse = await http.get(
      Uri.parse("$baseUrl/registrations"),
      headers: requestHeaders,
    );

    final decoded = jsonDecode(apiResponse.body);
    setState(() {
      registration = decoded["data"];
    });
  }

  String? selectedValue; // stores current selection
  // dropdown options
  final List<String> items = ["2025", "2024", "2023", "2022"];

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
          'Admission Registration',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: CustomDrawer(),
      body: registration.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  BootstrapRow(
                    children: [
                      BootstrapCol(
                        sizes: "col-lg-2",
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
                        sizes: "col-lg-4",
                        offsets: "offset-6",
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey.withValues(alpha: 0.1),
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
                    children: registration.map((item) {
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
                                        '${item['campus_info']['name']} - ${item['program_info']['name']}',
                                        14.0,
                                        FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  titleWidget(
                                    '${item['student_info']['name']}',
                                    16.0,
                                    FontWeight.bold,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.call,
                                        color: Colors.blueAccent,
                                      ),

                                      SizedBox(width: 5.0),
                                      Text(
                                        '+${item['country_info']['phone_code']} ${item['student_info']['phone']}',
                                      ),
                                      '${item['student_info']['otp_verification']}' ==
                                              '1'
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
                                        color: Colors.blueAccent,
                                      ),
                                      SizedBox(width: 5.0),
                                      FittedBox(
                                        child: Text(
                                          '${item['student_info']['email']}',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      Icon(Icons.pin_drop, color: Colors.red),
                                      SizedBox(width: 5.0),
                                      Text('${item['country_info']['name']}'),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      SizedBox(width: 5.0),
                                      Text('Application Filled'),
                                      '${item['application_filled']}' == 'YES'
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.lightGreen,
                                            )
                                          : Icon(
                                              Icons.close,
                                              color: Colors.redAccent,
                                            ),
                                      '${item['application_status']}' == 'Yes'
                                          ? ElevatedButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/application-single',
                                                );
                                              },
                                              child: Text('15456789'),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: item['application_info'] == null
                                          ? Colors.blue.withValues(alpha: 0.5)
                                          : '${item['application_info']['payment_gateway_status']}' ==
                                                'success'
                                          ? Colors.teal.withValues(alpha: 0.5)
                                          : Colors.redAccent.withValues(
                                              alpha: 0.5,
                                            ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                    ),

                                    child: item['application_info'] == null
                                        ? Center(
                                            child: titleWidget(
                                              'NOT FILLED',
                                              14,
                                              FontWeight.bold,
                                            ),
                                          )
                                        : Center(
                                            child:
                                                '${item['application_info']['payment_gateway_status']}' ==
                                                    'success'
                                                ? titleWidget(
                                                    'PAID - ${item['application_info']['payment_gateway_id']}',
                                                    14,
                                                    FontWeight.bold,
                                                  )
                                                : titleWidget(
                                                    'UN-PAID',
                                                    14,
                                                    FontWeight.bold,
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
                ],
              ),
            ),
    );
  }
}
