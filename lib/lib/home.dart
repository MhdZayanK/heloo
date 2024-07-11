import 'package:flutter/material.dart';
import 'package:test_api_login/lib/patient.dart';
import 'package:test_api_login/lib/service/authservice.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _loginkey = GlobalKey<FormState>();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _loginkey,
        child: Column(
          children: [
            SizedBox(height: 150),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _username,
                decoration:
                    const InputDecoration(hintText: 'Enter a valid username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter a valid username";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _password,
                decoration:
                    const InputDecoration(hintText: 'Enter a valid password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter a valid password";
                  }
                  return null;
                },
                obscureText: true,
              ),
            ),
            SizedBox(height: 60),
            InkWell(
              onTap: () async {
                if (_loginkey.currentState!.validate()) {
                  AuthService _authService = AuthService();
                  final user = await _authService.login(
                      username: _username.text, password: _password.text);
                  if (user != null && user.token != null) {
                    // Handle successful login
                    print('Login successful: ${user.token}');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Patient_list()),
                        (route) => false);
                  } else {
                    // Handle login failure
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login Failed')),
                    );
                  }
                }
              },
              child: Container(
                height: 50,
                width: 80,
                color: Colors.orange[200],
                child: const Center(child: Text('Login')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
