import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/auth/widgets/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        iconTheme: const IconThemeData(color: Color(0xFF3a4d34)),
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          //Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_background.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 40),
              // width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  const SizedBox(height: 180),
                  const TextInputWidget(
                    labelText: 'Email',
                    prefixIcon: Icons.mail_outline,
                    obscureText: false,
                  ),
                  const TextInputWidget(
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => print('Login Auth Func'),
                      child: const Text('Login'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => print('Forgot password?'),
                    child: Text('Forgot Password?'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
