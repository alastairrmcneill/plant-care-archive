import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/auth/services/validation_service.dart';
import 'package:plant_care/screens/screens.dart';
import 'package:plant_care/auth/widgets/text_field_widget.dart';
import 'package:plant_care/auth/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String errorText = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  Future<void> login(String value) async {
    dynamic result = await AuthService.signInWithEmailPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    if (result is FirebaseAuthException) {
      setState(() {
        errorText = result.message!;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.clear();
    _passwordController.clear();
    _emailFocus.unfocus();
    _passwordFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<Vaildator>(context, listen: true);

    void _resetPage() {
      loginState.reset();
      _emailController.clear();
      _passwordController.clear();
      // understand how to remove focus completely
      _emailFocus.unfocus();
      _passwordFocus.unfocus();
      FocusScope.of(context).unfocus();
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        iconTheme: const IconThemeData(color: Color(0xFF3a4d34)),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            _resetPage();
          },
          icon: Icon(Icons.arrow_back),
        ),
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
            padding: const EdgeInsets.symmetric(horizontal: 30),
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
                    controller: _emailController,
                    focusNode: _emailFocus,
                    labelText: 'Email',
                    prefixIcon: Icons.mail_outline,
                    isPassword: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: loginState.validateEmail,
                  ),
                  TextInputWidget(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    submittedFunc: login,
                    onChanged: loginState.validatePassword,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: loginState.loginStatus
                          ? () async {
                              await login(''); //.then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (_) => false));
                              //Need to check if it is a valid user or not before punting back.
                            }
                          : null,
                      child: const Text('Login'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                      _resetPage();
                    },
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
