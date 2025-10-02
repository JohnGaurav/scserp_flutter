import 'package:flutter/material.dart';

class UnknowScreen extends StatefulWidget {
  const UnknowScreen({super.key});

  @override
  State<UnknowScreen> createState() => _UnknowScreenState();
}

class _UnknowScreenState extends State<UnknowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Unknown Screen')));
  }
}
