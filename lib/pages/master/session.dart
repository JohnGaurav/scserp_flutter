import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/drawer.dart';
import 'package:admin/models/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController newSessionController = TextEditingController();

  List<AnnualRevenueData> revenueData = [
    AnnualRevenueData('Revenue', 5000.00, Colors.black),
    AnnualRevenueData('Revenue', 5000.00, Colors.black),
  ];
  @override
  void initState() {
    super.initState();
  }

  void addModal(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Session"),
          content: Text(
            "This Allows you to create a new session to set regulation",
          ),
          actions: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: newSessionController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Session Name",
                      prefixIcon: const Icon(Icons.numbers),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // <- makes it rectangular
                        ),
                      ),
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentMain,
        title: Text(
          'Annual Session Master',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actionsPadding: EdgeInsets.all(10.0),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addModal(context);
        },
        child: Icon(Icons.add),
      ),

      body: BootstrapContainer(
        fluid: true,
        padding: const EdgeInsets.all(12),
        children: [
          BootstrapRow(
            height: 140,
            children: [
              BootstrapCol(
                sizes: 'col-12 col-md-6 col-lg-3',
                child: _buildStatCard(
                  '2015',
                  'Enrolled 1,245',
                  Icons.people,
                  Colors.red,
                ),
              ),
              BootstrapCol(
                sizes: 'col-12 col-md-6 col-lg-3',
                child: _buildStatCard(
                  '2015',
                  'Enrolled 1,245',
                  Icons.people,
                  Colors.green,
                ),
              ),
              BootstrapCol(
                sizes: 'col-12 col-md-6 col-lg-3',
                child: _buildStatCard(
                  '2015',
                  'Enrolled 1,245',
                  Icons.people,
                  Colors.orange,
                ),
              ),
              BootstrapCol(
                sizes: 'col-12 col-md-6 col-lg-3',
                child: _buildStatCard(
                  '2015',
                  'Enrolled 1,245',
                  Icons.people,
                  Colors.deepPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildStatCard(String title, String value, IconData icon, Color color) {
  return Card(
    color: color.withValues(alpha: 0.5),
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton(onPressed: () {}, child: Text('Active')),
            ],
          ),
        ],
      ),
    ),
  );
}
