import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/services/services.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String errorText = '';
  TextEditingController _emailController = TextEditingController();

  Future forgotPassword(String email) async {
    dynamic result = await AuthService.forgotPassword(
      email.trim(),
    );
    if (result is CustomError) {
      setState(() {
        errorText = result.message;
      });
      return result.message;
    } else {
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = Provider.of<Vaildator>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        iconTheme: const IconThemeData(color: Color(0xFF3a4d34)),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            forgotPasswordState.reset();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/forgot_password_background.png"),
            fit: BoxFit.cover,
            alignment: Alignment.topLeft,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                labelText: 'Email',
                prefixIcon: Icons.mail_outline,
                isPassword: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onChanged: forgotPasswordState.validateEmail,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: forgotPasswordState.emailStatus
                      ? () async {
                          forgotPassword(
                            _emailController.text,
                          ).then((value) {
                            if (value == null) {
                              Navigator.of(context).pop();
                              forgotPasswordState.reset();
                            }
                          });
                        }
                      : null,
                  // Reset provider when clicking off this page
                  child: const Text('Forgot password'),
                ),
              ),
              const SizedBox(height: 310),
            ],
          ),
        ),
      ),
    );
  }
}
