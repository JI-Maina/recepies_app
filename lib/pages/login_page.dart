import 'package:flutter/material.dart';
import 'package:recepies_app/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey =
      GlobalKey(); // key to manage formstate

  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _loginForm(),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      'Recipe Book',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.90,
      height: MediaQuery.sizeOf(context).height * 0.30,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: 'kminchelle',
              onSaved: (newValue) {
                setState(() {
                  username = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter a Username";
                }
              },
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
            TextFormField(
              initialValue: '0lelplR',
              obscureText: true,
              onSaved: (newValue) {
                setState(() {
                  password = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.length < 5) {
                  return "Enter a valid password";
                }
              },
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await AuthService().login(username!, password!);

            if (result) {
            } else {
              StatusAlert.show(
                context,
                duration: const Duration(seconds: 2),
                title: 'Login Failed!',
                subtitle: 'Please try again',
                configuration: const IconConfiguration(
                  icon: Icons.error,
                ),
                maxWidth: 260,
              );
            }
          }
        },
        child: const Text('login'),
      ),
    );
  }
}
