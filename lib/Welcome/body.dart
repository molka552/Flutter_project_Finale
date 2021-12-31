import 'package:fluterfinale/view/LoginForm.dart';
import 'package:fluterfinale/view/SignupForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant.dart';
import 'backgound.dart';
import 'components/roundedbutton.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bienvenue à gstock",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat2.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              margin: EdgeInsets.all(30.0),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              width: double.infinity,
              child: FlatButton(
                child: Text(
                  'Connexion',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginForm()),
                          (Route<dynamic> route) => false);
                },
              ),
              decoration: BoxDecoration(
                color:  kPrimaryColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            Container(
              margin: EdgeInsets.all(30.0),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              width: double.infinity,
              child: FlatButton(
                child: Text(
                  "S'inscrire",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => SignupForm()),
                          (Route<dynamic> route) => false);
                },
              ),
              decoration: BoxDecoration(
                color:  kPrimaryLightColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}