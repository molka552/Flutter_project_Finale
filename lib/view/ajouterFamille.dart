import 'package:fluterfinale/Comm/NavBar.dart';
import 'package:fluterfinale/Comm/comHelper.dart';
import 'package:fluterfinale/Comm/genTextFormField.dart';
import 'package:fluterfinale/view/HomeForm.dart';
import 'package:flutter/material.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant.dart';

class NewF extends StatefulWidget {
  const NewF({Key? key}) : super(key: key);

  @override
  _NewFState createState() => _NewFState();
}

class _NewFState extends State<NewF> {
  final _formKey = new GlobalKey<FormState>();
  final _myIdController = TextEditingController();
  final _myCategoryNameController = TextEditingController();
  final dbaHelper = DbHelper.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      drawer: NavBar(
      ),
      appBar: AppBar(
        title: Text("Ajouter Famille"),
        backgroundColor: kPrimaryColor,
        elevation: 0.1,
        actions: <Widget>[
          new IconButton(
              onPressed: () {Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => HomeForm()),
                      (Route<dynamic> route) => false);}, icon: Icon(Icons.home, color: Colors.white,))
        ],
      ), body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/m14.svg", height: size.height * 0.45,
                ),
                getTextFormField(controller: _myIdController,
                    hintName: 'Ref famille',
                    icon: Icons.family_restroom),

                getTextFormField(controller: _myCategoryNameController,
                    hintName: 'Nom famille',
                    icon: Icons.family_restroom),

                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      'Enregistrer',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      add();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomeForm()),
                              (Route<dynamic> route) => false);
                    },
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ]
          ),
        ),
      ),
    ),
    );
  }

  Future<void> add() async {
    String id = _myIdController.text;
    String ref = _myCategoryNameController.text;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Map<String, dynamic> row = {
        DbHelper.CategoryId: _myIdController.text,
        DbHelper.CategoryName: _myCategoryNameController.text
      };


      try {
        final id = await dbaHelper.insertCategory(row);
        if (id > 0) {
          alertDialog(context, "Enregitré avec succés");
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomeForm()));
        }
      }
      catch (error) {
        print(error);
        alertDialog(context, "Erreur: échec de l'enregistrement des données");
      }
    }

    @override
    void dispose() {
      _myIdController.dispose();
      _myCategoryNameController.dispose();
      super.dispose();
    }
  }
}








