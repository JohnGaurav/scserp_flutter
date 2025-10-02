import 'dart:convert';

import 'package:admin/pages/accounts/dashboard.dart';
import 'package:admin/pages/dashboard.dart';
import 'package:admin/pages/faculty/dashboard.dart';
import 'package:admin/pages/management/dashboard.dart';
import 'package:admin/pages/unknown.dart';
import 'package:admin/services/api_cred.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String token = "";
  String userRole = "";
  bool userAuth = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {});
    }
    setState(() {
      isLoading = true;
    });
    http.Response apiResponse = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'email': _emailController.text,
        'password': _passwordController.text,
      },
      headers: requestHeaders,
    );

    final decoded = jsonDecode(apiResponse.body);

    if (decoded['status'] == true) {
      var userId = decoded['data']['user']['id'];
      var user_role = decoded['data']['user_role'];
      SharedPreferences pref = await SharedPreferences.getInstance();
      SharedPreferences prefuser = await SharedPreferences.getInstance();
      await pref.setString('userId', userId.toString());
      await prefuser.setString('userRole', user_role.toString());

      token = userId.toString();
      setState(() {
        userAuth = true;
        userRole = user_role;
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${decoded['message']}'),
          duration: Duration(seconds: 2), // The default is 4 seconds
        ),
      );
      handleLogin(context);
    } else {
      // To show a basic toast-like message

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid Credentials'),
          duration: Duration(seconds: 2), // The default is 4 seconds
        ),
      );
      setState(() {
        isLoading = false;
      });
      handleLogin(context);
    }
  }

  void handleLogin(BuildContext context) async {
    if (userAuth) {
      final prefs = await SharedPreferences.getInstance();

      var user_Role = prefs.getString('userRole')!;

      if (user_Role == "admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else if (user_Role == "teacher") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FacultyDashboardScreen()),
        );
      } else if (user_Role == "office") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AccountsDashboardScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ManagementDashboardScreen()),
        );
      }
    } else {
      return;
    }
  }

  void getCred() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('userId')!;

    if (token.isNotEmpty) {
      setState(() {
        userAuth = true;
        handleLogin(context);
      });
    } else {
      setState(() {
        userAuth = false;
        handleLogin(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCred();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 142, 179, 252),
              Color.fromARGB(255, 252, 228, 195),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 350,
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10),
                            Image.asset('images/logos.png'),
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                'ERP LOGIN',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Colors.black54,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+',
                                ).hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: const Icon(
                                  Icons.key_outlined,
                                  color: Colors.black54,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 45.0,
                              child: ElevatedButton(
                                onPressed: submitForm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    161,
                                    60,
                                    122,
                                    237,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                child: isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.amber,
                                      )
                                    : const Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(context, '/forgot');
                              },
                              child: const Text("Forgot Password?"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
