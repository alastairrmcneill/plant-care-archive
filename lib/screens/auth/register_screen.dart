import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/services.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:plant_care/support/wrapper.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String errorText = '';
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus1 = FocusNode();
  final FocusNode _passwordFocus2 = FocusNode();

  Future _register(UserNotifier userNotifier, String email, String password1, String password2) async {
    AppUser appUser = AppUser(firstName: _firstNameController.text.trim(), lastName: _lastNameController.text.trim(), email: _emailController.text.trim(), households: []);

    if (password1 == password2) {
      dynamic result = await AuthService.registerWithEmailPassword(
        userNotifier,
        appUser,
        email.trim(),
        password1.trim(),
      );
      if (result is CustomError) {
        setState(() {
          errorText = result.message;
        });

        return result.message;
      } else {
        return result;
      }
    } else {
      setState(() {
        errorText = 'Passwords do not match.';
      });
      return 'Passwords do not match.';
    }
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    final registerState = Provider.of<Vaildator>(context, listen: true);
    void _resetPage() {
      registerState.reset();
      _firstNameController.clear();
      _lastNameController.clear();
      _emailController.clear();
      _passwordController1.clear();
      _passwordController2.clear();

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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/register_background.png"),
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
              Row(
                children: [
                  Flexible(
                    child: TextInputWidget(
                      controller: _firstNameController,
                      focusNode: _firstNameFocus,
                      labelText: 'First Name',
                      prefixIcon: Icons.account_circle_outlined,
                      isPassword: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: registerState.validateFirstName,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextInputWidget(
                      controller: _lastNameController,
                      focusNode: _lastNameFocus,
                      labelText: 'Last Name',
                      prefixIcon: Icons.account_circle_outlined,
                      isPassword: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: registerState.validateLastName,
                    ),
                  )
                ],
              ),
              TextInputWidget(
                controller: _emailController,
                focusNode: _emailFocus,
                labelText: 'Email',
                prefixIcon: Icons.mail_outline,
                isPassword: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onChanged: registerState.validateEmail,
              ),
              TextInputWidget(
                controller: _passwordController1,
                focusNode: _passwordFocus1,
                labelText: 'Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                onChanged: registerState.validatePassword,
              ),
              TextInputWidget(
                controller: _passwordController2,
                focusNode: _passwordFocus2,
                labelText: 'Confirm Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                submittedFunc: (string) async {
                  await _register(
                    userNotifier,
                    _emailController.text,
                    _passwordController1.text,
                    _passwordController2.text,
                  ).whenComplete(() {
                    if (userNotifier.currentUser != null) {
                      _resetPage();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (_) => false);
                    }
                  });
                },
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: registerState.registerStatus
                      ? () async {
                          await _register(
                            userNotifier,
                            _emailController.text,
                            _passwordController1.text,
                            _passwordController2.text,
                          ).whenComplete(() {
                            if (userNotifier.currentUser != null) {
                              _resetPage();
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (_) => false);
                            }
                          });
                        }
                      : null,
                  child: const Text('Register'),
                ),
              ),
              const SizedBox(height: 305),
            ],
          ),
        ),
      ),
    );
  }
}
