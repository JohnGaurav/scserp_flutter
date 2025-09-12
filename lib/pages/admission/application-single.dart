import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:material_symbols_icons/symbols.dart';

class ApplicationSingleScreen extends StatefulWidget {
  const ApplicationSingleScreen({super.key});

  @override
  State<ApplicationSingleScreen> createState() =>
      _ApplicationSingleScreenState();
}

class _ApplicationSingleScreenState extends State<ApplicationSingleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Form - 1245678911'),
        backgroundColor: accentSecondary,
        elevation: 5.0,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.download))],
      ),
      body: SingleChildScrollView(
        child: BootstrapRow(
          children: [
            BootstrapCol(
              sizes: "col-lg-12",
              child: SizedBox(
                child: Image.asset('images/scslogo.png', height: 130),
              ),
            ),

            BootstrapCol(
              sizes: "col-lg-2",
              child: Container(
                color: Colors.black12,
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://salesiancollege.s3.ap-southeast-1.wasabisys.com/profile/1756455413_WhatsAppImage2025-08-29at13.45.56.jpeg',
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
            BootstrapCol(
              sizes: "col-lg-8",
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        titleWidget('29-08-2025', 14.0, FontWeight.bold),
                        SizedBox(width: 20),
                        titleWidget('#123456789', 14.0, FontWeight.bold),
                      ],
                    ),

                    titleWidget(
                      'Siliguri Campus UG  - Geography ',
                      16.0,
                      FontWeight.bold,
                    ),

                    titleWidget(
                      'Geography 750am - 1:10pm',
                      16.0,
                      FontWeight.normal,
                    ),

                    titleWidget(
                      'Jane Doe'.toUpperCase(),
                      16.0,
                      FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Symbols.cake, color: Colors.teal),
                        titleWidget(' 03-01-2000', 16.0, FontWeight.normal),
                        Icon(Symbols.wc, color: Colors.teal),
                        titleWidget('Female', 16.0, FontWeight.normal),
                        Icon(Symbols.bloodtype, color: Colors.teal),
                        titleWidget(' A+', 16.0, FontWeight.normal),
                        Icon(Symbols.phone, color: Colors.teal),
                        titleWidget(' 8981702535', 16.0, FontWeight.normal),
                        Icon(Symbols.mail, color: Colors.teal),
                        titleWidget(
                          'Email- jane@gmail.com',
                          16.0,
                          FontWeight.normal,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Symbols.location_chip, color: Colors.teal),
                        titleWidget('India', 16.0, FontWeight.normal),
                        Icon(Symbols.folded_hands, color: Colors.teal),
                        titleWidget('Christianity', 16.0, FontWeight.normal),
                        Icon(Symbols.language, color: Colors.teal),
                        titleWidget('Hindi', 16.0, FontWeight.normal),
                        Icon(Symbols.wheelchair_pickup, color: Colors.teal),
                        titleWidget('No', 16.0, FontWeight.normal),
                      ],
                    ),
                    divider(),
                  ],
                ),
              ),
            ),
            BootstrapCol(
              sizes: "col-lg-6",
              child: titleWidget('Father', 14.0, FontWeight.bold),
            ),
            BootstrapCol(
              sizes: "col-lg-6",
              child: titleWidget('Mother', 14.0, FontWeight.bold),
            ),

            BootstrapCol(
              sizes: "col-lg-6",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Symbols.boy, color: Colors.teal),
                  titleWidget(
                    'debojyoti bhattacharya',
                    16.0,
                    FontWeight.normal,
                  ),
                  Icon(Symbols.work, color: Colors.teal),
                  titleWidget('Service', 16.0, FontWeight.normal),
                  Icon(Symbols.call, color: Colors.teal),
                  titleWidget('9126070270', 16.0, FontWeight.normal),
                ],
              ),
            ),
            BootstrapCol(
              sizes: "col-lg-6",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Symbols.girl, color: Colors.teal),
                  titleWidget(
                    'debopriya bhattacharya',
                    16.0,
                    FontWeight.normal,
                  ),
                  Icon(Symbols.work, color: Colors.teal),
                  titleWidget('Service', 16.0, FontWeight.normal),
                  Icon(Symbols.call, color: Colors.teal),
                  titleWidget('9126070270', 16.0, FontWeight.normal),
                ],
              ),
            ),
            BootstrapCol(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: titleWidget(
                  'Monthly Income - 50000/-',
                  14,
                  FontWeight.bold,
                ),
              ),
            ),
            BootstrapCol(
              sizes: "col-lg-6",
              child: titleWidget(
                'Guardian - debopriya bhattacharya | 9126070270'.toUpperCase(),
                14.0,
                FontWeight.normal,
              ),
            ),

            BootstrapCol(child: divider()),
            BootstrapCol(
              sizes: "col-lg-6",
              child: titleWidget(
                'Permanent Address'.toUpperCase(),
                14.0,
                FontWeight.bold,
              ),
            ),
            BootstrapCol(
              sizes: "col-lg-6",
              child: titleWidget(
                'Local Address'.toUpperCase(),
                14.0,
                FontWeight.bold,
              ),
            ),
            BootstrapCol(
              sizes: "col-lg-6",
              child: titleWidget(
                'NAYA BUSTY LEBONG DARJEELING 734105',
                14.0,
                FontWeight.normal,
              ),
            ),
            BootstrapCol(
              sizes: "col-lg-6",
              child: titleWidget(
                'NAYA BUSTY LEBONG DARJEELING 734105',
                14.0,
                FontWeight.normal,
              ),
            ),
            BootstrapCol(child: divider()),
            BootstrapCol(
              sizes: "col-lg-6",
              child: titleWidget(
                'Institution Class X'.toUpperCase(),
                14.0,
                FontWeight.bold,
              ),
            ),
            BootstrapCol(
              sizes: "col-lg-6",
              child: titleWidget(
                'Institution Class XII'.toUpperCase(),
                14.0,
                FontWeight.bold,
              ),
            ),
            BootstrapCol(
              sizes: "col-lg-6",
              child: titleWidget('DAV SCHOOL', 14.0, FontWeight.normal),
            ),
            BootstrapCol(
              sizes: "col-lg-6",
              child: titleWidget(
                'DARJEELING PUBLIC SCHOOL, FULBARI',
                14.0,
                FontWeight.normal,
              ),
            ),
            BootstrapCol(child: divider()),

            BootstrapCol(
              sizes: "col-lg-12",
              child: titleWidget(
                'SUBJECT / SCORE'.toUpperCase(),
                14.0,
                FontWeight.bold,
              ),
            ),

            // Subjects
            BootstrapCol(
              sizes: "col-lg-12",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  titleWidget('English - 66/100', 16, FontWeight.normal),
                  titleWidget('History - 66/100', 16, FontWeight.normal),
                  titleWidget('Geography - 66/100', 16, FontWeight.normal),
                  titleWidget('Maths - 66/100', 16, FontWeight.normal),
                  titleWidget('Science - 66/100', 16, FontWeight.normal),
                ],
              ),
            ),
            BootstrapCol(child: divider()),
            BootstrapCol(
              child: SizedBox(
                height: 250,
                child: titleWidget('For Office Use Only', 16, FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
