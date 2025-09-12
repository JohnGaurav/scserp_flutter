import 'dart:convert';

import 'package:admin/color/color-palette.dart';
import 'package:admin/globalwidgets/drawer.dart';
import 'package:admin/services/api_cred.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CampusMasterScreen extends StatefulWidget {
  const CampusMasterScreen({super.key});

  @override
  State<CampusMasterScreen> createState() => _CampusMasterScreenState();
}

class _CampusMasterScreenState extends State<CampusMasterScreen> {
  List<dynamic> campusList = [];

  Future<void> apiData() async {
    http.Response apiResponse = await http.get(
      Uri.parse("$baseUrl/campus"),
      headers: requestHeaders,
    );

    final decoded = jsonDecode(apiResponse.body);
    setState(() {
      campusList = decoded["data"];
    });
  }

  @override
  void initState() {
    super.initState();
    apiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentMain,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Campus', style: TextStyle(color: Colors.white)),
      ),
      drawer: CustomDrawer(),
      body: ListView.builder(
        itemCount: campusList.length,
        itemBuilder: (context, index) {
          final campus = campusList[index];
          final programs = campus["campusprograms"];

          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campus["name"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: programs.map<Widget>((prog) {
                    return Chip(
                      label: Text(prog["name"]),
                      backgroundColor: Colors.green.shade100,
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
