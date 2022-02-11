import 'package:flutter/material.dart';
import 'package:plant_care/auth/widgets/text_field_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String errorText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        iconTheme: const IconThemeData(color: Color(0xFF3a4d34)),
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/forgot_password_background.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  errorText != ''
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
                          ),
                          child: Text(
                            errorText,
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 12,
                            ),
                          ),
                        )
                      : const SizedBox(height: 1),
                  const Text(
                    'Enter the email address for your Plant Care account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF3a4d34),
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const TextInputWidget(
                    labelText: 'Email',
                    prefixIcon: Icons.mail_outline,
                    isPassword: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Forgot Password');
                      },
                      child: const Text('Forgot password'),
                    ),
                  ),
                  const SizedBox(height: 310),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
