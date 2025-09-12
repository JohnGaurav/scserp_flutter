import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget divider() {
  return Divider(
    height: 20, // Height of the divider line (including space around it)
    thickness: 1, // Thickness of the actual line
    indent: 20, // Start indent from the left
    endIndent: 20, // End indent from the right
    color: Colors.blueGrey, // Color of the divider line
  );
}

Widget titleWidget(String title, double? fontsize, FontWeight fontweight) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      title,
      style: TextStyle(fontSize: fontsize, fontWeight: fontweight),
    ),
  );
}

Widget buildStatCard(String title, String value, IconData icon, Color color) {
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

Future<bool?> myToast(String msg) {
  return Fluttertoast.showToast(msg: msg, gravity: ToastGravity.TOP_RIGHT);
}
