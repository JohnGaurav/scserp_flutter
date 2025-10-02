import 'package:flutter/material.dart';

class AccountsDashboardScreen extends StatefulWidget {
  const AccountsDashboardScreen({super.key});

  @override
  State<AccountsDashboardScreen> createState() =>
      _AccountsDashboardScreenState();
}

class _AccountsDashboardScreenState extends State<AccountsDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Account Dashboard')));
  }
}
