import 'package:admin/globalwidgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

class FacultyDashboardScreen extends StatefulWidget {
  const FacultyDashboardScreen({super.key});

  @override
  State<FacultyDashboardScreen> createState() => _FacultyDashboardScreenState();
}

class _FacultyDashboardScreenState extends State<FacultyDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.withValues(alpha: 0.1),
        title: Text(
          'Salesian Colllege Faculty',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actionsPadding: EdgeInsets.all(10.0),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
      drawer: CustomDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withValues(alpha: 0.1),
              Colors.blue.withValues(alpha: 0.4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BootstrapRow(
                children: [
                  BootstrapCol(
                    sizes: 'col-12 col-md-8 col-lg-9',
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Flexible(
                        child: BootstrapRow(
                          children: [
                            //profile info
                            BootstrapCol(
                              sizes: 'col-sm-12 col-lg-5',
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromRGBO(
                                        0,
                                        0,
                                        0,
                                        0.15,
                                      ),
                                      blurRadius: 15,
                                      offset: const Offset(6, 6),
                                    ),
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                        128,
                                        249,
                                        170,
                                        97,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(-6, -6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Left content
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 32,
                                          color: Colors.black87,
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          "Ready to assign",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: const [
                                            Text(
                                              "200",
                                              style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "Bills in this week: 221",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Right circular progress
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.deepPurple.withAlpha(
                                              60,
                                            ),
                                            blurRadius: 12,
                                            offset: const Offset(4, 4),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            value: 0.42, // 42%
                                            strokeWidth: 6,
                                            backgroundColor: Colors.grey[200],
                                            valueColor:
                                                const AlwaysStoppedAnimation(
                                                  Colors.deepPurple,
                                                ),
                                          ),
                                          const Text(
                                            "42%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //upcoming class
                            BootstrapCol(
                              sizes: 'col-sm-12 col-lg-7',
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromRGBO(
                                        0,
                                        0,
                                        0,
                                        0.15,
                                      ),
                                      blurRadius: 15,
                                      offset: const Offset(6, 6),
                                    ),
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                        128,
                                        249,
                                        170,
                                        97,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(-6, -6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Left content
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 32,
                                          color: Colors.black87,
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          "Ready to assign",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: const [
                                            Text(
                                              "200",
                                              style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              " - 42",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "Bills in this week: 221",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Right circular progress
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.deepPurple.withAlpha(
                                              60,
                                            ),
                                            blurRadius: 12,
                                            offset: const Offset(4, 4),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            value: 0.42, // 42%
                                            strokeWidth: 6,
                                            backgroundColor: Colors.grey[200],
                                            valueColor:
                                                const AlwaysStoppedAnimation(
                                                  Colors.deepPurple,
                                                ),
                                          ),
                                          const Text(
                                            "42%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //Count Section

                            //counter1
                            BootstrapCol(
                              sizes: 'col-sm-12 col-lg-3',
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.pink.withValues(alpha: 0.5),
                                      blurRadius: 15,
                                      offset: const Offset(4, 6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Left content
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 32,
                                          color: Colors.black87,
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          "Ready to assign",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: const [
                                            Text(
                                              "200",
                                              style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              " - 42",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "Bills in this week: 221",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Right circular progress
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.deepPurple.withAlpha(
                                              60,
                                            ),
                                            blurRadius: 12,
                                            offset: const Offset(4, 4),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            value: 0.42, // 42%
                                            strokeWidth: 6,
                                            backgroundColor: Colors.grey[200],
                                            valueColor:
                                                const AlwaysStoppedAnimation(
                                                  Colors.green,
                                                ),
                                          ),
                                          const Text(
                                            "42%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //counter2
                            BootstrapCol(
                              sizes: 'col-sm-12 col-lg-3',
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withValues(alpha: 0.3),
                                      blurRadius: 15,
                                      offset: const Offset(4, 6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Left content
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 32,
                                          color: Colors.black87,
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          "Ready to assign",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: const [
                                            Text(
                                              "200",
                                              style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              " - 42",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "Bills in this week: 221",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Right circular progress
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.deepPurple.withAlpha(
                                              60,
                                            ),
                                            blurRadius: 12,
                                            offset: const Offset(4, 4),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            value: 0.42, // 42%
                                            strokeWidth: 6,
                                            backgroundColor: Colors.grey[200],
                                            valueColor:
                                                const AlwaysStoppedAnimation(
                                                  Colors.green,
                                                ),
                                          ),
                                          const Text(
                                            "42%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //counter3
                            BootstrapCol(
                              sizes: 'col-sm-12 col-lg-3',
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                                      blurRadius: 15,
                                      offset: const Offset(6, 6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Left content
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 32,
                                          color: Colors.black87,
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          "Ready to assign",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: const [
                                            Text(
                                              "200",
                                              style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              " - 42",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "Bills in this week: 221",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Right circular progress
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.deepPurple.withAlpha(
                                              60,
                                            ),
                                            blurRadius: 12,
                                            offset: const Offset(4, 4),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            value: 0.42, // 42%
                                            strokeWidth: 6,
                                            backgroundColor: Colors.grey[200],
                                            valueColor:
                                                const AlwaysStoppedAnimation(
                                                  Colors.green,
                                                ),
                                          ),
                                          const Text(
                                            "42%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //counter4
                            BootstrapCol(
                              sizes: 'col-sm-12 col-lg-3',
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.amber.withValues(
                                        alpha: 0.5,
                                      ),
                                      blurRadius: 15,
                                      offset: const Offset(6, 6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Left content
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 32,
                                          color: Colors.black87,
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          "Ready to assign",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: const [
                                            Text(
                                              "200",
                                              style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              " - 42",
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "Bills in this week: 221",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Right circular progress
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.deepPurple.withAlpha(
                                              60,
                                            ),
                                            blurRadius: 12,
                                            offset: const Offset(4, 4),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            value: 0.42, // 42%
                                            strokeWidth: 6,
                                            backgroundColor: Colors.grey[200],
                                            valueColor:
                                                const AlwaysStoppedAnimation(
                                                  Colors.green,
                                                ),
                                          ),
                                          const Text(
                                            "42%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //countSection Ends
                            BootstrapCol(
                              sizes: 'col-lg-6 col-sm-12',
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                ),
                                child: Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                    color: Colors.indigoAccent.withAlpha(100),
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(
                                          0,
                                          0,
                                          0,
                                          0.3,
                                        ), // replaces withOpacity(0.3)
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(4, 6),
                                      ),
                                    ], // rounded edges
                                  ),
                                ),
                              ),
                            ),
                            BootstrapCol(
                              sizes: 'col-lg-6 col-sm-12',
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                ),
                                child: Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(200),
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(
                                          0,
                                          0,
                                          0,
                                          0.3,
                                        ), // replaces withOpacity(0.3)
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(4, 6),
                                      ),
                                    ], // rounded edges
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Right sidebar
                  BootstrapCol(
                    sizes: 'col-12 col-md-4 col-lg-3',
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(20),
                                // rounded edges
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(
                                      0,
                                      0,
                                      0,
                                      0.3,
                                    ), // replaces withOpacity(0.3)
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(4, 6),
                                  ),
                                ], // rounded edges
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(
                                      0,
                                      0,
                                      0,
                                      0.3,
                                    ), // replaces withOpacity(0.3)
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(-4, -6),
                                  ),
                                ], // rounded edges
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(
                                      0,
                                      0,
                                      0,
                                      0.3,
                                    ), // replaces withOpacity(0.3)
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(-4, -6),
                                  ),
                                ], // rounded edges
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customBootstrapCard(String mysizes, Widget mywidget) {
  return BootstrapCol(
    sizes: mysizes,
    child: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.3), // replaces withOpacity(0.3)
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(4, 6),
            ),
          ], // rounded edges
        ),
        child: mywidget,
      ),
    ),
  );
}
