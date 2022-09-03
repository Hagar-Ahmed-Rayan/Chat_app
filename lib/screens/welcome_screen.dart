import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:chatt/components.dart';
import 'package:chatt/screens/login.dart';
import 'package:chatt/screens/regester.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class welcomscreen extends StatefulWidget {
  const welcomscreen({Key? key}) : super(key: key);

  @override
  _welcomscreenState createState() => _welcomscreenState();
}

class _welcomscreenState extends State<welcomscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset('images/logo.png'),
                ),
                Text(
                  'MessageMe',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff2e386b),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            button(
              color: Colors.yellow[900]!,
              title: 'Sign in',
             wid:SignInScreen(),


            ),
            button(
              color: Colors.blue[800]!,
              title: 'register',
                  wid:RegistrationScreen(),


            )
          ],
        ),
      ),
    );
  }
}