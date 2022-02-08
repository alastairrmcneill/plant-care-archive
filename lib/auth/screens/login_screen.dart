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
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                const SizedBox(height: 300),
                TextInputWidget(
                  labelText: 'Email',
                  prefixIcon: Icons.mail_outline,
                  obscureText: false,
                ),
                TextInputWidget(
                  labelText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: 'Forgot Password?',
                          style: TextStyle(color: Color(0xFF3a4d34)),
                          recognizer: TapGestureRecognizer()..onTap = () => print('Forgot password?'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
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
      ),
    );
  }
}
