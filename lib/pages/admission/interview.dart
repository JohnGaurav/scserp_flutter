import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/custom_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectionInterviewScreen extends StatefulWidget {
  const SelectionInterviewScreen({super.key});

  @override
  State<SelectionInterviewScreen> createState() =>
      _SelectionInterviewScreenState();
}

class _SelectionInterviewScreenState extends State<SelectionInterviewScreen> {
  TextEditingController marksController = TextEditingController();
  List interviewList = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: accentMain,
        title: Text(
          'Selection Interview List',
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
            SizedBox(
              height: 100,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch, // mobile touch
                    PointerDeviceKind.mouse, // enable mouse drag on web/desktop
                  },
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildStatCard(
                      'Data Verification',
                      '200',
                      Icons.check,
                      Colors.green,
                    ),
                    buildStatCard(
                      'English Proficiency',
                      '200',
                      Icons.check,
                      Colors.green,
                    ),
                    buildStatCard(
                      'Dept Interview',
                      '200',
                      Icons.check,
                      Colors.green,
                    ),
                    buildStatCard(
                      'Management Interview',
                      '200',
                      Icons.check,
                      Colors.green,
                    ),
                    buildStatCard(
                      'Document Submission',
                      '200',
                      Icons.check,
                      Colors.green,
                    ),
                    buildStatCard('Selected ', '200', Icons.check, Colors.blue),
                    buildStatCard('Pending ', '200', Icons.check, Colors.pink),
                  ],
                ),
              ),
            ),
            BootstrapRow(
              children: interviewList.map((item) {
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
    String docVerificationStatus,
    String engProfStatus,
    String engTestMarks,
    String deptInterviewStatus,
    String docSubmitStatus,
    String mgtInterviewStatus,
    String docSubmissionStatus,
    String finalStatus,
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
            statusDisplay(id, docVerificationStatus, 'Document Verification'),
            statusDisplay(id, docSubmitStatus, 'Document Submission'),
            statusDisplay(id, engProfStatus, 'English Proficiency Test'),
            statusDisplay(id, deptInterviewStatus, 'Departmental Interview'),
            statusDisplay(id, mgtInterviewStatus, 'Management Interview'),
            statusDisplay(id, finalStatus, 'Final Status'),
            SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                engTestMarks == ''
                    ? ElevatedButton(
                        onPressed: () {
                          showActionDialog(context, id, docVerificationStatus);
                        },
                        child: Text('Enter Test Marks'),
                      )
                    : SizedBox(child: Text('Test Marks - $engTestMarks')),

                ElevatedButton(
                  onPressed: () {},
                  child: Text('Official Action'),
                ),
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
