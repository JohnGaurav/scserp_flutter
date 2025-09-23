import 'package:flutter/material.dart';

class DepartmentSingleScreen extends StatefulWidget {
  const DepartmentSingleScreen({super.key});

  @override
  State<DepartmentSingleScreen> createState() => _DepartmentSingleScreenState();
}

class _DepartmentSingleScreenState extends State<DepartmentSingleScreen> {
  @override
  Widget build(BuildContext context) {
    // var routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    // var id = routeArgs['subject_id'];
    // var deptname = routeArgs['deptname'];
    return Scaffold(
      appBar: AppBar(title: Text('subjectname'), elevation: 5.0),
      body: Column(children: [
        
      ],),
    );
  }
}
