import 'package:admin/color/color-palette.dart';
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
              leading: Icon(Symbols.acute, color: accentMain),
              title: Text('Real-Time', style: TextStyle(color: accentMain)),
            ),
            onTap: () => Navigator.pushNamed(context, '/'),
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Symbols.apps, color: accentMain),
              title: Text('Dashboard', style: TextStyle(color: accentMain)),
            ),
            onTap: () => Navigator.pushNamed(context, '/dashboard'),
          ),
          ExpansionTile(
            title: Text('Master'),
            controlAffinity: ListTileControlAffinity.leading,
            onExpansionChanged: (value) {
              setState(() => customIcon = value);
            },
            children: [
              menuList(context, 'Campus', '/campus'),
              menuList(context, 'Session', '/session'),

              menuList(context, 'Deanery', '/deanery'),
              // menuList(context, 'Deanery Siliguri', '/deanery-sil'),
              // menuList(context, 'Fee Structure Sonada', '/fee-son'),
              // menuList(context, 'Fee Structure Siliguri', '/fee-sil'),
              menuList(context, 'Subjects', '/subjects'),
              menuList(context, 'Semesters', '/semesters'),
              menuList(context, 'Weekdays', '/weekdays'),
              menuList(context, 'Hours', '/hours'),
            ],
          ),
          ExpansionTile(
            title: Text('Admission'),
            controlAffinity: ListTileControlAffinity.leading,
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
              leading: Icon(Symbols.apps, color: accentMain),
              title: Text('ErrorLogs', style: TextStyle(color: accentMain)),
            ),
            onTap: () => Navigator.pushNamed(context, '/errorlogs'),
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.person, color: accentMain),
              title: Text('IQAC', style: TextStyle(color: accentMain)),
            ),
            onTap: () => Navigator.pushNamed(context, '//'),
          ),
          // InkWell(
          //   child: ListTile(
          //     leading: Icon(Icons.house, color: accentMain),
          //     title: Text('Our Docs', style: TextStyle(color: accentMain)),
          //   ),
          //   onTap: () => Navigator.pushNamed(context, '/institutions'),
          // ),
          // InkWell(
          //   child: ListTile(
          //     leading: Icon(Icons.person, color: accentMain),
          //     title: Text('News', style: TextStyle(color: accentMain)),
          //   ),
          //   onTap: () => Navigator.pushNamed(context, '/association-groups'),
          // ),
          // InkWell(
          //   child: ListTile(
          //     leading: Icon(Icons.camera, color: accentMain),
          //     title: Text('Gallery', style: TextStyle(color: accentMain)),
          //   ),
          //   onTap: () => Navigator.pushNamed(context, '/main-events'),
          // ),
          ListTile(
            leading: Icon(Icons.logout, color: accentMain),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 14.0, color: accentMain),
            ),
            onTap: () {
              logout(context);
            },
          ),
        ],
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
