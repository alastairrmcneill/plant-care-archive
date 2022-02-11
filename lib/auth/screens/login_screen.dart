import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/auth/models/user_model.dart';
import 'package:plant_care/auth/services/validation_service.dart';
import 'package:plant_care/screens/screens.dart';
import 'package:plant_care/auth/widgets/text_field_widget.dart';
import 'package:plant_care/auth/services/auth_service.dart';
import 'package:plant_care/support/wrapper.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String errorText = '';

  Future<void> logInFunc(String value) async {
    dynamic result = await AuthService.signInWithEmailPassword('test@me.cm', '123456');
    if (result is FirebaseAuthException) {
      setState(() {
        errorText = result.message!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = Provider.of<Vaildator>(context, listen: true);

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
                image: AssetImage("assets/images/login_background.png"),
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
                  TextInputWidget(
                    labelText: 'Email',
                    prefixIcon: Icons.mail_outline,
                    isPassword: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: formState.validateEmail,
                  ),
                  TextInputWidget(
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    submittedFunc: logInFunc,
                    onChanged: formState.validatePassword,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: formState.formStatus
                          ? () async {
                              await logInFunc(''); //.then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (_) => false));
                              //Need to check if it is a valid user or not before punting back.
                            }
                          : null,
                      child: const Text('Login'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen())),
                    child: Text('Forgot Password?'),
                  ),
                  const SizedBox(height: 260),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
