import 'package:flutter/material.dart';
import 'package:plant_care/screens/screens.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen())),
                      child: const Text('Login'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScreen())),
                      child: const Text('SignUp'),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Text(
                  'Created by Alastair McNeill',
                  style: TextStyle(
                    color: const Color(0xFF3a4d34).withOpacity(0.5),
                    fontFamily: 'HelveticaNeue',
                    fontWeight: FontWeight.w100,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    //   body: Stack(
    //     children: [
    //       //Background image
    //       Container(
    //         decoration: const BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage("assets/images/welcome_background.png"),
    //             fit: BoxFit.cover,
    //             alignment: Alignment.topLeft,
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         left: 0,
    //         right: 0,
    //         bottom: 120,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             SizedBox(
    //               width: 150,
    //               height: 50,
    //               child: ElevatedButton(
    //                 onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen())),
    //                 child: const Text('Login'),
    //               ),
    //             ),
    //             SizedBox(
    //               width: 150,
    //               height: 50,
    //               child: ElevatedButton(
    //                 onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScreen())),
    //                 child: const Text('SignUp'),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Align(
    //         alignment: Alignment.bottomCenter,
    //         child: SafeArea(
    //           child: Text(
    //             'Created by Alastair McNeill',
    //             style: TextStyle(
    //               color: const Color(0xFF3a4d34).withOpacity(0.5),
    //               fontFamily: 'HelveticaNeue',
    //               fontWeight: FontWeight.w100,
    //               fontSize: 12,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
