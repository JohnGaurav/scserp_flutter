import 'package:flutter/material.dart';

class DeanerySingleScreen extends StatefulWidget {
  const DeanerySingleScreen({super.key});

  @override
  State<DeanerySingleScreen> createState() => _DeanerySingleScreenState();
}

class _DeanerySingleScreenState extends State<DeanerySingleScreen> {
  @override
  Widget build(BuildContext context) {
    var routeArg = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          routeArg['title'].toString() +
              ' | ' +
              routeArg['campus'].toString() +
              '-' +
              routeArg['program'].toString(),
        ),
        elevation: 5.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        tooltip: "Assign Departments",
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
