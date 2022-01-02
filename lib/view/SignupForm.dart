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
      Fluttertoast.showToast(
          msg: "pls enter ID",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
    } else if(name.isEmpty){
      Fluttertoast.showToast(
          msg: "pls enter name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }else if(email.isEmpty){
      Fluttertoast.showToast(
          msg: "pls enter email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }else if(password.isEmpty){
      Fluttertoast.showToast(
          msg: "pls enter password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }else if(password !=cpassword){
      Fluttertoast.showToast(
          msg: "pls verify password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0
      );
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
        Fluttertoast.showToast(
            msg: "successfully saved",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
    catch(error){
      print(error);
      Fluttertoast.showToast(
          msg: "error occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
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


