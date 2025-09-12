import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedValue; // stores current selection
  List availableSearchList = [];
  TextEditingController keyword = TextEditingController();
  // dropdown options
  final List<String> items = ["2025", "2024", "2023", "2022"];
  List<Map<String, dynamic>> paymentList = [
    {
      'id': 1,
      'application_id': "1234567890",
      'payment_date': '24-08-2025',
      'payment_id': 'EZ1245780',
      'name': 'john wick',
      'phone': '8100556241',
      'msg': 'APPROVED OR COMPLETED SUCCESSFULLY',
      'status': 'success',
    },
    {
      'id': 2,
      'application_id': "1234567840",
      'payment_date': '25-08-2025',
      'payment_id': 'EZ1245710',
      'name': 'jane wick',
      'phone': '8100556241',
      'msg': 'APPROVED OR COMPLETED SUCCESSFULLY',
      'status': 'failed',
    },
  ];

  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = List.from(paymentList); // Initially show all
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = List.from(paymentList);
      });
      return;
    }

    setState(() {
      filteredList = paymentList.where((payment) {
        return payment.values.any(
          (value) =>
              value.toString().toLowerCase().contains(query.toLowerCase()),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: accentMain,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Admission Fee Payment',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Handle notification tap
                },
              ),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: const Text(
                    '3', // notification count
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BootstrapRow(
              children: [
                BootstrapCol(
                  sizes: "col-lg-2",
                  offsets: "offset-7",
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
                  sizes: "col-lg-3",

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BootstrapRow(
                children: filteredList.map((item) {
                  return BootstrapCol(
                    sizes: "col-lg-3 col-sm-12 col-mb-6",
                    child: Card(
                      elevation: 5.0,
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(15.0),
                        child: Container(
                          height: 250,
                          color: '${item['status']}' == 'success'
                              ? Colors.green.withValues(alpha: 0.3)
                              : Colors.redAccent.withValues(alpha: 0.3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  titleWidget(
                                    '# ${item['payment_id']}',
                                    14.0,
                                    FontWeight.bold,
                                  ),
                                  titleWidget(
                                    '${item['payment_date']}',
                                    12.0,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                              titleWidget(
                                'Application# ${item['application_id']}',
                                14.0,
                                FontWeight.bold,
                              ),

                              titleWidget(
                                '${item['name']}'.toUpperCase(),
                                12.0,
                                FontWeight.normal,
                              ),
                              titleWidget(
                                'Phone ${item['phone']}',
                                12.0,
                                FontWeight.normal,
                              ),
                              titleWidget(
                                '${item['msg']}',
                                12.0,
                                FontWeight.normal,
                              ),
                              titleWidget(
                                'Status - ${item['status']}',
                                14.0,
                                FontWeight.normal,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        Colors.deepPurple,
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.code,
                                      color: Colors.white,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        Colors.white,
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.download,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
