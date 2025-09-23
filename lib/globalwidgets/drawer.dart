import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/custom_widget.dart';
import 'package:admin/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_symbols_icons/symbols.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool customIcon = false;

  void logout(context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    Navigator.pop(context);
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: accentSecondary,
      child: Container(
        color: const Color.fromARGB(255, 255, 216, 24).withValues(alpha: 0.1),

        height: MediaQuery.of(context).size.height,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('images/scslogo.png'),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start),
            InkWell(
              child: ListTile(
                leading: Icon(Symbols.acute, color: Colors.black),
                title: colorText('Real-Time', Colors.black),
              ),
              onTap: () => Navigator.pushNamed(context, '/'),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Symbols.apps, color: Colors.black),
                title: colorText('Dashboard', Colors.black),
              ),
              onTap: () => Navigator.pushNamed(context, '/dashboard'),
            ),
            ExpansionTile(
              title: colorText('Master', Colors.black),
              collapsedIconColor: Colors.black,
              leading: Icon(Symbols.menu),
              controlAffinity: ListTileControlAffinity.trailing,
              onExpansionChanged: (value) {
                setState(() => customIcon = value);
              },
              children: [
                menuList(context, 'Campus', '/campus'),
                menuList(context, 'Session', '/session'),
                menuList(context, 'Deanery', '/deanery'),
                menuList(context, 'Departments', '/departments'),
                // menuList(context, 'Fee Structure Sonada', '/fee-son'),
                // menuList(context, 'Fee Structure Siliguri', '/fee-sil'),
                menuList(context, 'Subjects', '/subjects'),
                menuList(context, 'Semesters', '/semesters'),
                menuList(context, 'Weekdays', '/weekdays'),
                menuList(context, 'Hours', '/hours'),
                menuList(context, 'Academic Blocks', '/acblock-master'),
                menuList(context, 'Room Type', '/room-type'),
                menuList(context, 'Lecture Hall', '/lecture-hall'),
                menuList(context, 'Cognitive Level', '/cog-level-master'),
              ],
            ),
            ExpansionTile(
              collapsedIconColor: Colors.black,
              leading: Icon(Symbols.stack),
              title: colorText('Admission', Colors.black),
              controlAffinity: ListTileControlAffinity.trailing,
              onExpansionChanged: (value) {
                setState(() => customIcon = value);
              },
              children: [
                menuList(context, 'Registration', '/registration'),
                menuList(context, 'UG Application', '/ug-applications'),
                menuList(context, 'PG Application', '/pg-applications'),
                menuList(context, 'Payments', '/payments'),
                menuList(context, 'Selection Phase 1', '/interview'),
                menuList(context, 'Selection Phase 2', '/selection-phasetwo'),
                menuList(context, 'Enrolled Students', '/enrolled-stdlist'),
              ],
            ),

            ExpansionTile(
              title: Text('Faculty'),
              controlAffinity: ListTileControlAffinity.leading,
              onExpansionChanged: (value) {
                setState(() => customIcon = value);
              },
              children: [
                menuList(context, 'Faculty', '//'),
                menuList(context, ' Departments', '//'),
                menuList(context, 'Leaves', '//'),
              ],
            ),

            ExpansionTile(
              title: Text('Examination'),
              controlAffinity: ListTileControlAffinity.leading,
              onExpansionChanged: (value) {
                setState(() => customIcon = value);
              },
              children: [
                menuList(context, 'Faculty Assignment', '//'),
                menuList(context, ' Paper Setting', '//'),
                menuList(context, 'Hall Tickets', '//'),
                menuList(context, 'Registration', '//'),
                menuList(context, 'Seating Arrangements', '//'),
                menuList(context, 'Evaluation', '//'),
              ],
            ),

            ExpansionTile(
              title: Text('Administration'),
              controlAffinity: ListTileControlAffinity.leading,
              onExpansionChanged: (value) {
                setState(() => customIcon = value);
              },
              children: [
                menuList(context, 'Staff', '//'),
                menuList(context, 'Asset Manager', '//'),
                menuList(context, 'Leaves', '//'),
              ],
            ),

            ExpansionTile(
              title: Text('Accounts'),
              controlAffinity: ListTileControlAffinity.leading,
              onExpansionChanged: (value) {
                setState(() => customIcon = value);
              },
              children: [
                menuList(context, 'Salary', '//'),
                menuList(context, 'Fees', '//'),
                menuList(context, 'Admission', '//'),
                menuList(context, 'Loans', '//'),
              ],
            ),

            ExpansionTile(
              title: Text('Users'),
              controlAffinity: ListTileControlAffinity.leading,
              onExpansionChanged: (value) {
                setState(() => customIcon = value);
              },
              children: [
                menuList(context, 'Staff', '//'),
                menuList(context, 'Asset Manager', '//'),
                menuList(context, 'Leaves', '//'),
              ],
            ),

            ExpansionTile(
              title: Text('Permissions'),
              controlAffinity: ListTileControlAffinity.leading,
              onExpansionChanged: (value) {
                setState(() => customIcon = value);
              },
              children: [
                menuList(context, 'Staff', '//'),
                menuList(context, 'Asset Manager', '//'),
                menuList(context, 'Leaves', '//'),
              ],
            ),

            InkWell(
              child: ListTile(
                leading: Icon(Icons.badge, color: accentMain),
                title: Text('IQAC', style: TextStyle(color: accentMain)),
              ),
              onTap: () => Navigator.pushNamed(context, '//'),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Symbols.error, color: Colors.red),
                title: Text(
                  'Error Logs',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              onTap: () => Navigator.pushNamed(context, '/errorlogs'),
            ),

            ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 14.0, color: Colors.black),
              ),
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget menuList(context, String title, String route) {
  return ListTile(
    leading: Icon(Icons.arrow_right, color: accentMain),
    title: Text(title, style: TextStyle(fontSize: 14.0)),
    onTap: () {
      // Navigator.pop(context);
      Navigator.pushNamed(context, route);
    },
  );
}
