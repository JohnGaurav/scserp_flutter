import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/drawer.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

class DeaneryMasterSilScreen extends StatefulWidget {
  const DeaneryMasterSilScreen({super.key});

  @override
  State<DeaneryMasterSilScreen> createState() => _DeaneryMasterSilScreenState();
}

class _DeaneryMasterSilScreenState extends State<DeaneryMasterSilScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentMain,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Deanery List', style: TextStyle(color: Colors.white)),
      ),
      drawer: CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionBubble(
          items: <Bubble>[
            Bubble(
              title: "Add Deanery",
              iconColor: Colors.white,
              bubbleColor: Colors.indigo,
              icon: Icons.add,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                print('add deneary');
              },
            ),
            Bubble(
              title: "Add Department",
              iconColor: Colors.white,
              bubbleColor: Colors.indigo,
              icon: Icons.add,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                print('add dept');
              },
            ),
          ],
          // animation controller
          animation: _animation,

          // On pressed change animation state
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),

          // Floating Action button Icon color
          iconColor: Colors.white,

          // Flaoting Action button Icon
          iconData: Icons.more_vert_sharp,
          backGroundColor: Colors.indigoAccent,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            BootstrapRow(
              height: 150,
              children: [
                BootstrapCol(
                  sizes: 'col-12 col-md-6 col-lg-4 col-xl-4 col-sm-12',
                  child: deaneryCard(
                    'Department of Arts and Humanities',
                    Colors.green,
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-12 col-md-6 col-lg-4 col-xl-4 col-sm-12',
                  child: deaneryCard(
                    'Department of Commerce',
                    Colors.redAccent,
                  ),
                ),
                BootstrapCol(
                  sizes: 'col-12 col-md-6 col-lg-4 col-xl-4 col-sm-12',
                  child: deaneryCard(
                    'Department of Science',
                    Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget deaneryCard(String title, Color color) {
    return Card(
      color: Colors.blueGrey[200],

      elevation: 5.0,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: 600.0,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      expandedCourse('English', Colors.white, context),
                      expandedCourse('History', Colors.white, context),
                      expandedCourse('Geography', Colors.white, context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget expandedCourse(String title, Color color, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(30.0),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        showTrailingIcon: true,
        title: Text(title),
        controlAffinity: ListTileControlAffinity.trailing,
        onExpansionChanged: (value) {},
        collapsedBackgroundColor: Colors.white,
        collapsedIconColor: Colors.black,
        children: [
          menuList(context, 'Registration', '//'),
          menuList(context, 'Application', '//'),
          menuList(context, 'Payments', '//'),
          menuList(context, 'Selection Phase 1', '//'),
          menuList(context, 'Selection Phase 2', '//'),
          menuList(context, 'Enrolled Student', '//'),
        ],
      ),
    ),
  );
}
