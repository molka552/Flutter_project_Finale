import 'package:fluterfinale/Comm/comHelper.dart';
import 'package:fluterfinale/Comm/genTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import '../constant.dart';

import 'LoginForm.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class  _SignupFormState extends State<SignupForm> {
  final _formKey = new GlobalKey<FormState>();
  final dbaHelper = DbHelper.instance;

  final _myIdController = TextEditingController();
  final _myNameController = TextEditingController();
  final _myEmailController = TextEditingController();
  final _myPwdController = TextEditingController();
  final _myCPwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(

      body: Form(
        key: _formKey,
        child:
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("S'inscrire",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  SvgPicture.asset(
                    "assets/images/m1.svg", height: size.height * 0.35,
                  ),
                  getTextFormField(
                      controller: _myIdController,
                      icon: Icons.person,
                      hintName: 'User ID'),
                  SizedBox(height: 10.0),
                  //aj
                  getTextFormField(
                      controller: _myNameController,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'Nom'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _myEmailController,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _myPwdController,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),

                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _myCPwdController,
                    icon: Icons.lock,
                    hintName: 'Confirm Password',
                    isObscureText: true,
                  ),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Inscrivez-vous',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        signUp();
                      },
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Avez-vous un compte ? '),
                        FlatButton(
                          textColor: kPrimaryColor,
                          child: Text("S'identifier"),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginForm()),
                                    (Route<dynamic> route) => false);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  signUp(){
    String id=_myIdController.text;
    String name=_myNameController.text;
    String email=_myEmailController.text;
    String password=_myPwdController.text;
    String cpassword=_myCPwdController.text;

    if(id.isEmpty){
      alertDialog(context, "entre votre id");

    } else if(name.isEmpty){
      alertDialog(context, "entre votre nom");

    }else if(email.isEmpty){
      alertDialog(context, "Entre votre email");

    }else if(password.isEmpty){
      alertDialog(context, "Entre votre mot de passe");

    }else if(password !=cpassword){
      alertDialog(context, 'Non concordance des mots de passe');

    } else {
      _insert();
    }
  }
  void _insert() async {
    Map<String,dynamic> row={
      DbHelper.Id : _myIdController.text,
      DbHelper.Name :_myNameController.text,
      DbHelper.Email :_myEmailController.text,
      DbHelper.Password:_myPwdController.text
    };
    try {
      final id = await dbaHelper.insertAdmin(row);
      if (id >0) {
        alertDialog(context, 'Enregistré avec succès');

      }
    }
    catch(error){
      print(error);
      alertDialog(context, "Erreur: échec de l'enregistrement des données");

    }

  }

  @override
  void dispose(){
    _myIdController.dispose();
    _myNameController.dispose();
    _myEmailController.dispose();
    _myPwdController.dispose();
    _myCPwdController.dispose();
    super.dispose();
  }
  }


