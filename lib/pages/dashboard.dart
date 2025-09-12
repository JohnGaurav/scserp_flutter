import 'package:admin/color/color-palette.dart';
import 'package:admin/models/chart_model.dart';
import 'package:admin/globalwidgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<GenderWiseData> genderData = [
    GenderWiseData('Male', 107, Colors.blue),
    GenderWiseData('Female', 93, Colors.pink),
  ];

  List<DeptWisePresentData> presentData = [
    DeptWisePresentData('English', 31),
    DeptWisePresentData('History', 29),
    DeptWisePresentData('BCA', 19),
    DeptWisePresentData('BBA', 181),
  ];

  @override
  void initState() {
    super.initState();
    bootstrapGridParameters(gutterSize: 30);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentMain,
        title: Text(
          'Salesian College Autonomous',
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
                  'Students',
                  '1,245',
                  Icons.people,
                  Colors.red,
                ),
              ),
              BootstrapCol(
                sizes: 'col-12 col-md-6 col-lg-3',
                child: _buildStatCard(
                  'Fees',
                  '\$45,300',
                  Icons.attach_money,
                  Colors.green,
                ),
              ),
              BootstrapCol(
                sizes: 'col-12 col-md-6 col-lg-3',
                child: _buildStatCard(
                  'Faculties',
                  '320',
                  Icons.shopping_cart,
                  Colors.orange,
                ),
              ),
              BootstrapCol(
                sizes: 'col-12 col-md-6 col-lg-3',
                child: _buildStatCard(
                  'Todays Attendance',
                  '85%',
                  Icons.feedback,
                  Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BootstrapRow(
            children: [
              BootstrapCol(
                sizes: 'col-12 col-lg-8',
                child: Card(
                  elevation: 5.0,
                  color: const Color.fromARGB(173, 255, 255, 255),
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(text: 'Dept Today'),
                    tooltipBehavior: TooltipBehavior(enable: true),

                    series: <CartesianSeries<DeptWisePresentData, String>>[
                      ColumnSeries<DeptWisePresentData, String>(
                        dataSource: presentData,
                        xValueMapper: (DeptWisePresentData name, _) =>
                            name.name,
                        yValueMapper: (DeptWisePresentData count, _) =>
                            count.count,
                        color: Colors.lightGreen,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
              ),
              BootstrapCol(
                sizes: 'col-12 col-lg-4',
                child: Card(
                  child: SfCircularChart(
                    title: ChartTitle(text: "Gender Distribution"),
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap,
                    ),
                    series: <CircularSeries>[
                      PieSeries<GenderWiseData, String>(
                        dataSource: genderData,
                        xValueMapper: (GenderWiseData data, _) => data.gender,
                        yValueMapper: (GenderWiseData data, _) => data.count,
                        pointColorMapper: (GenderWiseData data, _) =>
                            data.color,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                      ),
                    ],
                  ),
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
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildChartPlaceholder(String title) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: SizedBox(
      height: 250,
      child: Center(
        child: Text(
          "$title (Chart Placeholder)",
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
    ),
  );
}
