import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/custom_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectionPhaseTwoScreen extends StatefulWidget {
  const SelectionPhaseTwoScreen({super.key});

  @override
  State<SelectionPhaseTwoScreen> createState() =>
      _SelectionPhaseTwoScreenState();
}

class _SelectionPhaseTwoScreenState extends State<SelectionPhaseTwoScreen> {
  TextEditingController marksController = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();
  List<Map<String, dynamic>> filteredList = [];
  List<Map<String, dynamic>> interviewList = [
    {
      'id': '1',
      'applno': '7611756455180',
      'name': 'john gaurav',
      "pic":
          "https://salesiancollege.s3.ap-southeast-1.wasabisys.com/profile/1756455413_WhatsAppImage2025-08-29at13.45.56.jpeg",
      "campus": "Sonada",
      "program": "UG",
      "department": "History 7:50am - 1:10pm",
      "course": "History & Political Science",
      'docVerificationStatus': '1',
      'engProfStatus': '1',
      'engTestMarks': '',
      'deptInterviewStatus': '0',
      'docSubmitStatus': '0',
      'mgtInterviewStatus': '1',
      'docSubmissionStatus': '0',
      'finalStatus': '0',
    },
    {
      'id': '2',
      'applno': '7611756455181',
      'name': 'jane doe',
      "pic":
          "https://salesiancollege.s3.ap-southeast-1.wasabisys.com/profile/1756455413_WhatsAppImage2025-08-29at13.45.56.jpeg",
      "campus": "Sonada",
      "program": "UG",
      "department": "History 7:50am - 1:10pm",
      "course": "History & Political Science",
      'docVerificationStatus': '1',
      'engProfStatus': '1',
      'engTestMarks': '45',
      'deptInterviewStatus': '0',
      'docSubmitStatus': '1',
      'mgtInterviewStatus': '1',
      'docSubmissionStatus': '0',
      'finalStatus': '0',
    },
    {
      'id': '2',
      'applno': '7611756455181',
      'name': 'willy smith',
      "pic":
          "https://salesiancollege.s3.ap-southeast-1.wasabisys.com/profile/1756455413_WhatsAppImage2025-08-29at13.45.56.jpeg",
      "campus": "Sonada",
      "program": "UG",
      "department": "History 7:50am - 1:10pm",
      "course": "History & Political Science",
      'docVerificationStatus': '1',
      'engProfStatus': '1',
      'engTestMarks': '45',
      'deptInterviewStatus': '0',
      'docSubmitStatus': '1',
      'mgtInterviewStatus': '1',
      'docSubmissionStatus': '0',
      'finalStatus': '0',
    },
  ];

  Future<void> showActionDialog(context, String id, String key) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter English Proficiency Marks'),
          actions: [
            TextField(
              controller: marksController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                submitEnglishMarks();
              },
              child: Text('Confirm and Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> submitEnglishMarks() async {
    if (marksController.text.isNotEmpty || marksController.text != '') {
      // You can handle authentication here
      Fluttertoast.showToast(msg: 'Updated');

      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: 'Cannot Submit Empty Data');
    }
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = List.from(interviewList);
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
      filteredList = interviewList.where((item) {
        // Match if ANY keyword is found in ANY field
        return keywords.any((keyword) {
          return item.values.any(
            (value) => value.toString().toLowerCase().contains(keyword),
          );
        });
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      filteredList = List.from(interviewList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: accentMain,
        title: Text(
          'Selection Phase II List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.message),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: 100,
            //   child: ScrollConfiguration(
            //     behavior: ScrollConfiguration.of(context).copyWith(
            //       dragDevices: {
            //         PointerDeviceKind.touch, // mobile touch
            //         PointerDeviceKind.mouse, // enable mouse drag on web/desktop
            //       },
            //     ),
            //     child: ListView(
            //       scrollDirection: Axis.horizontal,
            //       children: [
            //         buildStatCard(
            //           'Data Verification',
            //           '200',
            //           Icons.check,
            //           Colors.green,
            //         ),
            //         buildStatCard(
            //           'English Proficiency',
            //           '200',
            //           Icons.check,
            //           Colors.green,
            //         ),
            //         buildStatCard(
            //           'Dept Interview',
            //           '200',
            //           Icons.check,
            //           Colors.green,
            //         ),
            //         buildStatCard(
            //           'Management Interview',
            //           '200',
            //           Icons.check,
            //           Colors.green,
            //         ),
            //         buildStatCard(
            //           'Document Submission',
            //           '200',
            //           Icons.check,
            //           Colors.green,
            //         ),
            //         buildStatCard('Selected ', '200', Icons.check, Colors.blue),
            //         buildStatCard('Pending ', '200', Icons.check, Colors.pink),
            //       ],
            //     ),
            //   ),
            // ),
            BootstrapCol(
              sizes: "col-lg-3",
              offsets: "offset-9",
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
            BootstrapRow(
              children: filteredList.map((item) {
                return BootstrapCol(
                  sizes: "col-lg-4 col-md-6 col-sm-12",
                  child: buildInterviewCard(
                    '${item['id']}',
                    '${item['campus']}',
                    '${item['program']}',
                    '${item['course']}',
                    '${item['department']}',
                    '${item['applno']}',
                    '${item['name']}',
                    '${item['pic']}',
                    '${item['docVerificationStatus']}',
                    '${item['engProfStatus']}',
                    '${item['engTestMarks']}',
                    '${item['deptInterviewStatus']}',
                    '${item['docSubmitStatus']}',
                    '${item['mgtInterviewStatus']}',
                    '${item['docSubmissionStatus']}',
                    '${item['finalStatus']}',
                    context,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInterviewCard(
    String id,
    String campus,
    String program,
    String course,
    String dept,
    String applno,
    String name,
    String pic,
    String docSubmit,
    String docValidation,
    String engTestMarks,
    String admissionFeePayment,
    String subjectSelection,
    String uniform,
    String idIssue,
    String contractSign,
    context,
  ) {
    return Card(
      color: Colors.white.withValues(alpha: 0.5),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(50),
                  child: Image.network(
                    pic,
                    width: 80,
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        '$campus - $program'.toUpperCase(),
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        course,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        dept,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/application-single');
                      },
                      child: Text(
                        applno,
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 14,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        name.toUpperCase(),
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            divider(),
            statusDisplay(id, docValidation, 'Document Verification'),
            statusDisplay(id, docSubmit, 'Document Submission'),
            statusDisplay(id, admissionFeePayment, 'Admission Fee Payment'),
            statusDisplay(id, subjectSelection, 'Subject Selection'),
            statusDisplay(id, uniform, 'Uniform Measurment'),
            statusDisplay(id, idIssue, 'IdCard Issued'),
            statusDisplay(id, contractSign, 'Contract Signing'),

            SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                contractSign == '0'
                    ? ElevatedButton(
                        onPressed: () {},
                        child: Text('Enroll Now'),
                      )
                    : SizedBox(child: Text(applno)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget statusDisplay(String id, String status, String title) {
  return Row(
    children: [
      status == '1'
          ? Icon(Icons.check_circle, color: Colors.teal)
          : Icon(Icons.close_rounded, color: Colors.red),
      InkWell(
        onTap: () {
          //change status using Api
        },
        child: FittedBox(
          child: Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}
