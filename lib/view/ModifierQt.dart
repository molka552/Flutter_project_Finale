import 'package:fluterfinale/Comm/NavBar.dart';
import 'package:fluterfinale/Comm/genTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant.dart';

class ModifierQt extends StatefulWidget {
  const ModifierQt({Key? key}) : super(key: key);

  @override
  _ModifierQtState createState() => _ModifierQtState();
}

class _ModifierQtState extends State<ModifierQt> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("Modifier Qt"),
        backgroundColor: kPrimaryColor,
        elevation: 0.1,
        actions: <Widget>[
          new IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/images/m13.svg",
              height: size.height * 0.35,
            ),
            getTextFormField(
                controller: _controller,
                hintName: 'Nom Composant',
                icon: Icons.drive_file_rename_outline),
            SizedBox(height: 10.0),
            Container( //apply margin and padding using Container Widget.
              child: Text("Hello World, Text 4"),
              padding: EdgeInsets.only(left:15)
            ),

            SizedBox(height: 10.0),
            getTextFormField(
                controller: _controller,
                hintName: 'Modifier Qt',
                icon: Icons.family_restroom),
            Container(
              margin: EdgeInsets.all(20.0),
              width: double.infinity,
              child: FlatButton(
                child: Text(
                  'Enregistrer',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

